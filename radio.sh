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
  "--referrer http://www.rtp.pt https://streaming-live.rtp.pt/liveradio/antena180a/playlist.m3u8"
  "--referrer http://www.rtp.pt https://streaming-live.rtp.pt/liveradio/antena280a/playlist.m3u8"
  "--referrer http://www.rtp.pt https://streaming-live.rtp.pt/liveradio/antena380a/playlist.m3u8"
  "http://mcrwowza5.mcr.iol.pt/cidade/ngrp:cidade.stream_all/playlist.m3u8"
  "http://mcrwowza3.mcr.iol.pt/comercial/ngrp:comercial.stream_all/playlist.m3u8"
  "http://162.210.196.217:8070/stream.mp3"
  "http://mcrwowza5.mcr.iol.pt/m80/ngrp:m80.stream_all/playlist.m3u8"
  "http://19573.live.streamtheworld.com:3690/MEGA_HITSAAC"
  "http://centova.radios.pt/proxy/495"
  "http://centova.radios.pt:8497/stream"
  "http://19573.live.streamtheworld.com:3690/RADIO_RENASCENCAAAC"
  "http://19573.live.streamtheworld.com:3690/RFMAAC"
  "http://ruc.midi-club.net:8000/"
  "http://mcrwowza3.mcr.iol.pt/smooth/ngrp:smooth.stream_all/playlist.m3u8"
  "http://tsfdirecto.tsf.pt/tsfdirecto.aac"
  "-user-agent 'Mozilla/5.0 (X11; Linux x86_64)' http://mcrscast.mcr.iol.pt/vodafone"
  "http://stream.radiozero.pt:8000/zero128.mp3"
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
        $PLAYER ${STREAMS[i]}
        break
      fi
    done
  else
    echo "Invalid selection."
  fi
done
