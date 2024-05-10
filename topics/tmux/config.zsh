if [[ "${TERM_PROGRAM}" = "tmux" ]]; then
    env_switch() {
        tmux.env_switch $1
    }
fi
