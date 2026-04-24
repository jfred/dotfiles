# disable telemetry see: https://cli.github.com/telemetry
export GH_TELEMETRY=false

# switch to a worktree for a branch, creating one if needed
# flags (--prune, --rm, etc.) pass through to git workon
switch-workon() {
  if [[ $# -eq 0 || "$1" == --* ]]; then
    git workon "$@"
    return
  fi

  local branch="$1"
  local wt_path
  wt_path=$(git worktree list --porcelain 2>/dev/null | awk -v b="refs/heads/$branch" '
    /^worktree /{p=$2} /^branch /{if($2==b) print p}')

  if [[ -n "$wt_path" ]]; then
    cd "$wt_path"
  else
    echo "No worktree for '$branch'."
    echo -n "Create one? [y/N] "
    read -r answer
    if [[ "$answer" =~ ^[Yy]$ ]]; then
      git workon "$branch" && wt_path=$(git worktree list --porcelain | awk -v b="refs/heads/$branch" '
        /^worktree /{p=$2} /^branch /{if($2==b) print p}') && cd "$wt_path"
    fi
  fi
}
alias wo='switch-workon'