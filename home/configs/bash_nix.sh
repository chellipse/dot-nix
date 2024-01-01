# define a function to check if we're in a git repository
is_git_repo() {
  git rev-parse --is-inside-work-tree >/dev/null 2>&1
}

# define a function to check if the git branch is clean
git_is_clean() {
  if [[ -n $(git status --porcelain) ]]; then
    return 1  # there are uncommitted changes
  else
    return 0  # branch is clean
  fi
}

# function to dynamically set the prompt
set_dynamic_prompt() {
  ps1='\[\e[38;5;2m\]#; nix-shell\[\e[0m\]'

  # add git branch information to the prompt
  if is_git_repo; then
      ps1="${ps1} on \[\e[38;2;0;102;204m\]($(git branch --show-current))\[\e[0m\]"
    # check if git branch is clean and add a message if it is
    if git_is_clean; then
        ps1="${ps1} \[\e[38;2;0;102;204m\][]\[\e[0m\]"
    else
        ps1="${ps1} \[\e[38;2;255;0;0m\][+]\[\e[0m\]"
    fi
  fi

  # add 2nd line
  ps1="${ps1} in \[\e[38;5;2m\]\w \n:;\[\e[0m\] "
}

# set the prompt_command to call our set_dynamic_prompt function
prompt_command="set_dynamic_prompt"

# source alias file
if [ -f $xdg_config_dir/bash_aliases ]; then
    . $xdg_config_dir/bash_aliases
fi
