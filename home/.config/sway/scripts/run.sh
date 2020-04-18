#!/bin/sh

# Set environment variables for Sway

# Firefox
export MOZ_ENABLE_WAYLAND=1
export MOZ_USE_XINPUT2=1
export MOZ_WEBRENDER=1

# Enable xdg-desktop-portal-wlr
export XDG_CURRENT_DESKTOP=sway

# Fix java on wayland
export _JAVA_AWT_WM_NONREPARENTING=1
export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel'

# Enable qt5 theming and wayland support
export QT_QPA_PLATFORMTHEME=qt5ct
export QT_QPA_PLATFORM=wayland-egl
export QT_WAYLAND_DISABLE_WINDOWDECORATION=1

# Fix redshift on wlroots
export WLR_DRM_NO_ATOMIC=1

# Run sway
sway

# Unset the variables after quitting Sway
unset MOZ_ENABLE_WAYLAND=1
unset MOZ_USE_XINPUT2=1
unset MOZ_WEBRENDER=1
unset _JAVA_AWT_WM_NONREPARENTING=1
unset _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel'
unset QT_QPA_PLATFORMTHEME=qt5ct
unset QT_QPA_PLATFORM=wayland-egl
unset QT_WAYLAND_DISABLE_WINDOWDECORATION=1
unset WLR_DRM_NO_ATOMIC=1
unset XDG_CURRENT_DESKTOP=sway
