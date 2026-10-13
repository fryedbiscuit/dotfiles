# config.nu
$env.SVDIR = "/data/data/com.termux/files/usr/var/service"
$env.SXHKD_SHELL = "bash"

def wttr [city: string = "balneario_camboriu" --small(-s) ] {
  if $small {
    http get $"https://wttr.in/($city)?format=2"
  } else {
    http get $"https://wttr.in/($city)"
  }
}

def termux-wifi-connectioninfo [] {
  ^termux-wifi-connectioninfo|from json
}
def termux-battery-status [] {
  ^termux-battery-status|from json
}

$env.PROMPT_COMMAND_RIGHT = {
    job spawn {
        let branch = (git branch --show-current | complete | get stdout | str trim)
        commandline set-prompt --right $"(ansi yellow)($branch)(ansi reset)"
    }
}

def ,t [] {
  exec tmux new -A -s main
}

# ========= AUTOSTART ========== #
if not ((ps).name has runsvdir) {
  ^setsid runsvdir $env.SVDIR o+e> "/dev/null"
}

# ============ PATH ============ #
use std/util "path add"
path add "~/.local/bin"
path add "~/.local/bin/scripts"

$env.EDITOR = "nvim"

$env.config.edit_mode = "vi"
$env.config.show_banner = false

# ======== Starship =========== #
mkdir ($nu.data-dir | path join "vendor/autoload")
starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")
