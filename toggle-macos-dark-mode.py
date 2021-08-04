# reference from https://stefan.sofa-rockers.org/2018/10/23/macos-dark-mode-terminal-vim/
import subprocess

OSASCRIPT = """
tell application "System Events"
    tell appearance preferences
        set dark mode to {mode}
    end tell
end tell

tell application "Terminal"
    set default settings to settings set "{theme}"
end tell

tell application "Terminal"
    set current settings of tabs of windows to settings set "{theme}"
end tell
"""

TERMINAL_THEMES = {
    False: 'Rasta light',
    True: 'Rasta',
}

def is_dark_mode() -> bool:
    """Return the current Dark Mode status."""
    result = subprocess.run(
        ['defaults', 'read', '-g', 'AppleInterfaceStyle'],
        text=True,
        capture_output=True,
    )
    return result.returncode == 0 and result.stdout.strip() == 'Dark'

def set_interface_style(dark: bool):
    """Enable/disable dark mode."""
    mode = 'true' if dark else 'false'  # mode can be {true, false, not dark}
    script = OSASCRIPT.format(mode=mode, theme=TERMINAL_THEMES[dark])
    result = subprocess.run(
        ['osascript', '-e', script],
        text=True,
        capture_output=True,
    )
    assert result.returncode == 0, result

if __name__ == '__main__':
    set_interface_style(not is_dark_mode())
