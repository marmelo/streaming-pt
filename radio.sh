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
  "Oxigénio"
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
  "https://mcrwowza5.mcr.iol.pt/comercial/ngrp:comercial.stream_all/playlist.m3u8"
  "http://162.210.196.217:8070/stream.mp3"
  "http://mcrwowza5.mcr.iol.pt/m80/ngrp:m80.stream_all/playlist.m3u8"
  "http://19573.live.streamtheworld.com:3690/MEGA_HITSAAC"
  "http://centova.radios.pt/proxy/495"
  "https://proic1.evspt.com/oxigenio_aac"
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

load_stream(){
  for i in ${!TITLES[@]}
    do
      if [ "${TITLES[i]}" = "$*" ]; then
        # check if dynamic stream
        if [ "${STREAMS[i]:0:2}" = "__" ]; then
          $PLAYER $(${STREAMS[i]})
        else
          $PLAYER ${STREAMS[i]}
        fi
        break
      fi
    done
}

PS3="Which radio do you want to listen? "
if [[ -n "$*" ]]; then
  load_stream "$*"
else
  select radio in "${TITLES[@]}";
  do
    if [[ -n $radio ]]; then
      load_stream $radio
    else
      echo "Invalid selection."
    fi
  done
fi
