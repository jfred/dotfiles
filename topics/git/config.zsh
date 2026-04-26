# disable telemetry see: https://cli.github.com/telemetry
export GH_TELEMETRY=false

# switch to a worktree for a branch, creating one if needed
# flags (--prune, --rm, etc.) pass through to git workon
workon-switch() {
  if [[ "$1" == "-" ]]; then
    if [[ -z "$WORKON_PREV" ]]; then
      echo "no previous worktree" >&2
      return 1
    fi
    if [[ ! -d "$WORKON_PREV" ]]; then
      echo "previous worktree no longer exists: $WORKON_PREV" >&2
      WORKON_PREV=""
      return 1
    fi
    local target="$WORKON_PREV"
    WORKON_PREV="$PWD"
    cd "$target"
    return
  fi

  if [[ "$1" == "--done" ]]; then
    local repo_root current_toplevel branch
    repo_root=$(realpath "$(git rev-parse --git-common-dir 2>/dev/null)/..") || { echo "Not in a git repo." >&2; return 1; }
    current_toplevel=$(git rev-parse --show-toplevel 2>/dev/null)
    if [[ "$current_toplevel" == "$repo_root" ]]; then
      echo "error: not inside a worktree" >&2
      return 1
    fi
    branch=$(git branch --show-current 2>/dev/null)
    if [[ -z "$branch" ]]; then
      echo "error: could not determine current brmanch" >&2
      return 1
    fi
    cd "$repo_root" || return
    git workon --rm "$branch" || return
    WORKON_PREV=""
    return
  fi

  if [[ $# -eq 0 || "$1" == --* ]]; then
    git workon "$@"
    return
  fi

  local branch="$1"
  local wt_path
  wt_path=$(git worktree list --porcelain 2>/dev/null | awk -v b="refs/heads/$branch" '
    /^worktree /{p=$2} /^branch /{if($2==b) print p}')

  if [[ -n "$wt_path" ]]; then
    [[ "$wt_path" != "$PWD" ]] && WORKON_PREV="$PWD"
    cd "$wt_path"
  else
    echo "No worktree for '$branch'."
    echo -n "Create one? [y/N] "
    read -r answer
    if [[ "$answer" =~ ^[Yy]$ ]]; then
      git workon "$branch" || return
      wt_path=$(git worktree list --porcelain | awk -v b="refs/heads/$branch" '
        /^worktree /{p=$2} /^branch /{if($2==b) print p}')
      WORKON_PREV="$PWD"
      cd "$wt_path"
    fi
  fi
}
alias wo='workon-switch'

# workon-switch / wo completion: flags, then branch names (worktree branches first)
_workon-switch() {
  local has_rm=false has_prune=false
  local w
  for w in "${words[@]}"; do
    [[ "$w" == "--rm" ]] && has_rm=true
    [[ "$w" == "--prune" ]] && has_prune=true
  done

  # --prune/--done take no further args
  if $has_prune || [[ " ${words[*]} " == *" --done "* ]]; then
    return
  fi

  # complete flags
  if [[ "$cur" == -* || "$PREFIX" == -* ]]; then
    local -a flags=(
      '--rm:remove a worktree'
      '--done:remove current worktree and cd back to main repo'
      '--prune:interactively review and remove worktrees'
    )
    _describe -t flags 'flag' flags
    return
  fi

  # after --rm, only show worktree branches
  if $has_rm; then
    local wt_list
    wt_list=(${${(f)"$(git worktree list --porcelain 2>/dev/null | awk 'BEGIN{n=0} /^$/{n++} n>0 && /^branch refs\/heads\//{sub(/^branch refs\/heads\//, ""); print}')"}})
    _describe -t worktree-branches 'active worktree' wt_list
    return
  fi

  # default: all branches, worktree branches first
  local wt_branches other_branches all_branches wt_list
  wt_list=(${${(f)"$(git worktree list --porcelain 2>/dev/null | awk '/^branch refs\/heads\//{sub(/^branch refs\/heads\//, ""); print}')"}})
  all_branches=(${${(f)"$(git branch --list --format='%(refname:short)' 2>/dev/null)"}})
  wt_branches=()
  other_branches=()
  for b in "${all_branches[@]}"; do
    if (( ${wt_list[(Ie)$b]} )); then
      wt_branches+=("$b")
    else
      other_branches+=("$b")
    fi
  done
  local wt_descs=()
  for b in "${wt_branches[@]}"; do
    wt_descs+=("$b:* $b")
  done
  _describe -t worktree-branches 'active worktree' wt_descs
  _describe -t branches 'branch' other_branches
}
