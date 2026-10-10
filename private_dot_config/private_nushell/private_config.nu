# config.nu

if not ('TMUX' in $env) {
 exec tmux new -A -s main
}

$env.PROMPT_COMMAND_RIGHT = {
    job spawn {
        let branch = (git branch --show-current | complete | get stdout | str trim)
        commandline set-prompt --right $"(ansi yellow)($branch)(ansi reset)"
    }
}

# ============ PATH ============ #
use std/util "path add"
path add "~/.local/bin"
path add "~/.local/bin/scripts"

$env.EDITOR = "nvim"

$env.config.edit_mode = "vi"
$env.config.show_banner = false
