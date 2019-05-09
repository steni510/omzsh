PROMPT=$'%{\e[0;34m%}%B┌[%b%{\e[0m%}%{\e[1;32m%}%n%{\e[1;30m%}:%{\e[0m%}%{\e[0;36m%}%~%{\e[0;34m%}%B]%b%{\e[0m%}
%{\e[0;34m%}%B└%B[%{\e[1;35m%}$(check_exit_code)%{\e[0;34m%}%B]$(git_prompt_info)%{\e[0m%}%b '
RPROMPT=$'$FG[024][!%!]%{$reset_color%}'

ZSH_THEME_GIT_PROMPT_PREFIX=' <git:('
ZSH_THEME_GIT_PROMPT_SUFFIX=')>'


function check_exit_code(){
  local LAST_EXIT_CODE=$?
  if [[ $LAST_EXIT_CODE -ne 0 ]]; then
    local EXIT_CODE_PROMPT=''
    EXIT_CODE_PROMPT+="%{$fg_bold[red]%}$LAST_EXIT_CODE%{$reset_color%}"
    echo "$EXIT_CODE_PROMPT"
  else  
    echo "$"
  fi
}



