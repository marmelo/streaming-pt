#!/bin/bash

PLAYER="mpv"

TITLES=(
  "RTP 1"
  "RTP 2"
  "SIC"
  "TVI"
  "RTP 3"
  "SIC Noticias"
  "TVI24"
  "RTP Memoria"
  "RTP Madeira"
  "RTP Acores"
  "RTP Africa"
  "RTP Internacional"
  "SIC Internacional"
  "ARTV"
  "Porto Canal"
  "Euronews"
  "Kuriakos TV"
)

STREAMS=(
  "__rtp rtp1"
  "__rtp rtp2"
  "http://live.impresa.pt/live/sic/sic.m3u8"
  "__tvi"
  "__rtp rtp3"
  "http://live.impresa.pt/live/sicnot/sicnot.m3u8"
  "__tvi24"
  "__rtp rtpmemoria"
  "__rtp rtpmadeira"
  "__rtp rtpacores"
  "__rtp rtpafrica"
  "__rtp rtpinternacional"
  "http://live.impresa.pt/live/sicint/sicint.m3u8"
  "https://5e4fc274d9d46.streamlock.net/livenlin4/2liveartvpub/playlist.m3u8"
  "--referrer='http://sapo.pt/' https://streamer-b02.videos.sapo.pt/live/portocanal/playlist.m3u8"
  "__euronews"
  "http://195.22.11.11:1935/ktv/ktv2/playlist.m3u8"
)

# as seen at https://stackoverflow.com/a/37840948
function urldecode() { : "${*//+/ }"; echo -e "${_//%/\\x}"; }

# dynamic streams
__rtp() { urldecode $(wget https://www.rtp.pt/play/direto/$1 -O - -o /dev/null | grep hls | sed 's/.*hls: //g' | sed 's/, dash.*//g' | sed 's/.*\[//g' | sed 's/\].*//g' | sed 's/[",]//g'); }
__tvi() { echo "https://video-auth6.iol.pt/live_tvi/live_tvi/playlist.m3u8?wmsAuthSign=$(wget https://services.iol.pt/matrix?userId= -o /dev/null -O -)"; }
__tvi24() { echo "https://video-auth6.iol.pt/live_tvi24/live_tvi24/playlist.m3u8?wmsAuthSign=$(wget https://services.iol.pt/matrix?userId= -o /dev/null -O -)"; }
__euronews() { echo "https://www.youtube.com/watch?v=$(wget http://pt.euronews.com/api/watchlive.json -O - -o /dev/null | cut -d\" -f8)"; }

#random string for user-agent to avoid blacklists
USER_AGENT=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 50)

# check if dependencies exist
type $PLAYER &>/dev/null || { echo "$PLAYER is not installed"; exit 1; }

PS3="Which TV channel do you want to watch? "
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
  else
    echo "Invalid selection."
  fi
done
