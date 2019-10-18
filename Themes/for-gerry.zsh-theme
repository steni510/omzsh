PROMPT=$'%{\e[0;34m%}%B┌[%b%{\e[0m%}%{\e[1;32m%}%n%{\e[1;34m%}:%{\e[0m%}%{\e[0;36m%}%~%{\e[0;34m%}%B]%b%{\e[0m%}
%{\e[0;34m%}%B└%B[%{\e[1;35m%}$(check_exit_code)%{\e[0;34m%}%B]%{\e[0m%}%b%{\e[0;35m%}$(git_prompt_info)$(svn_prompt_info)$(virtualenv_prompt_info)%{\e[0m%} '
RPROMPT=$''

ZSH_THEME_GIT_PROMPT_PREFIX=' <git:('
ZSH_THEME_GIT_PROMPT_SUFFIX=')>'

ZSH_THEME_SVN_PROMPT_PREFIX=' <svn:('
ZSH_THEME_SVN_PROMPT_SUFFIX=')>'

ZSH_THEME_VIRTUALENV_PREFIX=' <virtenv:('
ZSH_THEME_VIRTUALENV_SUFFIX=')>'

function check_exit_code(){
  local LAST_EXIT_CODE=$?
  if [[ $LAST_EXIT_CODE -ne 0 ]]; then
	local EXIT_CODE_PROMPT="%{$fg_bold[red]%}$LAST_EXIT_CODE%{$reset_color%}"
    echo "$EXIT_CODE_PROMPT"
  else  
    echo "$"
  fi
}

svn_prompt_info() {
	svn_get_repo_name2() {
	  if in_svn; then
	    LANG=C svn info | sed -n 's/^Repository\ Root:\ .*\///p'
	  fi
	}
    local rev branch name
    if in_svn; then
        rev=$(svn_get_rev_nr)
        branch=$(svn_get_branch_name)
		name=$(svn_get_repo_name2)
        if [[ $(svn_dirty_choose_pwd 1 0) -eq 1 ]]; then
            echo -n "$ZSH_THEME_SVN_PROMPT_PREFIX$name:$rev*$ZSH_THEME_SVN_PROMPT_SUFFIX"
        else
            echo -n "$ZSH_THEME_SVN_PROMPT_PREFIX$name:$rev$ZSH_THEME_SVN_PROMPT_SUFFIX"
        fi
    fi
}





