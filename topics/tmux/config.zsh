if [[ "${TERM_PROGRAM}" = "tmux" ]]; then
    # Terminal color profile helpers
    declare -g -A tmux_envs_fgmap
    declare -g -A tmux_envs_bgmap
    # usage: tmux_add_profile name fgcolor bgcolor
    tmux_add_env() {
        tmux_envs_fgmap[$1]=${2}
        tmux_envs_bgmap[$1]=${3:-default}
    }

    # default tmux env profiles
    tmux_add_env prod white colour52
    tmux_add_env stg color00 colour58
    tmux_add_env test white colour22
    tmux_add_env dev white colour18

    env_switch() {
        fgcolour=${tmux_envs_fgmap[$1]:-default}
        bgcolour=${tmux_envs_bgmap[$1]:-default}
        tmux select-pane -P "bg=${bgcolour},fg=${fgcolour}"
    }
fi
