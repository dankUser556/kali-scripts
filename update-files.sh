#!/bin/bash

DBIN="${HOME}/dbin";
REPO_ROOT="${HOME}/my-github/kali-scripts";
REPO_DBIN="${REPO_ROOT}/dbin";
REPO_HOME="${REPO_ROOT}/home";

function update_files() {
  for file in $2/*; do
    if [[ ! -f "$file" ]]; then
      echo $file not a file.
      continue;
    fi;
  
    local fname=$(basename $file);
    local f_source=$1/${fname};
    local f_dest=$2/${fname};
  
    diff $f_source $f_dest && echo File $fname unchanged. && continue;

    local confirm_action='';
    while [[ -z "$confirm_action" ]]; do
      printf "Copy %s to %s?\n:" ${f_source} ${f_dest};
      read confirm_action;
      case $confirm_action in
        y|yes) echo "cp $f_source $f_dest";;
        n|no) echo Ignoring $fname;;
        *) echo Invalid response. Try again.; confirm_action='';;
      esac;
    done;
  done;
};

update_files $HOME $REPO_HOME;
update_files $DBIN $REPO_DBIN;
