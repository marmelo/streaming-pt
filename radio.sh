#!/bin/bash

PLAYER="mpv"

TITLES=(
  "Antena1"
  "Antena2"
  "Antena3"
  "Cidade FM"
  "Comercial"
  "Kiss FM"
  "M80"
  "Mega Hits"
  "MEO Music"
  "Radar"
  "Renascenca"
  "RFM"
  "RUC"
  "Smooth"
  "TSF"
  "Vodafone"
  "Zero"
)

STREAMS=(
  "$PLAYER --referrer http://www.rtp.pt https://streaming-live.rtp.pt/liveradio/antena180a/playlist.m3u8"
  "$PLAYER --referrer http://www.rtp.pt https://streaming-live.rtp.pt/liveradio/antena280a/playlist.m3u8"
  "$PLAYER --referrer http://www.rtp.pt https://streaming-live.rtp.pt/liveradio/antena380a/playlist.m3u8"
  "$PLAYER rtmp://mcrwowza5.mcr.iol.pt/cidadefmlc/cidadefmlc.sdp" 
  "$PLAYER rtmp://mcrwowza5.mcr.iol.pt/comerciallc/comerciallc.sdp"
  "$PLAYER http://162.210.196.217:8070/stream.mp3"
  "$PLAYER rtmp://mcrwowza3.mcr.iol.pt/m80lc/m80lc.sdp"
  "$PLAYER http://19573.live.streamtheworld.com:3690/MEGA_HITSAAC"
  "$PLAYER http://centova.radios.pt/proxy/495"
  "$PLAYER http://centova.radios.pt:8497/stream"
  "$PLAYER http://19573.live.streamtheworld.com:3690/RADIO_RENASCENCAAAC"
  "$PLAYER http://19573.live.streamtheworld.com:3690/RFMAAC"
  "$PLAYER http://ruc.midi-club.net:8000/"
  "$PLAYER rtmp://mcrwowza6.mcr.iol.pt/smoothlc/smoothlc.sdp"
  "$PLAYER http://tsfdirecto.tsf.pt/tsfdirecto.aac"
  "$PLAYER -user-agent 'Mozilla/5.0 (X11; Linux x86_64)' http://mcrscast.mcr.iol.pt/vodafone"
  "$PLAYER http://stream.radiozero.pt:8000/zero128.mp3"
)

# check if dependencies exist
type $PLAYER &>/dev/null || { echo "$PLAYER is not installed"; exit 1; }

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
