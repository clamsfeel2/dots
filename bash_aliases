shopt -s expand_aliases # Allow non-interactive shells to use aliases

### BASIC CMD STUFF ###
alias l="lsd -l --group-directories-first"
alias la="lsd -lA --group-directories-first"
alias lsa="lsd -A --group-directories-first"
alias ls="lsd --group-directories-first"
alias lss="ls -l --group-directories-first --total-size"
alias lass="ls -lA --group-directories-first --total-size"
alias grep="grep -C 3 -n --color=auto"
alias mv="mv -iv"
# Not the best idea aliasing rm, but the function helps, I think.
alias rm="ask_if_rm_or_trashput"
alias cp="cp -rv"
alias diff="icdiff --report-identical-files --line-numbers --whole-file"
alias pwdc="pwd | wl-copy --trim-newline"
alias wlc="wl-copy"
alias cat="bat --paging=never --style=plain,header" # Make cat a bat
alias e="fc -e ${EDITOR}" # Edit previous command in $EDITOR
alias rnightlight="pkill wl-gammarelay && hyprctl dispatch exec wl-gammarelay" # To fix night-light
alias rwaybar="pkill waybar ; hyprctl dispatch exec waybar" # To restart waybar
alias zathura="zathura 2>/dev/null" # To silence gtk warnings when using zathura
alias speak="espeak -p60 -g9 -k20 -v mb-us1" # To make computer speak
alias say="spd-say --wait $@" # To make computer speak, better voice
alias listaliases="bat ~/.bash_aliases" # To list all aliases with bat
alias ea="vim ~/.bash_aliases" # Edit aliases real ez
alias penv="python -m venv build" # Creates virtual env for python
alias activate="source build/bin/activate" # Activates virual env
alias wifiqr="nmcli device wifi show-password" # Show QR code for wifi in terminal
alias clipclear="cliphist wipe" # Clear clipboard
alias help="bathelp" # Creates colored output for --help, I have not figured out colored man pages yet
alias tb="(exec 3<>/dev/tcp/termbin.com/9999; \cat >&3; \cat <&3; exec 3<&-) && echo 'add l.termbin for color'" # Pastebin alternative cat into it. put a l.termbin to get the color in the output.
alias scanclam="sudo clamscan -rv --move=$HOME/.clamfound --exclude-dir=$HOME/Mollusk/Media/Graphene/.SeedVaultAndroidBackup/ --exclude-dir=$HOME/Mollusk/Media/Graphene/Phone/ /"
alias rd="ripdrag" # Use ripdrag easier
alias td="tmux detach-client" # To detach tmux session
alias ta="tmux attach-session" # To re-attach a tmux session
alias rg="rg -C 3 -n" # Ripgrep helper
alias fzfremove="pacman -Qq | fzf --cycle --reverse --multi --preview 'pacman -Qi {1}' | xargs -ro sudo pacman -Rns" # Run sudo pacman -Qi in fzf to remove packages

### TRASH-CLI HELPERS ###
alias tp="trash-put" # Using trash-put easier
alias tl="trash-list" # Easier way to show what is in trash
alias trest="trash-restore" # Restore trashed files easier
alias te="trash-empty" # Empty trash 

### PACMAN HELPERS ###
alias updatemirrors="reflector --protocol https --verbose --latest 25 --sort rate --save /etc/pacman.d/mirrorlist && paru -Syyuu" # Update pacman mirrors
alias cleancache="paccache -r" # Clean pacman cache
alias cleancacheall="paccache -ruk0" # Clean all pacman cache
alias cleanorph="sudo pacman -Qdtq | sudo pacman -Rns -" # Clean all orphan packages

### NAVIGATION HELPERS ###
alias cd="cdls -ls"
alias cdh="cdls"
alias ..="cd .."
alias ....="cd ../.."
alias ......="cd ../../.."
alias ........="cd ../../../.."

