#!/bin/bash
# Handy Extract Program
# Modified Lev Lafayette 20201006 for order and LZMA2 xz files
	if [[ -f $1 ]]; then
		case $1 in
			*.gz) gunzip $1 ;;
			*.tar) tar xvf $1 ;;
			*.tgz) tar xvzf $1 ;;
			*.tar.xz) tar xvf $1 ;; 
			*.tar.gz) tar xvzf $1 ;;
			*.bz2) bunzip2 $1 ;;
			*.tar.bz2) tar xvjf $1 ;;
			*.rar) unrar x $1 ;;
			*.tbz2) tar xvjf $1 ;;
			*.zip) unzip $1 ;;
			*.Z) uncompress $1 ;;
			*.7z) 7z x $1 ;;
			*) echo "'$1' cannot be extracted via >extract<" ;;
		esac
	else
	echo "'$1' is not a valid file!"
	fi
