#!/bin/sh

# Set environment variables for Sway

# Firefox
export MOZ_ENABLE_WAYLAND=1
export MOZ_USE_XINPUT2=1
export MOZ_WEBRENDER=1
export MOZ_DBUS_REMOTE=1

# Enable xdg-desktop-portal-wlr
export XDG_CURRENT_DESKTOP=sway
export XDG_SESSION_TYPE=wayland

# Fix java on wayland
export _JAVA_AWT_WM_NONREPARENTING=1
export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel'

# Enable qt5 theming and wayland support
export QT_QPA_PLATFORMTHEME=qt5ct
export QT_QPA_PLATFORM=wayland
export QT_WAYLAND_DISABLE_WINDOWDECORATION=1

# Enable wayland support on clutter
export CLUTTER_BACKEND=wayland

# Fix redshift on wlroots
export WLR_DRM_NO_ATOMIC=1

# Run sway
dbus-run-session sway

# Unset the variables after quitting Sway
unset MOZ_ENABLE_WAYLAND
unset MOZ_USE_XINPUT2
unset MOZ_WEBRENDER
unset MOZ_DBUS_REMOTE
unset _JAVA_AWT_WM_NONREPARENTING
unset _JAVA_OPTIONS
unset QT_QPA_PLATFORMTHEME
unset QT_QPA_PLATFORM
unset QT_WAYLAND_DISABLE_WINDOWDECORATION
unset CLUTTER_BACKEND
unset WLR_DRM_NO_ATOMIC
unset XDG_CURRENT_DESKTOP