### GRC COLORING HELPERS ###
alias blkid='grc blkid'
alias df='grc df'
alias du='grc du'
alias env='grc env'
alias free='grc free'
alias fdisk='grc fdisk'
alias findmnt='grc findmnt'
alias make='grc make'
alias gcc='grc gcc'
alias g++='grc g++'
alias id='grc id'
alias ip='grc ip'
alias journalctl='grc journalctl'
alias ld='grc ld'
alias lsof='grc lsof'
alias lsblk='grc lsblk'
alias lspci='grc lspci'
alias netstat='grc netstat'
alias ping='grc ping'
alias ss='grc ss'
alias mount='grc mount'
alias ps='grc ps'
alias ifconfig='grc ifconfig'

## FUNCTIONS ##
### MISC ###
pdflatex() { if command pdflatex "$@"; then if [[ -d log ]]; then \mv *.aux *.log *.out log; else mkdir log && \mv *.aux *.log *.out log; fi; fi }
empty() { truncate -s 0 "$1" && cat "$1"; }
bathelp() { set -o pipefail; "$@" --help 2>&1 | bat --plain --language=cmd-help; }
mux() { if [[ -z "$1" ]]; then tmux; else tmux new-session -s "$1"; fi; }
r() { executable=$(find . -maxdepth 1 -type f -executable); if [[ -n "$executable" ]]; then $executable "$@"; else echo "Executable not found."; fi; }
ask_if_rm_or_trashput() {
	if [[ $# -eq 0 ]]; then echo "rm: missing operand" && return 1; fi
	local force_remove=false
	local file=""
	local args=("$@")
	if [[ "${args[0]}" == "-rf" || "${args[0]}" == "-f" ]]; then
		force_remove=true
		args=("${args[@]:1}")  # Remove the first argument (-rf or -f)
	fi
	for file in "${args[@]}"; do
		if ! [[ -e "$file" ]]; then
			echo "rm: cannot remove '$file': No such file or directory"
			return 1
		fi
	done
	printf "\e[1;36mUse trash-put instead?:\e[0m "
	read -r ans
	if [[ -n "$ans" && "$ans" == [Nn]* ]]; then
		if "$force_remove"; then
			printf "forcefully "
			\rm -rfv "${args[@]}"
		else
			\rm -rv "${args[@]}"
		fi
	else
		trash-put "${args[@]}"
		echo "trashed '${args[@]}'"
	fi
}
recterm() {
	if [[ "$#" -lt 2 ]]; then
		echo "rec_term: missing operand\n   usage: rec_term filename.case filename.gif"
		return 1
	fi
	asciinema rec "$1"
	agg --theme 353c4a,ffffff,3B4252,BF616A,A3BE8C,EBCB8B,81A1C1,B48EAD,88C0D0,E5E9F0 --font-family "JetBrainsMono Nerd Font, JetBrainsMono NF" --font-size 30 --speed 2 "$1" "$2"
}
updateme() {
	sudo -v
	if [[ $? -eq 0 ]]; then
		printf "\e[1;33mParu: \n\e[0m"
		env -i PATH="$PATH" paru -Syuu
		printf "\n\e[1;33mPipx: \n\e[0m"
		pipx upgrade-all
		printf "\e[1;33mFlatpak: \n\e[0m"
		flatpak update
	else
		printf "\e[1;31mAuthentication failed. Aborting update...\n \e[0m"
	fi
}
ex() {
	if [[ -f "$1" ]]; then
		case "$1" in
			*.tar.bz2) tar xvjf "$1" ;;
			*.tar.gz) tar xzvf "$1" ;;
			*.tar.xz) tar xvf "$1" ;;
			*.bz2) bunzip2 "$1" ;;
			*.rar) unrar x "$1" ;;
			*.gz) gunzip "$1" ;;
			*.tar) tar xvf "$1" ;;
			*.tbz2) tar xjvf "$1" ;;
			*.tgz) tar xzf "$1" ;;
			*.zip) unzip "$1" ;;
			*.Z) uncompress "$1" ;;
			*.7z) 7z x "$1" ;;
			*) echo "'$1' cannot be extracted via ex()" ;;
		esac
	else
		echo "ex: missing operand"
	fi
}
list() {
	if [[ $1 =~ ^[0-9]+$ ]] && [[ -z $2 ]]; then
		count=$1 && path=$2
	elif [[ -z $1 ]]; then
		count=1
		path=$(pwd)
		if [[ -n $2 ]]; then path=$2; else path="."; fi
	elif [[ $1 =~ ^[0-9]+$ ]]; then
		count=$1
		path=$(pwd)
	else
		echo -e "Invalid usage\nlist [level#] [path]"
	fi
	tree -h -CFL $count --dirsfirst $path 2> /dev/null
}
### MPV ###
make_playlist() { find $1 -type f \( -name "*.mp3" -o -name "*.flac" -o -name "*.wav" -o -name "*.mp4" -o -name "*.avi" -o -name "*.mkv" \) > $2; }
mpvm() { printf "\033[1;33mPlaying: %s\033[0m\n" "$1" && mpv --no-audio-display --msg-level=all=info --no-resume-playback --term-playing-msg='\e[[1;33mPlaying ${filename}\e[[0m' "$1"; }
mpvp() { printf "\033[1;33mPlaying: %s\033[0m\n" "$1" && mpv --ao=pulse --no-audio-display --msg-level=all=info --term-playing-msg='\e[[1;33mPlaying ${filename}\e[[0m' --playlist="$1"; }

