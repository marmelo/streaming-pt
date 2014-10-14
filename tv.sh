#!/bin/sh

PLAYER="mplayer"
RTMPDUMP="rtmpdump"

TITLES=(
  "RTP 1"
  "RTP 2"
  "SIC"
  "TVI (N/A)"
  "RTP Informacao"
  "SIC Noticias"
  "TVI24 (N/A)"
  "RTP Memoria"
  "RTP Internacional"
  "RTP Madeira"
  "RTP Acores"
  "RTP Africa"
  "ARTV (N/A)"
  "ETV"
  "Euronews"
)

STREAMS=(
  "$RTMPDUMP -r rtmp://ec21.rtp.pt/livetv -W http://www.rtp.pt/play/player.swf -y 2ch5h264 | $PLAYER -"
  "$RTMPDUMP -r rtmp://ec21.rtp.pt/livetv -W http://www.rtp.pt/play/player.swf -y 2ch3h264 | $PLAYER -"
  "$RTMPDUMP -r rtmp://213.13.26.43/live -W http://js.sapo.pt/Assets/Images/ProjectVideo/flash/videojs.swf -y sic | $PLAYER -"
  "echo Not yet..."
  "$RTMPDUMP -r rtmp://ec21.rtp.pt/livetv -W http://www.rtp.pt/play/player.swf -y 2ch64h264 | $PLAYER -"
  "$RTMPDUMP -r rtmp://213.13.26.42/live -W http://js.sapo.pt/Assets/Images/ProjectVideo/flash/videojs.swf -y sicnoticias | $PLAYER -"
  "echo Not yet..."
  "$RTMPDUMP -r rtmp://ec21.rtp.pt/livetv -W http://www.rtp.pt/play/player.swf -y 2ch80h264 | $PLAYER -"
  "$RTMPDUMP -r rtmp://ec21.rtp.pt/livetv -W http://www.rtp.pt/play/player.swf -y 2ch120h264 | $PLAYER -"
  "$RTMPDUMP -r rtmp://ec21.rtp.pt/livetv -W http://www.rtp.pt/play/player.swf -y 2ch1016h264H14 | $PLAYER -"
  "$RTMPDUMP -r rtmp://ec21.rtp.pt/livetv -W http://www.rtp.pt/play/player.swf -y 2rtpacores | $PLAYER -"
  "$RTMPDUMP -r rtmp://ec21.rtp.pt/livetv -W http://www.rtp.pt/play/player.swf -y 2ch27h264 | $PLAYER -"
  "echo Not yet..."
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
