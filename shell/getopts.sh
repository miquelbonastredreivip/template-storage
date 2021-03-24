#!/bin/sh

OPTSTRING="habcd:e:"

# Test the template with:
# ./getopts.sh -d YYYYMMDD -a -c aaaa bbbb cccc ddd -e "argE  argE2"

help() { ############################################################
cat <<EOF
Usage instructions:

  $0 param1 -abc -d "argD" [ -e argE ] 

{{ script/command description }}

param1
    {{ param1 description }}

-a
    {{ a option description }}

-d argD
    {{ d option and argD description }}

{{ other comments }}

EOF
}

check_options () { ##################################################
  option=""
  while  [ -n "$*" ] ; do  # while arguments list not empty
    getopts "${OPTSTRING}" option
    case "${option}" in
      h)   help ;;
      a)   flag1="a" ;;
      b|c) flag2="${option}" ;;
      d)   argD="${OPTARG}" ;;
      e)   argE="${OPTARG}" ;;
      \?)  # Incorrect option or non-option argument
        if [ "${OPTIND}" -eq 1 ] ; then
          # This means "$1" is a non-option argument

          # We can check for too many arguments...
          # if [ -n "${param}" ] ; then 
          #   error "Too many parameters"
          # fi
          # Or we can acumulate arguments....
          if [ -z "${param}" ] ; then 
            param="$1"
          else
            param="${param};$1"
          fi
          shift
        else
          error "Unknown/Incorrect option"
        fi
        ;;
    esac
    shift "$(($OPTIND - 1))" # Discard processed args
    OPTIND=1                 # Reset getopts
  done

  # Check for mandatory information
  if [ -z "${argD}" ] ; then
    error "You must set -d option"
  fi

  # Check for default values
  if [ -z "${argE}" ] ; then
    argE="default E value"
  fi
}

error_and_help() { ###########################################################
  echo "ERROR: $*"
  echo
  help
  exit -1
}

error_and_exit() { ###########################################################
  echo "ERROR: $*"
  exit -1
}

error() { ###########################################################
  error_and_help "$@"
  #or just echo "ERROR:"
}

#####################################################################
# main ##############################################################
#####################################################################

#####################################################################
# Check for pre-requirements here
#
#if ! [ -f "${NEEDED_FILE}" ] || ! [ -r "${NEEDED_FILE}" ] ; then
#  error "{{ error description }}"
#fi

check_options "$@"

# do some stuff here

echo "flag1:  ${flag1}"
echo "flag2:  ${flag2}"
echo "param:  ${param}"
echo "argD:   ${argD}"
echo "argE:   ${argE}"
