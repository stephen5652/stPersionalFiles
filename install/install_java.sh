#!/usr/bin/env bash

CURRENT_DIR=$(
	cd $(dirname $0)
	pwd
)

source ${CURRENT_DIR}/utility.sh

url_20=https://download.oracle.com/java/20/latest/jdk-20_macos-aarch64_bin.tar.gz

case $(uname -m) in
x86_64)
	url_20=https://download.oracle.com/java/20/latest/jdk-20_macos-x64_bin.tar.gz
	;;
aarch64 | arm64)
	url_20=https://download.oracle.com/java/20/latest/jdk-20_macos-aarch64_bin.tar.gz
	;;
*)
	echo -e "\nCPU type unknown, work failed"
	exit 1
	;;
esac

java_name_20=jdk_20

url_17=https://download.oracle.com/java/17/latest/jdk-17_macos-x64_bin.tar.gz
case $(uname -m) in
x86_64)
	url_17=https://download.oracle.com/java/17/latest/jdk-17_macos-x64_bin.tar.gz
	;;
aarch64 | arm64)
	url_17=https://download.oracle.com/java/17/latest/jdk-17_macos-aarch64_bin.tar.gz
	;;
*)
	echo -e "\nCPU type unknown, work failed"
	exit 1
	;;
esac

java_name_17=jdk_17

install_java() {
	echo -e "\nStart install java"

	java_name=$1
	url_jdk=$2
	java_local_dir=$home_dir/Downloads/jdk_downloads
	if [[ ! -d $java_local_dir ]]; then
		mkdir -p ${java_local_dir}
	fi

	file_local=${java_local_dir}/${java_name}.tar.gz
	dest=${home_dir}/${java_name}
	wget_safe_download ${url_jdk} ${file_local} false

	tmp=${java_local_dir}/${java_name}_temp/
	if [[ -d ${tmp} ]]; then
		rm -rf ${tmp}
	fi

	mkdir -p ${tmp}

	tar -zxf ${file_local} -C ${tmp}
	echo -e "\ncmd: find ${tmp} -maxdepth 1 -name \"jdk*\" -print | head -n 1"
	jdk_dir=$(find ${tmp}/* -maxdepth 1 -name "jdk*" -print | head -n 1)

	echo -e "\nJdk dir:${jdk_dir}"
	if [[ -d ${jdk_dir} ]]; then
		if [[ -d ${dest} ]]; then
			rm -rf ${dest}
		fi

		cp -r ${jdk_dir} $dest
	else
		echo -e "\nFailed, since Jdk dir not found:${jdk_dir}"
	fi

	if [[ -d ${tmp} ]]; then
		rm -rf ${tmp}
	fi
}

env_name="ste_java_env"
source_java_env() {
	java_env_path=${CURRENT_DIR}/../java/java_env
	env_ln=${home_dir}/${env_name}
	# safe_link ${java_env_path} ${env_ln}

	env_str="source \${HOME}/${env_name}"
	if [[ -z $(cat ${bash_profile_path} | grep "${env_str}") ]]; then
		echo -e "should add source str: ${env_str}"
		echo -e "\\n${env_str}" >>${bash_profile_path}
	else
		echo -e "\n had sourced java_env: ${env_str}"
	fi
}

# since java_debug only support jdk_17, so this shell only install jdk17
local_java_debug=${home_dir}/.local/share/nvim/jdtls/java-debug_17
local_lombok=${home_dir}/.local/share/nvim/jdtls/lombok.jar
install_java_debug() {
	echo -e "\nStart install maven"
	brew install maven

	echo -e "\n Start install jdtls"
	brew install jdtls

	echo -e "\n Start install lombok"
	lombok_url="https://projectlombok.org/downloads/lombok.jar"
	wget_safe_download ${lombok_url} ${local_lombok} true

	echo -e "\n Start install java-debug_17"
	java_debug_url="https://github.com/microsoft/java-debug.git"
	git_safe_download ${java_debug_url} ${local_java_debug}
	cd ${local_java_debug}
	echo -e "local_java_debug: ${local_java_debug}"
	./mvnw clean install
}

main_java() {
	echo -e "home:${home_dir}"
	install_java $java_name_17 $url_17
	source_java_env

	source $home_dir/.bash_profile
	install_java_debug

	echo -e "\nWarning: since java-debug only support jdk17, this project has change your JAVA_HOME to jdk17, view your java_env file:\${HOME}/${env_name}"
}

main_java
