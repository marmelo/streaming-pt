#!/bin/bash

PLAYER="mpv"

TITLES=(
  "RTP 1"
  "RTP 2"
  "SIC"
  "TVI"
  "RTP 3"
  "SIC Noticias"
  "CNN Portugal"
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
  "https://sic.live.impresa.pt/sic.m3u8"
  "__tvi"
  "__rtp rtp3"
  "https://sicnot.live.impresa.pt/sicnot.m3u8"
  "__tvi24"
  "__rtp rtpmemoria"
  "__rtp rtpmadeira"
  "__rtp rtpacores"
  "__rtp rtpafrica"
  "__rtp rtpinternacional"
  "http://live.impresa.pt/live/sicint/sicint.m3u8"
  "https://playout175.livextend.cloud/livenlin4/2liveartvpub/playlist.m3u8"
  "--referrer='http://sapo.pt/' https://streamer-b02.videos.sapo.pt/live/portocanal/playlist.m3u8"
  "https://rakuten-euronews-8-pt.samsung.wurl.com/manifest/playlist.m3u8"
  "http://195.22.11.11:1935/ktv/ktv2/playlist.m3u8"
)

# as seen at https://stackoverflow.com/a/37840948
function urldecode() { : "${*//+/ }"; echo -e "${_//%/\\x}"; }

# dynamic streams
__rtp() { urldecode $(wget https://www.rtp.pt/play/direto/$1 -O - -o /dev/null | grep hls | sed 's/.*hls: //g' | sed 's/, dash.*//g' | sed 's/.*\[//g' | sed 's/\].*//g' | sed 's/[",]//g'); }
__tvi() { echo "https://video-auth6.iol.pt/live_tvi/live_tvi/playlist.m3u8?wmsAuthSign=$(wget https://services.iol.pt/matrix?userId= -o /dev/null -O -)"; }
__tvi24() { echo "https://video-auth2.iol.pt/live_cnn/live_cnn/playlist.m3u8?wmsAuthSign=$(wget https://services.iol.pt/matrix?userId= -o /dev/null -O -)"; }


#https://video-auth2.iol.pt/live_cnn/live_cnn/playlist.m3u8?wmsAuthSign=c2VydmVyX3RpbWU9My8xOC8yMDIyIDc6NTc6NDYgQU0maGFzaF92YWx1ZT1BOXZMWlBOVVllWEN0UEt2aHFhWXhnPT0mdmFsaWRtaW51dGVzPTE0NDAmaWQ9NDRkNjQ1MGEtNWZjNi00NTU4LTliM2ItNGRjYmVlOTZlNDJl


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
