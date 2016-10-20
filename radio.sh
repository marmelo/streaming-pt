#!/bin/bash

PLAYER="mplayer"
RTMPDUMP="rtmpdump"

TITLES=(
  "Antena1"
  "Antena2"
  "Antena3"
  "Cidade FM"
  "Comercial"
  "Kiss FM"
  "M80"
  "Mega Hits"
  "Renascenca"
  "RFM"
  "RUC"
  "Smooth"
  "Sudoeste"
  "TSF"
  "Vodafone"
  "Radio Zero"
)

STREAMS=(
  "$RTMPDUMP -r rtmp://ec24.rtp.pt/liveradio -y antena180a | $PLAYER -"
  "$RTMPDUMP -r rtmp://ec24.rtp.pt/liveradio -y antena280a | $PLAYER -"
  "$RTMPDUMP -r rtmp://ec24.rtp.pt/liveradio -y antena380a | $PLAYER -"
  "$RTMPDUMP -r rtmp://mcrwowza5.mcr.iol.pt/cidadefmlc -y cidadefmlc.sdp | $PLAYER -" 
  "$RTMPDUMP -r rtmp://mcrwowza5.mcr.iol.pt/comerciallc -y comerciallc.sdp | $PLAYER -"
  "$PLAYER http://cp5.serverse.com:7104/"
  "$RTMPDUMP -r rtmp://mcrwowza3.mcr.iol.pt/m80lc -y m80lc.sdp | $PLAYER -"
  "$PLAYER http://7719.live.streamtheworld.com/MEGA_HITSAAC"
  "$PLAYER http://7719.live.streamtheworld.com/RADIO_RENASCENCAAAC"
  "$PLAYER http://7719.live.streamtheworld.com/RFMAAC"
  "$PLAYER http://ruc.midi-club.net:8000/"
  "$RTMPDUMP -r rtmp://mcrwowza6.mcr.iol.pt/smoothlc -y smoothlc.sdp | $PLAYER -"
  "$RTMPDUMP -r rtmp://live.livextend.com/liveswtmn -y swtmns1 | $PLAYER -"
  "$PLAYER http://tsfdirecto.tsf.pt/tsfdirecto.aac"
  "$PLAYER -user-agent 'Mozilla/5.0 (X11; Linux x86_64)' http://mcrscast.mcr.iol.pt/vodafone"
  "$PLAYER http://stream.radiozero.pt:8000/zero128.mp3"
)

PS3="Which radio do you want to listen? "
select radio in "${TITLES[@]}";
do
  if [[ -n $radio ]]; then
    for i in ${!TITLES[@]}
    do
      if [ "${TITLES[i]}" = "$radio" ]; then
        eval ${STREAMS[i]}
        break
      fi
    done
  else
    echo "Invalid selection."
  fi
done
