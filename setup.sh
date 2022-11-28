#!/bin/bash
#WSH Core Functions
load_data(){
#command data
#[i]: Main program command shortcuts
	ash="adb shell"
	sett="$ash settings put"
	dpi="$ash wm density"
	pm_grant="$ash pm grant"
	pm_install="adb install"
	rm="rm -rf"
#reference data
#[i]: Main program strings, lists and variables.
	out_file="$HOME/.temp"
	perms=(
		"android.permission"
		"DUMP"
		"WRITE_SECURE_SETTINGS"
		"PACKAGE_USAGE_STATS"
		"WRITE_MEDIA_STORAGE"
	)
	apk_list=$(
		if [ -d apks/ ]
		then
			ls apks/
		fi
	)
}
start(){
load_data $* #[i]: Load all program data
	touch .temp
	if [ -z $1 ]
	then
		install_apps
		setup_apps
		put_settings
	elif [ $1 = "l" ]
	then
		live_shell
	else
		$1
	fi
#{!}: This function contain only commands necessary to configure the program and call the other functions.
}

#Program Functions
#[i]: Break the program into independent steps and create functions for them.
live_shell(){
	while [ 1 ]
	do
		read -p "Live: " cmd
		$cmd
	done
}
set_perm(){
args=($*) #standard arguents alocation
	for i in ${args[@]:1}
	do
		$pm_grant $1 "${perms[0]}.${perms[$i]}" 2> $out_file
		echo "[$1 : ${perms[$i]}]"
	done
}
install_apps(){
	cd apks
	for i in ${apk_list[*]}
	do
		$pm_install "$i"
	done
	cd ..
	$rm apks/
}
put_settings(){
	$dpi 279
	$sett secure "bluetooth_name" "MoTooth"
	$sett global "private_dns_specifier" "dns.adguard.com"
	$sett global "private_dns_mode" "on"
	$sett global "device_name" "MotoPhone"
}
setup_apps(){
	set_perm "com.foxdebug.acode" 4
	set_perm "io.github.muntashirakon.setedit" 2
	set_perm "com.asdoi.quicktiles" 1 2
	set_perm "com.zacharee1.systemuituner" 1 2
}

#Program Start Function
#[i]: Starts the program after functions, variables and arguments are loaded.
start $*