### NAVIGATION HELPERS ###
cdp() { if ! [[ -z $(wl-paste) ]]; then cd $(wl-paste); else return 1; fi }
repos() { cd ~/Documents/Repos/"$1"; }
cdls() {
	if [[ "$1" == "-ls" ]]; then
		if builtin cd "${@:2}"; then
			if [[ "$(pwd)" != "$HOME" ]]; then ls && ! grep -F -q "$(pwd)" ~/.cdbmks && pwd >> ~/.cdbmks; fi
		else
			return 1
		fi
	else
		local chosenPath=$(\cat ~/.cdbmks | fzf --tac --cycle --preview 'tree -C {}' --preview-window=down)
		if [[ -n "$chosenPath" ]]; then cd "$chosenPath"; fi
	fi
	remove_excess_lines
}
remove_excess_lines() {
    local file="$HOME/.cdbmks"
    local numOfLinesInFile=$(wc -l < "$file")
    local numOfLinesToRemove=$((numOfLinesInFile - 9))
    if [[ "$numOfLinesToRemove" -gt 0 ]]; then
        tail -n +$numOfLinesToRemove "$file" > "$file.tmp" && \mv "$file.tmp" "$file"
	fi
}

### GIT ###
gitcommit() { git add "$(git rev-parse --show-toplevel)" && git commit -m "$(gum input)" -m "$(gum write)"; }
gb() { git branch | cut -c 3- | gum choose | xargs git checkout; }

### FZF ###
cdfi() {
	selectedPath=$(find . \( -type d -name .stversions -prune \) -o \( -type d -o -type f \) |
		fzf --cycle --query "$@" --tac --no-sort --preview 'bat --style=numbers --color=always {}' \
		--preview-window follow:75%:down:rounded:nowrap: -1 -q "$1")
    if [[ -n "$selectedPath" ]]; then
		echo "$selectedPath"
		directory="$(dirname "$selectedPath")"
		last_part="$(basename "$selectedPath")"
		echo "directory = $directory"
		echo "last_part = $last_part"
		if [[ -d "$selectedPath" ]]; then cd "$directory/$last_part"; else cd "$directory"; fi
    fi
}
cdf() {
	selectedPath=$(find . \( -name .stversions -prune \) -o -print | fzf -q "$1" --cycle --no-sort --preview 'LS_COLORS="$LS_COLORS" ls --color=always {}' --preview-window down:31%)
	if [[ -n "$selectedPath" ]]; then directory=$(dirname "$selectedPath") && last_part=$(basename "$selectedPath"); fi
	if [[ -d "$selectedPath" ]]; then cd "$directory/$last_part"; else cd "$directory"; fi
}
