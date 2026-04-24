# Git completion configuration
# Ensure aliases and custom git-* commands are included in completion

# zstyle settings can be set before compinit
zstyle ':completion:*:*:git:*' tag-order 'common-commands alias-commands all-commands external-commands'
zstyle ':completion:*:*:git:*' verbose true

# Git alias completions - must be set up after compinit via precmd hook
# This ensures _git-switch and other completion functions are loaded
_setup_git_alias_completions() {
  # Only run once
  [[ -n $_git_alias_completions_done ]] && return
  _git_alias_completions_done=1

  # Remove this hook
  precmd_functions=(${precmd_functions:#_setup_git_alias_completions})

  # Map git aliases to their underlying command completions
  # sw -> switch (branch completion)
  __git-sw_main() { _git-switch "$@" }

  # workon-switch / wo: complete branch names, worktree branches first
  _workon-switch() {
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
  compdef _workon-switch workon-switch
  compdef _workon-switch wo

}

# Register the setup to run once on first prompt (after compinit)
precmd_functions+=(_setup_git_alias_completions)

# git workon: complete --rm flag and branch names (worktree branches for --rm)
# git's completion dispatches to _git_${command} (hyphens replaced with underscores)
_git_workon() {
  local has_rm=false
  local i
  for i in "${words[@]}"; do
    [ "$i" = "--rm" ] && has_rm=true
  done

  case "$cur" in
    --*)
      __gitcomp "--rm"
      ;;
    *)
      if [ "$has_rm" = "true" ]; then
        # only branches with active worktrees (skip the main worktree)
        local wt_branches
        wt_branches="$(git worktree list --porcelain 2>/dev/null | awk 'BEGIN{n=0} /^$/{n++} n>0 && /^branch refs\/heads\//{sub(/^branch refs\/heads\//, ""); print}')"
        if [ -n "$wt_branches" ]; then
          __gitcomp "$wt_branches"
        fi
      else
        __git_complete_refs
      fi
      ;;
  esac
}
