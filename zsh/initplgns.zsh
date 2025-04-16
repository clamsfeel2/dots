#!/bin/zsh

typeset -A repos=(
	'zsh-syntax-highlighting' 'https://github.com/zsh-users/zsh-syntax-highlighting.git'
	'fzf-tab'                 'https://github.com/Aloxaf/fzf-tab.git'
	'zsh-autosuggestions'     'https://github.com/zsh-users/zsh-autosuggestions.git'
	'zsh-vi-mode'             'https://github.com/jeffreytse/zsh-vi-mode.git'
)

plugins_dir="plugins"
files_to_remove=(.git .github .gitignore)

if [[ -d "$plugins_dir" ]]; then
	echo -e "\e[31m${(C)plugins_dir} directory exists...\e[0m"
	exit 1
else
	mkdir "$plugins_dir"
fi
cd "$plugins_dir" || exit 1

for repo_name repo_url in ${(kv)repos}; do
	if git clone --quiet "$repo_url"; then
		for file in $files_to_remove; do
			rm -rf "$repo_name/$file"
		done
		echo -e "\e[32mSuccessfully cloned \e[1m$repo_name\e[0m"
	else
		echo -e "\e[31mFailed to clone \e[1m$repo_name\e[0m"
	fi
done
