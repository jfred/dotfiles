notify() {
    local msg=${1:-Done}
    if command -v terminal-notifier > /dev/null; then
        terminal-notifier -message ${msg}
    else
        osascript -e "display notification \"${msg}\" with title \"Notify\""
    fi
}
