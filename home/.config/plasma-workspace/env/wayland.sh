#!/bin/sh

# Set environment variables for Sway

# Firefox
export MOZ_ENABLE_WAYLAND=1
export MOZ_USE_XINPUT2=1
export MOZ_WEBRENDER=1
export MOZ_DBUS_REMOTE=1

# Fix java on wayland
export _JAVA_AWT_WM_NONREPARENTING=1
export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel'

# Enable wayland support on clutter
export CLUTTER_BACKEND=wayland
