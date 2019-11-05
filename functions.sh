#!/bin/sh

# Functions ==============================================
show_usage(){
        if [ -n "${1+set}" ]; then
                echo ""
                echo "Error found on line "$1;
        fi
        echo -e "Usage: $0 [--from <string | email>] [--to-name <string>] [--to <string | email>] [--smtp-username <string>] [--smtp-password <string>]" 1>&2;
        echo "options:"
        echo -e "\t[--from] Must be a verified email address within AWS SES"
        echo -e "\t[--to-name] User defined string"
        echo -e "\t[--to] A valid email address to send the message to"
        echo -e "\t[--smtp-username] A valid SES SMTP IAM username"
        echo -e "\t[--smtp-password] A valid SESE SMTP IAM password"
        exit 1;
}

resetColours(){
        # reset colours back to normal
        printf "\033\e[0m";
}

# display a message in green with a tick by it
# example
# echoPass "awww yeah"
echoPass(){
  # echo first argument in green
  printf "\e[32m✔ ${1}"
  resetColours
}

# echo pass or fail
# example
# echoIf 1 "Passed"
# echoIf 0 "Failed"
echoIf(){
  if [ $1 == 1 ]; then
    echoPass $2
  else
    echoFail $2
    exit;
  fi
}

# display a message in red with a cross by it
# example
# echoFail "Damn it Chloe!"
echoFail(){
  # echo first argument in red
  printf "\e[31m✘ ${1}\n"
  resetColours
}

# display a message in yellow
# example
# _echo Doing something...
_echo(){
        # echo first argumnet in yellow
        printf "\033[0;33m ${1}\n"
        resetColours
}
