PATH="/usr/local/opt/gnu-units/libexec/gnubin:$PATH"

if [[ "${TERM_PROGRAM}" = "iTerm.app" ]]; then
    # setup iterm profile
    declare -A iterm_envs
    # usage: iterm_add_profile name profilename
    iterm_add_env() {
        iterm_envs[${1}]=${2}
    }

    # default iterm env profiles
    iterm_add_env prod prod
    iterm_add_env stg stage
    iterm_add_env test test
    iterm_add_env dev test

    # setup iterm specific env_switch
    env_switch() {
        profile=${iterm_envs[$1]:-Default}
        echo -n -e "\033]50;SetProfile=${profile}\a"
    }
fi
