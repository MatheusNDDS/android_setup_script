#!/bin/bash
### Custom props ###
## User variables
google="com.google.android"
fb="com.facebook"
moto="com.motorola"
sms_permissions="5 6 7 8 9 10 11 12 13 14"
call_permissions="$sms_permissions 15 16 17 18 19 20 21"

## lists
apps_to_remove=(
	"$moto.help"
	"$moto.genie"
	"$moto.brapps"
	"$moto.fmplayer"
	"$moto.ccc.notification"
	"$google.calendar"
	"$google.calculator"
	"$google.apps.photos"
	"$google.calendar"
	"$google.calculator"
	"$google.apps.tachyon"
	"$google.apps.podcasts"
	"$google.apps.chromecast.app"
	"$google.apps.fitness"
	"$google.apps.docs.editors.slides"
	"$google.videos"
	"$google.apps.walletnfcrel"
	"$google.apps.googleassistant"
	"$google.projection.gearhead"
	"$google.apps.subscriptions.red"
	"$google.apps.nbu.files"
	"$fb.services"
	"$fb.katana"
	"$fb.appmanager"
	"$fb.system"
)
apps_to_disable=(
	"org.lineageos.recorder"
	"com.simplemobiletools.flashlight"
	"com.ap.transmission.btc"
	"eu.depau.etchdroid"
	"net.imknown.android.forefrontinfo"
	"com.zacharee1.systemuituner"
	"com.android.stk"
	"streetwalrus.usbmountr"
	"net.techet.netanalyzerlite.an"
)
permissions=(
# Permissions for the "set_perm" function.
# You can add whatever permissions you need.
	"android.permission"
	"DUMP" #1
	"WRITE_SECURE_SETTINGS" #2
	"PACKAGE_USAGE_STATS" #3
	"WRITE_MEDIA_STORAGE" #4
	"READ_EXTERNAL_STOTAGE" #5
	"WRITE_EXTERNAL_STOTAGE" #6
	"CAMERA" #7
	"CALL_PHONE" #8
	"READ_CONTACTS" #9
	"WRITE_CONTACTS" #10
	"READ_SMS" #11
	"RECEIVE_SMS" #12
	"RECEIVE_MMS" #13
	"SEND_SMS" #14
	"FOREGROUND_SERVICE" #15
	"GET_ACCOUNTS" #16
	"PROCESS_OUTGOING_CALLS" #17
	"READ_CALL_LOG" #18
	"READ_PHONE_STATE" #19
	"RECORD_AUDIO" #20
	"WRITE_CALL_LOG" #21
	"REQUEST_INSTALL_PACKAGES" #22
	"UPDATE_PACKAGES_WITHOUT_USER_ACTION" #23
)

## Configurations
set_apps(){
	set_perm "com.foxdebug.acode" 4
	set_perm "org.fdroid.fdroid" 22 23
	set_perm "io.github.muntashirakon.setedit" 2
	set_perm "com.asdoi.quicktiles" 1 2
	set_perm "com.zacharee1.systemuituner" 1 2
	set_perm "com.cannic.apps.automaticdarktheme" 2 4 5 6
	set_perm "com.mixplorer" 5 6
	set_perm "org.lineageos.recorder" 19 20
}
put_settings(){
	$sett global device_name "Me7+"
	$sett global private_dns_specifier "dns.adguard.com"
	$sett global private_dns_mode "off"
	$sett global lock_screen_show_silent_notifications 1
	$sett global secure_frp_mode 1
	$sett global charging_sounds_enabled 0
	$sett global settings_systemui_theme true
	$sett global settings_audio_switcher true
	
	$sett secure bluetooth_name "MoTooth"
	$sett secure qs_auto_tiles 0
	$sett secure sysui_qs_tiles '"wifi,cell,bt,rotation,custom(com.asdoi.quicktiles/com.asdoi.quicksettings.tiles.KeepScreenOnTileService),custom(com.asdoi.quicktiles/com.asdoi.quicksettings.tiles.AdaptiveBrightnessTileService),dnd,custom(com.cannic.apps.automaticdarktheme/.services.QSTileService),custom(com.asdoi.quicktiles/com.asdoi.quicksettings.tiles.UsbDebuggingTileService)"'
	$sett secure assistant "ninja.sesame.app.edge/.activities.MainActivity"
	$sett secure enabled_accessibility_services '"com.motorola.actions/com.motorola.actions.splitscreen.accessibilityservice.SplitScreenAccessibilityService"'
	$sett secure install_non_market_apps 1
	$sett secure styleList '"[{"name":"Me7+","font":"com.android.theme.font.barlowsource","color":"com.android.theme.color.green","shape":"Default","grid":"5_by_5"}]"'
	$sett secure appliedStyle "Me7+"
	$sett secure sysui_keyguard_left "com.motorola.camera2/com.motorola.camera.Camera"
	$sett secure camera_double_tap_power_gesture_disabled 1 
	$sett secure camera_double_twist_to_flip_enabled 1
	
	$sett system me "Matheus Dias"
	$sett system settings_seamless_transfer true
	$sett system ring.delay 0
	$sett system wifi.supplicant_scan_interval 120
	$sett system windowsmgr.max_events_per_sec 100
	$sett system ro.config.nocheckin 0
	$sett system policy_control immersive.full=br.com.keywordlabs.biblia_kja,br.com.dlotecnologia.maquinajogosimobiliarios
	
	$sett global development_settings_enabled 0
	$sett global adb_enabled 1
	$sett global zram_enabled 0
	$sett global force_resizable_activities 1
}

### ⚠ Script Functions ###
#** Edit this section carefully **
load_data(){
a=($*)
## REFEREMCES ##
  #Apps
	apk_dir="apks"
	apk_list=$(
		if [ -d $apk_dir/ ]
		then
			ls $apk_dir/
		fi
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
	if [[ -z $1 ]]
	then
#		config_termux
		install_apps
		set_apps
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
live_shell(){
	while [ 1 ]
	do
		read -p "Live|Setup: " cmd
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
config_termux(){
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
		$pm_grant $1 "${permissions[0]}.${permissions[$i]}" 2>> $out_file
		echo "[$1 : ${permissions[$i]}]"
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
