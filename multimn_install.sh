#!/bin/bash

readonly GRAY='\e[1;30m'
readonly GREEN='\e[1;32m'
readonly YELLOW='\e[1;33m'
readonly CYAN='\e[1;36m'
readonly NC='\e[0m'


function echo_json_upd() {
	echo -e "$1"
	[[ -t 3 ]] && echo -e "{\"message\":\"$(echo "$1" | sed 's/\\e\[[0-9;]*m//g')\",\"retcode\":$2}" >&3
}


echo -e "\n====================================================================================\
         \n   ${GRAY}███╗   ███╗ ██╗   ██╗ ██╗    ████████╗ ██████╗ ${NC}███╗   ███╗███╗   ██╗  \
         \n   ${GRAY}████╗ ████║ ██║   ██║ ██║    ╚══██╔══╝ ╚═██╔═╝ ${NC}████╗ ████║████╗  ██║  \
         \n   ${GRAY}██╔████╔██║ ██║   ██║ ██║       ██║      ██║   ${NC}██╔████╔██║██╔██╗ ██║  \
         \n   ${GRAY}██║╚██╔╝██║ ██║   ██║ ██║       ██║      ██║   ${NC}██║╚██╔╝██║██║╚██╗██║  \
         \n   ${GRAY}██║ ╚═╝ ██║ ╚██████╔╝ ██████╗   ██║    ██████╗ ${NC}██║ ╚═╝ ██║██║ ╚████║  \
         \n   ${GRAY}╚═╝     ╚═╝  ╚═════╝  ╚═════╝   ╚═╝    ╚═════╝ ${NC}╚═╝     ╚═╝╚═╝  ╚═══╝  \
         \n                                ╗ made by ${GREEN}HelioCoin${NC} ╔\
         \n                   Credit: ${YELLOW}Credit for this script to neo3587${NC}\
         \n           Source: ${CYAN}https://github.com/HelioNetwork/HLO-MN${NC}\		 
         \n====================================================================================\
         \n                                                   "

multimn_update=$(curl -s https://raw.githubusercontent.com/HelioNetwork/HLO-MultiMN/main/multimn.sh)

if [[ -f /usr/bin/multimn && ! $(diff -q <(echo "$multimn_update") /usr/bin/multimn) ]]; then
	echo_json_upd "${GREEN}multimn${NC} is already updated to the last version" 0
else
	echo -e "Checking needed dependencies..."
	if [[ ! $(command -v lsof) ]]; then
		echo -e "Installing ${CYAN}lsof${NC}..."
		sudo apt-get install lsof
	fi
	if [[ ! $(command -v curl) ]]; then
		echo -e "Installing ${CYAN}curl${NC}..."
		sudo apt-get install curl
	fi

	if [[ ! -d ~/.multimn ]]; then
		mkdir ~/.multimn
	fi
	touch ~/.multimn/multimn.conf

	update=$([[ -f /usr/bin/multimn ]] && echo "1" || echo "0")

	echo "$multimn_update" > /usr/bin/multimn
	chmod +x /usr/bin/multimn

	if [[ $update == "1" ]]; then
		echo_json_upd "${GREEN}multimn${NC} updated to the last version, pretty fast, right?" 1
	else
		echo_json_upd "${GREEN}multimn${NC} installed, pretty fast, right?" 2
	fi
fi

echo ""