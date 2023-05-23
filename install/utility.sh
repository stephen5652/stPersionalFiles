#!/usr/bin/env bash

home_dir=$HOME
bash_profile_path=${HOME}/.bash_profile

install_home=$(
	cd $(dirname $0)
	pwd
)

safe_link() {
	source=$1
	des=$2

	des_dir=${des%/*}
	if [[ ! -d ${des_dir} ]]; then
		echo -e "should make path:${des_dir}"
		mkdir -p ${des_dir}
	fi

	if [[ -d ${des} || -f ${des} ]]; then
		if [[ -L ${des} ]]; then # is link
			echo -e "Warning: link is existed, we remove it:${des}"
			rm ${des}
		else

			time=$(date "+%Y%m%d-%H%M%S")
			echo -e "Warning: file existed ${des} , rename it to ${des}_bak_${time}"
			mv ${des} ${des}_${time}
		fi
	fi

	echo -e "ln -s ${source} ${des}"
	ln -s ${source} ${des}
}

wget_safe_download() {

	url=$1
	dest_path=$2
	remove_if_existed=$3

	if [[ -d ${dest_path} || -f ${dest_path} ]]; then
		if [[ ${remove_if_existed} = true ]]; then
			echo -e "\n File existed, move it to trash firstly: ${dest_path}"
			trash_path=${home_dir}/.Trash

			time_str=$(date "+%Y%m%d-%H%M%S")
			remove_to=$(basename ${dest_path})_bak_${time_str}
			mv ${dest_path} ${remove_to}

			echo -e "\nStart download: ${url}"
			wget ${url} -O ${dest_path}
		else
			echo "\nFile existed, skip downloads: ${url}"
		fi
	else
		echo -e "\nStart download: ${url}"
		wget ${url} -O ${dest_path}
	fi
}

git_safe_download() {
	url=$1
	dest_path=$2
	remove_if_existed=$3

	if [[ -d ${dest_path} || -f ${dest_path} ]]; then
		if [[ ${remove_if_existed} = true ]]; then
			echo -e "\n File existed, move it to trash firstly: ${dest_path}"
			trash_path=${home_dir}/.Trash

			time_str=$(date "+%Y%m%d-%H%M%S")
			remove_to=$(basename ${dest_path})_bak_${time_str}
			mv ${dest_path} ${remove_to}

			echo -e "\nStart download: ${url}"
			git clone ${url} ${dest_path} --depth=1
		else
			echo "\nFile existed, skip downloads: ${url}"
		fi
	else
		echo -e "\nStart download: ${url}"
		git clone ${url} ${dest_path} --depth=1
	fi
}
