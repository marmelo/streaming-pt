#!/bin/bash

# Sets the media player to mpv for streaming
PLAYER="mpv"

# Defines the list of TV channel names for the menu
TITLES=(
  "RTP 1"
  "RTP 2"
  "SIC"
  "TVI"
  "RTP 3"
  "SIC Notícias"
  "CNN Portugal"
  "Euronews"
  "ARTV"  
  "RTP Memória"
  "RTP Madeira"
  "RTP Açores"
  "RTP África"
  "RTP Internacional"
  "TVI Internacional"
  "TVI África"
  "TVI Ficção"
  "TVI Reality"
  "Porto Canal"
  "Kuriakos TV"
)

# Defines URLs or dynamic stream commands corresponding to each channel in TITLES
STREAMS=(
  "--demuxer-lavf-o=cenc_decryption_key=a2226def4bc8f249de2daf36b7c12b1e https://streaming-live.rtp.pt/liverepeater/rtpClean1HD.smil/manifest.mpd"
  "--demuxer-lavf-o=cenc_decryption_key=f1eb56955a79e555b1f8b96aec3afa25 https://streaming-live.rtp.pt/liverepeater/rtpClean2HD.smil/manifest.mpd"
  "https://d1zx6l1dn8vaj5.cloudfront.net/out/v1/b89cc37caa6d418eb423cf092a2ef970/index.m3u8"
  "__tvi"
  "http://streaming-live.rtp.pt/liverepeater/rtpnHD.smil/playlist.m3u8"
  "https://d277k9d1h9dro4.cloudfront.net/out/v1/293e7c3464824cbd8818ab8e49dc5fe9/index.m3u8"
  "__cnnportugal"
  "https://euronews-live-por-pt.fast.rakuten.tv/v1/manifest/0547f18649bd788bec7b67b746e47670f558b6b2/production-LiveChannel-6572/7392d4f0-7e24-4dbe-8482-f165e712eeed/5.m3u8"
  "https://playout175.livextend.cloud/livenlin4/2liveartvpub2/playlist.m3u8"  
  "__rtp rtpmemoria"
  "__rtp rtpmadeira"
  "__rtp rtpacores"
  "__rtp rtpafrica"
  "__rtp rtpinternacional"
  "__tviint"
  "https://video-auth4.iol.pt/live_tvi_africa/live_tvi_africa/edge_servers/tviafrica-480p/playlist.m3u8"
  "https://video-auth1.iol.pt/live_tvi_ficcao/live_tvi_ficcao/edge_servers/tvificcao-720p/playlist.m3u8"
  "https://video-auth4.iol.pt/live_tvi_reality/live_tvi_reality/edge_servers/tvireality-720_passthrough/playlist.m3u8"
  "https://pull-live-156-1.global.ssl.fastly.net/pc5865dc25400thmb-ea6bf03b14fa318f7133/pc1-jhrgyuoqe5865db-68tkgb14fa318f7133f03.smil/playlist.m3u8"
  "https://w1.manasat.com/ktv/ktv.smil/playlist.m3u8"
)

# Decodes URL-encoded strings (e.g., %20 to spaces)
# As seen at https://stackoverflow.com/a/37840948
function urldecode() { : "${*//+/ }"; echo -e "${_//%/\\x}"; }

# Functions to fetch dynamic stream URLs for specific channels
__rtp() { urldecode $(wget https://www.rtp.pt/play/direto/$1 -O - -o /dev/null | grep hls | sed 's/.*hls: //g' | sed 's/, dash.*//g' | sed 's/.*\[//g' | sed 's/\].*//g' | sed 's/[",]//g'); }
__tvi() { echo "https://video-auth6.iol.pt/live_tvi/live_tvi/playlist.m3u8?wmsAuthSign=$(wget https://services.iol.pt/matrix?userId= -o /dev/null -O -)"; }
__cnnportugal() { echo "https://video-auth6.iol.pt/live_cnn/live_cnn/playlist.m3u8?wmsAuthSign=$(wget https://services.iol.pt/matrix?userId= -o /dev/null -O -)"; }
__tviint() { echo "https://video-auth6.iol.pt/live_tvi_internacional/live_tvi_internacional/playlist.m3u8?wmsAuthSign=$(wget https://services.iol.pt/matrix?userId= -o /dev/null -O -)"; }

# Random string for user-agent to avoid blacklists
USER_AGENT=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 50)

# Checks if the media player (mpv) is installed
type $PLAYER &>/dev/null || { echo "$PLAYER não está instalado"; exit 1; }

if [ "$DEBUG" = "true" ]; then
  PS3="Digite o nº do canal de TV que deseja ver: "
  select choice in "${TITLES[@]}";
  do
    if [[ -n $choice ]]; then
      for i in ${!TITLES[@]}
      do
        if [ "${TITLES[i]}" = "$choice" ]; then
          # check if dynamic stream
          if [ "${STREAMS[i]:0:2}" = "__" ]; then
            $PLAYER --user-agent="$USER_AGENT" $(${STREAMS[i]})
          else
            $PLAYER --user-agent="$USER_AGENT" ${STREAMS[i]}
          fi
          break
        fi
      done
    fi
  done
else
  # Main loop to display the menu consistently with colors
  while true; do
    # Clear the screen and display the channel list with colors and aligned numbers
    clear
    echo -e "\e[32mCanais disponíveis:\e[0m"
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
    read -p "Digite o nº do canal de TV que deseja ver (ou 'x' para sair): " choice

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
