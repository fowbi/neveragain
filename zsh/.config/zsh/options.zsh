# If I'm on an older version of ZSH, I don't want an error message.
# This only sets options that exist.
setopt_if_exists() {
  if [[ "${options[$1]+1}" ]]; then
    setopt "$1"
  fi
}

# "Oh-my-zsh"
setopt_if_exists bang_hist
setopt_if_exists extended_history
setopt_if_exists hist_expire_dups_first
setopt_if_exists hist_find_no_dups
setopt_if_exists hist_ignore_all_dups
setopt_if_exists hist_ignore_dups
setopt_if_exists hist_ignore_space
setopt_if_exists hist_reduce_blanks
setopt_if_exists hist_save_no_dups
setopt_if_exists hist_verify
setopt_if_exists inc_append_history
setopt_if_exists no_hist_beep
setopt_if_exists no_share_history

unset setopt_if_exists
