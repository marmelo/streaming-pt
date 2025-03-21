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
  "Rádio Douro Nacional"
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
  "http://95.217.75.38:9796/"
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
