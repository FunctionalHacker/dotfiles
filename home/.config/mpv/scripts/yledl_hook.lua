-- Copied from https://github.com/pekkarr/mpv-yledl
-- Copyright 2021 Pekka Ristola

-- This program is free software: you can redistribute it and/or modify
-- it under the terms of the GNU General Public License as published by
-- the Free Software Foundation, either version 3 of the License, or
-- (at your option) any later version.
--
-- This program is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.
--
-- You should have received a copy of the GNU General Public License
-- along with this program.  If not, see <https://www.gnu.org/licenses/>.

local msg = require 'mp.msg'
local utils = require 'mp.utils'

local function add_series(data)
  local playlist = { "#EXTM3U" }
  for _, episode in pairs(data) do
    table.insert(playlist, episode["webpage"])
  end
  mp.set_property("stream-open-filename", "memory://" .. table.concat(playlist, "\n"))
end

local function add_single_video(data)
  local flavors = data["flavors"]
  table.sort(flavors, function(a, b) return a["bitrate"] > b["bitrate"] end)
  local best = flavors[1]
  mp.set_property("stream-open-filename", best["url"])
  mp.set_property("file-local-options/force-media-title", data["title"])
  for _, sub in ipairs(data["subtitles"]) do
    local lang = sub["language"]
    msg.verbose("Adding subtitles for " .. lang)
    mp.commandv("sub-add", sub["url"], "auto", sub["category"], lang)
  end
end

mp.add_hook("on_load", 9, function()
  msg.verbose('yle-dl hook')
  local url = mp.get_property("stream-open-filename", "")
  if (url:find("https?://%a+%.yle%.fi/") == 1) or (url:find("https?://yle%.fi/") == 1) then
    local start_time = os.clock()
    local command = { "yle-dl", "--showmetadata", url }
    msg.debug("Running: " .. table.concat(command, ' '))
    local ret = mp.command_native({name = "subprocess",
                                   args = command,
                                   capture_stdout = true,
                                   capture_stderr = false})
    if ret.killed_by_us then
      return
    end
    if (ret.status < 0) or (ret.stdout == nil) or (ret.stdout == "") then
      msg.error("yle-dl failed to parse url")
      return
    end

    local json, err = utils.parse_json(ret.stdout)
    if (json == nil) then
      msg.error("failed to parse JSON: " .. err)
      return
    end
    msg.verbose("yle-dl succeeded")
    msg.debug("running yle-dl took " .. os.clock() - start_time .. " seconds")

    if #json == 1 then
      add_single_video(json[1])
    else
      add_series(json)
    end
  else
    msg.verbose('not an areena url')
  end
end)
