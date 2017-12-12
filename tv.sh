#!/bin/bash

PLAYER="mplayer"
RTMPDUMP="rtmpdump"

TITLES=(
  "RTP 1"
  "RTP 2"
  "SIC"
  "TVI"
  "RTP 3"
  "SIC Noticias"
  "TVI24"
  "SIC Radical"
  "SIC K"
  "RTP Memoria"
  "RTP Internacional"
  "RTP Madeira"
  "RTP Acores"
  "RTP Africa"
  "ARTV"
  "Porto Canal"
  "Euronews"
  "Kuriakos TV"
)

STREAMS=(
  "$RTMPDUMP -r rtmp://rtppullswf2livefs.fplive.net --live -a rtppullswf2live-live -W http://www.rtp.pt/play/player.swf -y 2ch5h264 | $PLAYER -"
  "$RTMPDUMP -r rtmp://rtppullswf2livefs.fplive.net --live -a rtppullswf2live-live -W http://www.rtp.pt/play/player.swf -y 2ch3h264 | $PLAYER -"
  "$PLAYER http://live.impresa.pt/live/sic/sic540p.m3u8"
  "$PLAYER $(wget http://tviplayer.iol.pt/direto/TVI -O - -o /dev/null | grep videoUrl\ = |cut -d\" -f2|head -n 1)"
  "$RTMPDUMP -r rtmp://rtppullswf2livefs.fplive.net --live -a rtppullswf2live-live -W http://www.rtp.pt/play/player.swf -y 2ch64h264 | $PLAYER -"
  "$PLAYER http://live.impresa.pt/live/sicnot/sicnot540p.m3u8"
  "$PLAYER $(wget http://tviplayer.iol.pt/direto/TVI24 -O - -o /dev/null | grep videoUrl\ = |cut -d\" -f2|head -n 1)"
  "$PLAYER http://live.impresa.pt/live/sicrad/sicrad540p.m3u8"
  "$PLAYER http://live.impresa.pt/live/sick/sick540p.m3u8"
  "$RTMPDUMP -r rtmp://rtppullswf2livefs.fplive.net --live -a rtppullswf2live-live -W http://www.rtp.pt/play/player.swf -y 2ch80h264 | $PLAYER -"
  "$RTMPDUMP -r rtmp://rtppullswf2livefs.fplive.net --live -a rtppullswf2live-live -W http://www.rtp.pt/play/player.swf -y 2ch120h264 | $PLAYER -"
  "$RTMPDUMP -r rtmp://rtppullswf2livefs.fplive.net --live -a rtppullswf2live-live -W http://www.rtp.pt/play/player.swf -y 2ch1016h264H14 | $PLAYER -"
  "$RTMPDUMP -r rtmp://rtppullswf2livefs.fplive.net --live -a rtppullswf2live-live -W http://www.rtp.pt/play/player.swf -y 2rtpacores | $PLAYER -"
  "$RTMPDUMP -r rtmp://rtppullswf2livefs.fplive.net --live -a rtppullswf2live-live -W http://www.rtp.pt/play/player.swf -y 2ch27h264 | $PLAYER -"
  "$PLAYER http://193.126.16.68:1935/livenlin4/mp4:2liveplncleanpub/playlist.m3u8"
  "$RTMPDUMP -r rtmp://213.13.26.13/live -W http://js.sapo.pt/Projects/SAPOPlayer/20161028R1/jwplayer.flash.swf -y portocanal | $PLAYER -"
  "$PLAYER http://euronews-pt-p7-cdn.hexaglobe.net/94ce3a040643007dd3c2950436603334/5a2f43b0/euronews/euronews-euronews-website-web-responsive-2/ewnsabrptpri_por.smil/playlist.m3u8"
  "$PLAYER http://195.22.11.11:1935/ktv/ktv2/playlist.m3u8"
)

# check if dependencies exist
type $PLAYER &>/dev/null || { echo "$PLAYER is not installed"; exit 1; }
type $RTMPDUMP &>/dev/null || { echo "$RTMPDUMP is not installed"; exit 1; }

PS3="Which TV channel do you want to watch? "
select choice in "${TITLES[@]}";
do
  if [[ -n $choice ]]; then
    for i in ${!TITLES[@]}
    do
      if [ "${TITLES[i]}" = "$choice" ]; then
        eval ${STREAMS[i]}
        break
      fi
    done
  else
    echo "Invalid selection."
  fi
done
