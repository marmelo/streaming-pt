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
  "Nova Era"
  "Orbital"
  "Oxigénio"
  "Radar"
  "Renascenca"
  "RFM"
  "RUC"
  "Smooth"
  "TSF"
)

STREAMS=(
  "https://streaming-live.rtp.pt/liveradio/antena180a/playlist.m3u8"
  "https://streaming-live.rtp.pt/liveradio/antena280a/playlist.m3u8"
  "https://streaming-live.rtp.pt/liveradio/antena380a/playlist.m3u8"
  "https://mcrwowza6.mcr.iol.pt/cidade/smil:cidade.smil/playlist.m3u8"
  "https://mcrwowza3.mcr.iol.pt/comercial/smil:comercial.smil/playlist.m3u8"
  "http://162.210.196.217:8070/stream.mp3"
  "http://mcrwowza5.mcr.iol.pt/m80/smil:m80.smil/playlist.m3u8"
  "http://20133.live.streamtheworld.com:3690/MEGA_HITSAAC"
  "http://centova.radios.pt/proxy/495"
  "http://centova.radios.pt:9478"
  "http://centova.radios.pt:8401"
  "https://proic1.evspt.com/oxigenio_aac"
  "https://proic1.evspt.com/radar_aac"
  "http://20723.live.streamtheworld.com:3690/RADIO_RENASCENCAAAC"
  "http://20133.live.streamtheworld.com:3690/RFMAAC"
  "http://ruc.midi-club.net:8000/"
  "http://mcrwowza3.mcr.iol.pt/smooth/smil:smooth.smil/playlist.m3u8"
  "http://tsfdirecto.tsf.pt/tsfdirecto.aac"
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
