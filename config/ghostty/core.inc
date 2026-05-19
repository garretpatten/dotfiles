### 2. Typography ###
font-family = "MesloLGS Nerd Font"
font-size = 16

### 3. Window & Rendering ###
window-colorspace = display-p3
window-padding-x = 20
window-padding-y = 20
window-padding-balance = true
window-save-state = always
window-step-resize = true
window-new-tab-position = current

### 4. Mac OS Integration ###
macos-titlebar-style = tabs
macos-titlebar-proxy-icon = hidden
macos-option-as-alt = true
macos-window-shadow = false
macos-non-native-fullscreen = true

### 5. Interaction ###
# With tmux: enable `mouse on` in tmux so trackpad scroll is handled by tmux.
# Otherwise Ghostty may send ↑/↓ in alternate screen and zsh uses those for history.
# See docs/themes/README.md (Ghostty → Touchpad scroll).
focus-follows-mouse = true
clipboard-read = allow
confirm-close-surface = false
mouse-shift-capture = true
mouse-hide-while-typing = true

### 6. Keybindings ###
keybind = global:cmd+shift+space=toggle_quick_terminal
keybind = super+d=new_split:right
keybind = super+shift+d=new_split:down
keybind = super+ctrl+h=goto_split:left
keybind = super+ctrl+j=goto_split:bottom
keybind = super+ctrl+k=goto_split:top
keybind = super+ctrl+l=goto_split:right
keybind = super+t=new_tab
keybind = super+w=close_surface
