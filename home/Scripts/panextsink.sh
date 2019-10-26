#!/bin/bash

# Get the pid of the window that is to be moved to the next sink
pid_to_move=$(swaymsg -t get_tree | jq -r '.nodes[]?.nodes[]?.nodes[]?.nodes[]?.nodes[] | select(.focused==true).pid')

# Assign all the sink indices into an array
sink_array=($(pacmd list-sinks | grep index | sed 's/index://' | sed 's/*//' | xargs))

# Get the sink inputs to prepare to be inserted into array of arrays
#  The following raw string format is index sink pid\nindex sink pid
sink_inputs_raw=$(pacmd list-sink-inputs | grep -e index -e sink: -e process.id | sed 's/<[^"]*>//' | sed 's/[^0-9]*//g' | tr '\n' ' ' | xargs | sed 's/\([[:digit:]]*\) \([[:digit:]]*\) \([[:digit:]]*\) /\1 \2 \3\n/g')

# Find the corresponding pid
sink_input_selected_pid=$(echo "$sink_inputs_raw" | grep $pid_to_move)

# Parse the individual values from the info retrieved above
selected_input_index=$(echo $sink_input_selected_pid | awk '{print $1;}')
selected_input_sink=$(echo $sink_input_selected_pid | awk '{print $2;}')
selected_input_pid=$(echo $sink_input_selected_pid | awk '{print $3;}')

len=${#sink_array[@]}

for (( i=0; i<$len; i++ )); do
  if [[ $selected_input_sink == "${sink_array[$i]}" ]]; then
    len_idx=$((len-1))
    if (( $i == $len_idx )); then
      pacmd move-sink-input $selected_input_index ${sink_array[0]}
    else
      pacmd move-sink-input $selected_input_index ${sink_array[$((i+1))]}
    fi
  fi
done
