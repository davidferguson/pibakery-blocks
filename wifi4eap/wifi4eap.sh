#!/bin/bash
# this configures wpa_supplicant.conf
# $1: the county, e.g. DE
# $2: type of network, NONE, WEP, WPA-PSK, WPA-EAP
# $3: SSID of network
# #4: CLEAR,ENCODE,ENCODED write password clear text, encode password, password already encoded
# $5: password
# $6: account (only EAP)
# $7: priority (optional)
# $8: identity (optional)
#
conf=/etc/wpa_supplicant/wpa_supplicant.conf
#
#	header of wpa_supplicant.conf
#
if [ !-f ${conf} ]
then
	echo "country=$1" >>${conf}
	echo "ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev" >>${conf}
	echo "update_config=1" >>${conf}
fi
#
#	network definition
#
echo "network={" >>${conf}
echo "	ssid=\"$3\"" >>${conf}
case "$2" in
	"WPA-EAP")
		echo "	key_mgmt=WPA-EAP" >>${conf}
		echo "	pairwise=CCMP TKIP" >>${conf}
		echo "	group=CCMP TKIP" >>${conf}
		echo "	eap=PEAP" >>${conf}
		echo "	identity=$3" >>${conf}
		case "$4" in
			ENCODED)
				echo "	password=hash:$5" >>${conf}
			;;
			ENCODE)
				echo "	password=hash:"`echo -n "$5" | iconv -t utf16le | openssl md4` >>${conf}
			;;
			*)
				echo "	password=\"$5\"" >>${conf}
			;;
		esac
		echo "	phase2=\"auth=MSCHAPV2\"" >>${conf}
	;;
	"WPA-PSK")
		echo "	key_mgmt=WPA-PSK" >>${conf}
		case "$4" in
			ENCODED)
				echo "	psk=$5" >>${conf}
			;;
			ENCODE)
				echo "	psk="`wpa_passphrase "$2" "$4"` >>${conf}
			;;
			*)
				echo "	psk=\"$5\"" >>${conf}
			;;
		esac
	;;
	"WEP")
		echo "	key_mgmt=NONE" >>${conf}
		echo "	wep-key0=\"$5\"" >>${conf}
	;;
	"NONE")
		echo "	key_mgmt=NONE" >>${conf}
	;;
esac
#	optional arguments priority and id_str
if [ !-z "$7" ]
then
	echo "	priority=$7" >>${conf}
fi
if [ !-z "$8" ]
then
	echo "	id_str=$8" >>${conf}
fi
echo "}" >>${conf}
