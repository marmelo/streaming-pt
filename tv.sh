#!/bin/bash

PLAYER="mplayer"
RTMPDUMP="rtmpdump"

TITLES=(
  "RTP 1"
  "RTP 2"
  "SIC"
  "TVI"
  "RTP Informacao"
  "SIC Noticias"
  "TVI24"
  "RTP Memoria"
  "RTP Internacional"
  "RTP Madeira"
  "RTP Acores"
  "RTP Africa"
  "ARTV"
  "ETV"
  "Euronews"
)

STREAMS=(
  "$RTMPDUMP -r rtmp://rtppullswflivefs.fplive.net --live -a rtppullswflive-live -W http://www.rtp.pt/play/player.swf -y 2ch5h264 | $PLAYER -"
  "$RTMPDUMP -r rtmp://rtppullswflivefs.fplive.net --live -a rtppullswflive-live -W http://www.rtp.pt/play/player.swf -y 2ch3h264 | $PLAYER -"
  "$RTMPDUMP -r rtmp://213.13.26.43/live -W http://js.sapo.pt/Assets/Images/ProjectVideo/flash/videojs.swf -y sic | $PLAYER -"
  "$PLAYER $(wget http://tviplayer.iol.pt/direto/TVI -O - -o /dev/null | grep videoUrl |cut -d\' -f2)"
  "$RTMPDUMP -r rtmp://rtppullswflivefs.fplive.net --live -a rtppullswflive-live -W http://www.rtp.pt/play/player.swf -y 2ch64h264 | $PLAYER -"
  "$RTMPDUMP -r rtmp://213.13.26.42/live -W http://js.sapo.pt/Assets/Images/ProjectVideo/flash/videojs.swf -y sicnoticias | $PLAYER -"
  "$PLAYER $(wget http://tviplayer.iol.pt/direto/TVI24 -O - -o /dev/null | grep videoUrl |cut -d\' -f2)"
  "$RTMPDUMP -r rtmp://rtppullswflivefs.fplive.net --live -a rtppullswflive-live -W http://www.rtp.pt/play/player.swf -y 2ch80h264 | $PLAYER -"
  "$RTMPDUMP -r rtmp://rtppullswflivefs.fplive.net --live -a rtppullswflive-live -W http://www.rtp.pt/play/player.swf -y 2ch120h264 | $PLAYER -"
  "$RTMPDUMP -r rtmp://rtppullswflivefs.fplive.net --live -a rtppullswflive-live -W http://www.rtp.pt/play/player.swf -y 2ch1016h264H14 | $PLAYER -"
  "$RTMPDUMP -r rtmp://rtppullswflivefs.fplive.net --live -a rtppullswflive-live -W http://www.rtp.pt/play/player.swf -y 2rtpacores | $PLAYER -"
  "$RTMPDUMP -r rtmp://rtppullswflivefs.fplive.net --live -a rtppullswflive-live -W http://www.rtp.pt/play/player.swf -y 2ch27h264 | $PLAYER -"
  "$PLAYER rtsp://www.canal.parlamento.pt/Live"
  "$RTMPDUMP -r rtmp://213.13.26.43/live -W http://js.sapo.pt/Assets/Images/ProjectVideo/flash/videojs.swf -y etv_direto | $PLAYER -"
  "$RTMPDUMP -r rtmp://fr-par-3.stream-relay.hexaglobe.net:1935/rtpeuronewslive -W http://pt.euronews.com/media/player_live_1_14.swf -y pt_video750_rtp.sdp | $PLAYER -"
)

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
