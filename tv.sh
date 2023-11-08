#!/bin/bash

PLAYER="mpv"

TITLES=(
  "RTP 1"
  "RTP 2"
  "SIC"
  "TVI"
  "RTP 3"
  "SIC Notícias"
  "CNN Portugal"
  "RTP Memória"
  "RTP Madeira"
  "RTP Açores"
  "RTP África"
  "RTP Internacional"
  "TVI Internacional"
  "TVI Ficção"
  "TVI Reality"
  "ARTV"
  "Porto Canal"
  "Euronews"
  "Canal 11"
  "Kuriakos TV"
)

STREAMS=(
  "https://streaming-live-app.rtp.pt/liverepeater/smil:rtp1HD.smil/rtp_playlist.m3u8"
  "https://streaming-live-app.rtp.pt/liverepeater/smil:rtp2HD.smil/rtp_playlist.m3u8"
  "https://d1zx6l1dn8vaj5.cloudfront.net/out/v1/b89cc37caa6d418eb423cf092a2ef970/index.m3u8"
  "__tvi"
  "https://streaming-live-app.rtp.pt/liverepeater/smil:rtpnHD.smil/rtp_playlist.m3u8"
  "--referrer=https://sic.pt/ https://sicnot.live.impresa.pt/sicnot.m3u8"
  "__cnnportugal"
  "__rtp rtpmemoria"
  "__rtp rtpmadeira"
  "__rtp rtpacores"
  "__rtp rtpafrica"
  "__rtp rtpinternacional"
  "__tviint"
  "https://video-auth2.iol.pt/live_tvi_ficcao/live_tvi_ficcao/edge_servers/tvificcao-720p/playlist.m3u8"
  "https://video-auth2.iol.pt/live_tvi_direct/live_tvi_direct/edge_servers/tvireality-480p/playlist.m3u8"
  "https://playout175.livextend.cloud/livenlin4/2liveartvpub2/playlist.m3u8"
  "--referrer='http://sapo.pt/' https://streamer-b02.videos.sapo.pt/live/portocanal/playlist.m3u8"
  "https://0ff3c09c7580460e8e018cdcaacbadee.mediatailor.us-east-1.amazonaws.com/v1/manifest/44f73ba4d03e9607dcd9bebdcb8494d86964f1d8/RakutenTV-pt_EuroNewsLive/e8e94498-f4fc-42d5-9863-28410bcfa353/0.m3u8"
  "https://d2ve4fchffi4n1.cloudfront.net/out/v1/df356edd16f3434ab417f2c48cb1d516/index.m3u8"
  "http://195.22.11.11:1935/ktv/ktv2/playlist.m3u8"
)

# as seen at https://stackoverflow.com/a/37840948
function urldecode() { : "${*//+/ }"; echo -e "${_//%/\\x}"; }

# dynamic streams
__rtp() { urldecode $(wget https://www.rtp.pt/play/direto/$1 -O - -o /dev/null | grep hls | sed 's/.*hls: //g' | sed 's/, dash.*//g' | sed 's/.*\[//g' | sed 's/\].*//g' | sed 's/[",]//g'); }
__tvi() { echo "https://video-auth6.iol.pt/live_tvi/live_tvi/playlist.m3u8?wmsAuthSign=$(wget https://services.iol.pt/matrix?userId= -o /dev/null -O -)"; }
__cnnportugal() { echo "https://video-auth6.iol.pt/live_cnn/live_cnn/playlist.m3u8?wmsAuthSign=$(wget https://services.iol.pt/matrix?userId= -o /dev/null -O -)"; }
__tviint() { echo "https://video-auth6.iol.pt/live_tvi_internacional/live_tvi_internacional/playlist.m3u8?wmsAuthSign=$(wget https://services.iol.pt/matrix?userId= -o /dev/null -O -)"; }

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
