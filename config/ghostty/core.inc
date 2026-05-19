### Window & Rendering (split-layout optional include; mirrored in config)
window-colorspace = display-p3
window-padding-x = 20
window-padding-y = 20
window-padding-balance = true
window-save-state = always
window-step-resize = true
window-new-tab-position = current

### Mac OS Integration ###
macos-titlebar-style = tabs
macos-titlebar-proxy-icon = hidden
macos-option-as-alt = true
macos-window-shadow = false
macos-non-native-fullscreen = true

### Interaction ###
# With tmux: use `mouse on` so Ghostty/trackpad scrolling is handled by tmux scrollback instead of emitting arrow keys.
focus-follows-mouse = true
clipboard-read = allow
confirm-close-surface = false
mouse-shift-capture = true
mouse-hide-while-typing = true

### Keybindings ###
keybind = global:cmd+shift+space=toggle_quick_terminal
keybind = super+d=new_split:right
keybind = super+shift+d=new_split:down
keybind = super+ctrl+h=goto_split:left
keybind = super+ctrl+j=goto_split:bottom
keybind = super+ctrl+k=goto_split:top
keybind = super+ctrl+l=goto_split:right
keybind = super+t=new_tab
keybind = super+w=close_surface
