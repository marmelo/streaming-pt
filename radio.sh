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
  "Rádio Clube de Lamego"
  "Rádio Douro Nacional"
)

STREAMS=(
  "https://streaming-live.rtp.pt/liveradio/antena180a/playlist.m3u8"
  "https://streaming-live.rtp.pt/liveradio/antena280a/playlist.m3u8"
  "https://streaming-live.rtp.pt/liveradio/antena380a/playlist.m3u8"
  "https://stream-hls.bauermedia.pt/cidade.aac/playlist.m3u8"
  "https://stream-hls.bauermedia.pt/comercial.aac/playlist.m3u8"
  "https://nl.digitalrm.pt:8024/stream"
  "https://stream-hls.bauermedia.pt/m80.aac/playlist.m3u8"
  "https://28553.live.streamtheworld.com/MEGA_HITSAAC.aac"
  "http://centova.radios.pt/proxy/495"
  "http://centova.radios.pt:9478"
  "http://centova.radios.pt:8401"
  "https://proic1.evspt.com/oxigenio_aac"
  "https://proic1.evspt.com/radar_aac"
  "https://28933.live.streamtheworld.com/RADIO_RENASCENCAAAC.aac"
  "https://22353.live.streamtheworld.com/RFMAAC.aac"
  "https://stream.ruc.pt/high"
  "https://stream-hls.bauermedia.pt/smooth.aac/playlist.m3u8"
  "http://tsfdirecto.tsf.pt/tsfdirecto.aac"
  "http://109.71.41.6:8110/stream"
  "https://sp0.redeaudio.com/9796/stream"
)

# check if dependencies exist
type $PLAYER &>/dev/null || { echo "$PLAYER is not installed"; exit 1; }

if [ "$DEBUG" = "true" ]; then
  PS3="Digite o nº da rádio que deseja ouvir: "
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
else
  # Main loop to display the menu consistently with colors
  while true; do
    # Clear the screen and display the channel list with colors and aligned numbers
    clear
    echo -e "\e[32mRádios disponíveis:\e[0m"
    for j in "${!TITLES[@]}"; do
      if [ "$j" -lt 9 ]; then
        # Add an extra space before single-digit numbers (1-9)
        echo -e "\e[37m $((j+1)). ${TITLES[j]}\e[0m"
      else
        # No extra space for two-digit numbers (10+)
        echo -e "\e[37m$((j+1)). ${TITLES[j]}\e[0m"
      fi
    done
    echo

    # Prompt user for input
    read -p "Digite o nº da rádio que deseja ouvir (ou 'x' para sair): " choice

    # Check if user wants to exit
    if [[ "$choice" == "x" || "$choice" == "X" ]]; then
      echo -e "\e[33mA sair...\e[0m"  # Yellow for exit message
      exit 0
    fi

    # Convert choice to array index (subtract 1 since list starts at 1)
    index=$((choice - 1))

    # Check if the choice is a valid index
    if [[ "$choice" =~ ^[0-9]+$ ]] && [ "$index" -ge 0 ] && [ "$index" -lt "${#TITLES[@]}" ]; then
      # Check if stream is dynamic
      if [ "${STREAMS[index]:0:2}" = "__" ]; then
        $PLAYER --user-agent="$USER_AGENT" $(${STREAMS[index]}) > /dev/null 2>&1
      else
        $PLAYER --user-agent="$USER_AGENT" ${STREAMS[index]} > /dev/null 2>&1
      fi
    else
      echo -e "\e[31mSeleção inválida.\e[0m"  # Red for invalid selection
      sleep 1  # Pause briefly to let the user see the message
    fi
  done
fi
