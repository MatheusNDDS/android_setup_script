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
#[i] Main program strings, lists and variables.
	out_file="$HOME/.cache/temp"
	perms=(
		"android.permission"
		"DUMP"						#1
		"WRITE_SECURE_SETTINGS" 	#2
		"PACKAGE_USAGE_STATS"		#3
		"WRITE_MEDIA_STORAGE"		#4
		"READ_EXTERNAL_STOTAGE"		#5
		"WRITE_EXTERNAL_STOTAGE"	#6
	)
	out_file=".temp"
	apk_list=$(
		if [ -d apks/ ]
		then
			ls apks/
		fi
	)
}
start(){
load_data $* #[i]: Load all program data
	touch $out_file
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
sp_a=($*) #standard arguents alocation
	for i in ${sp_a[@]:1}
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
#	$dpi 280
	$sett global device_name "MotoPhone"
	$sett secure bluetooth_name "MoTooth"
	$sett global private_dns_specifier "dns.adguard.com"
	$sett global private_dns_mode "on"
	$sett secure I’m "Matheus Dias"
	$sett secure qs_auto_tiles 0
	$sett secure sysui_qqs_count 5
	$swtt secure sysui_rounded_content_padding 21
	$sett global window_animation_scale 1.05
	$sett global transition_animation_scale 1.05
	$sett global animator_duration_scale 1.05
}
setup_apps(){
	set_perm "com.foxdebug.acode" 4
	set_perm "io.github.muntashirakon.setedit" 2
	set_perm "com.asdoi.quicktiles" 1 2
	set_perm "com.zacharee1.systemuituner" 1 2
	set_perm "com.cannic.apps.automaticdarktheme" 2 4 5 6
}

#Program Start Function
#[i]: Starts the program after functions, variables and arguments are loaded.
start $*
