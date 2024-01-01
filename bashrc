# Define a function to check if we're in a Git repository
is_git_repo() {
  git rev-parse --is-inside-work-tree >/dev/null 2>&1
}

# Define a function to check if the Git branch is clean
git_is_clean() {
  if [[ -n $(git status --porcelain) ]]; then
    return 1  # There are uncommitted changes
  else
    return 0  # Branch is clean
  fi
}

# Function to dynamically set the prompt
set_dynamic_prompt() {
  PS1='\[\e[38;5;2m\]#; nix-shell\[\e[0m\]'

  # Add Git branch information to the prompt
  if is_git_repo; then
      PS1="${PS1} on \[\e[38;2;0;102;204m\]($(git branch --show-current))\[\e[0m\]"
    # Check if Git branch is clean and add a message if it is
    if git_is_clean; then
        PS1="${PS1} \[\e[38;2;0;102;204m\][]\[\e[0m\]"
    else
        PS1="${PS1} \[\e[38;2;255;0;0m\][+]\[\e[0m\]"
    fi
  fi

  # add 2nd line
  PS1="${PS1} in \[\e[38;5;2m\]\w \n:;\[\e[0m\] "
}

# Set the PROMPT_COMMAND to call our set_dynamic_prompt function
PROMPT_COMMAND="set_dynamic_prompt"

# source Alias file
if [ -f $XDG_CONFIG_DIR/bash_aliases ]; then
    . $XDG_CONFIG_DIR/bash_aliases
fi
