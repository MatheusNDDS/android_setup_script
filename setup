#!/bin/bash
### Core Functions ###
load_data(){
a=($*)
## REFEREMCES ##
  #Apps
	google="com.google.android"
	moto="com.motorola"
	apk_dir="apks"
	apps_to_remove=(
		"$moto.moto"
		"$moto.help"
		"$moto.timeweatherwidget"
		"$moto.motodisplay"
		"$moto.genie"
		"$moto.brapps"
		"$moto.fmplayer"
		"$moto.ccc.notification"
#		"$google.dialer"
#		"$google.contacts"
#		"$google.apps.messaging"
		"$google.apps.photos"
#		"$google.calendar"
#		"$google.marvin.talkback"
		"$google.apps.youtube.music"
#		"$google.calculator"
		"$google.apps.tachyon"
		"$google.videos"
		"$google.apps.walletnfcrel"
		"$google.apps.googleassistant"
		"$google.projection.gearhead"
		"$google.apps.subscriptions.red"
		"$google.apps.nbu.files"
		"com.facebook.services"
		"com.facebook"
	)
	apps_to_disable=(
		"org.lineageos.recorder"
		"com.simplemobiletools.flashlight"
		"com.ap.transmission.btc"
		"eu.depau.etchdroid"
		"net.imknown.android.forefrontinfo"
		"com.zacharee1.systemuituner"
		"io.github.muntashirakon.setedit"
		"com.android.stk"
	)
	apk_list=$(
		if [ -d $apk_dir/ ]
		then
			ls $apk_dir/
		fi
	)
  #Permissions
	sms_perms="5 6 7 8 9 10 11 12 13 14"
	call_perms=" $sms_perms 15 16 17 18 19 20 21"
	perms=(
		"android.permission"
		"DUMP"						#1
		"WRITE_SECURE_SETTINGS" 	#2
		"PACKAGE_USAGE_STATS"		#3
		"WRITE_MEDIA_STORAGE"		#4
		"READ_EXTERNAL_STOTAGE"		#5
		"WRITE_EXTERNAL_STOTAGE"	#6
		"CAMERA"					#7
		"CALL_PHONE"				#8
		"READ_CONTACTS"				#9
		"WRITE_CONTACTS"			#10
		"READ_SMS"					#11
		"RECEIVE_SMS"				#12
		"RECEIVE_MMS"				#13
		"SEND_SMS"					#14
		"FOREGROUND_SERVICE"		#15
		"GET_ACCOUNTS"				#16
		"PROCESS_OUTGOING_CALLS"	#17
		"READ_CALL_LOG"				#18
		"READ_PHONE_STATE"			#19
		"RECORD_AUDIO"				#20
		"WRITE_CALL_LOG"			#21
	)
  #Termux
	notify_tags=""
	bkp_dir="$HOME/storage/shared/Projetos/Android_Setup"
	out_file=".temp"
	termux_deps=(
		"android-tools"
		"openssh"
		"termux-api"
		"man"
		"exa"
	)

## COMMANDS ##
  #Standard
	rm="rm -rf"
  #Adb Shell
	ash="adb shell"
	sett="$ash settings put"
	dpi="$ash wm density"
  #Package Manager
	pm_grant="$ash pm grant"
	pm_install="adb install"
	app_on="$ash pm enable"
	app_off="$ash pm disable-user"
	app_rm="$ash pm uninstall -k --user 0"
  #Termux
	pm="apt"
	notify="termux-notification $notify_tags --title"
	pmup="$pm update ; $pm upgrade -y"
}
start(){
load_data $*
	touch $out_file
	if [ -z $1 ]
	then
#		termux_setup
		install_apps
		setup_apps
		remove_bloat
		put_settings
	elif [ $1 = "-ts" ]
	then
		termux_setup
	elif [ $1 = "-l" ]
	then
		live_shell
	else
		$1 ${a[@]:1}
	fi
}

### Program Functions ###
#Config functions
setup_apps(){
	set_perm "com.foxdebug.acode" 4
	set_perm "io.github.muntashirakon.setedit" 2
	set_perm "com.asdoi.quicktiles" 1 2
	set_perm "com.zacharee1.systemuituner" 1 2
	set_perm "com.cannic.apps.automaticdarktheme" 2 4 5 6
	set_perm "com.mixplorer" 5 6
#	set_perm "com.android.messaging" $sms_perms
#	set_perm "com.android.dialer" $call_perms
}
put_settings(){
	$sett global device_name "MotoPhone"
	$sett secure bluetooth_name "MoTooth"
	$sett global private_dns_specifier "dns.adguard.com"
	$sett global private_dns_mode "on"
	$sett secure me "Matheus Dias"
	$sett secure qs_auto_tiles 0
#	$sett secure sysui_qqs_count 5
#	$sett secure sysui_rounded_content_padding 21
	$sett global window_animation_scale 1.05
	$sett global transition_animation_scale 1.05
	$sett global animator_duration_scale 1.05
	$sett secure install_non_market_apps 1
	$sett lock_screen_show_silent_notifications 1
	$sett qs_auto_tiles 0
	$sett secure_frp_mode 1
	$sett development_settings_enabled 0
	$sett adb_enabled 1
}

#Process functions
live_shell(){
	while [ 1 ]
	do
		read -p "Live: " cmd
		$cmd
	done
}
remove_bloat(){
	for app in ${apps_to_remove[*]}
	do
		$app_off $app
		$app_rm $app
	done
	for app in ${apps_to_disable[*]}
	do
		$app_off $app
	done
}
termux_setup(){
	$pmup
	for pkg in ${termux_deps[*]}
	do
		$pm install $pkg -y
	done
	termux-setup-storage
	cp -r $bkp_dir/* ~/
	termux-api-start
	$notify "📱: Ambiente Configurado"
}
set_perm(){
sp_a=($*)
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

start $* #Start of the program
