#!/bin/bash

DBIN="${HOME}/dbin";
REPO_ROOT="${HOME}/my-github/kali-scripts";
REPO_DBIN="${REPO_ROOT}/dbin";
REPO_HOME="${REPO_ROOT}/home";

function update_files() {
  case $# in
    2)
      local src_dir="$1";
      local dest_dir="$2";
      local search_dir="$2/*";;
    3)
      if [[ "$1" == "-h" ]] || [[ "$1" == "--hidden" ]]; then
	local src_dir="$2";
	local dest_dir="$3";
	local search_dir="$3/.*";
      else
	echo $1 is not an argument.;
	return 0;
      fi;;
  esac;

  for file in $search_dir; do
    if [[ ! -f "$file" ]]; then
      echo $file not a file.
      continue;
    fi;
  
    local fname=$(basename $file);
    local f_source=$src_dir/${fname};
    local f_dest=$dest_dir/${fname};
  
    diff $f_source $f_dest && echo File $fname unchanged. && continue;

    local confirm_action='';
    while [[ -z "$confirm_action" ]]; do
      printf "Copy %s to %s?\n:" ${f_source} ${f_dest};
      read confirm_action;
      case $confirm_action in
        y|yes) echo $f_source -\> $f_dest;
	       echo;
	       cp $f_source $f_dest;;
        n|no) echo Ignoring $fname;;
        *) echo Invalid response. Try again.; confirm_action='';;
      esac;
    done;
  done;
};

update_files -h $HOME $REPO_HOME;
update_files $DBIN $REPO_DBIN;
