streaming-pt
============

Live Portuguese TV and radio.

**Disclaimer:**  
All streams are official.

Please add a [new issue](https://github.com/marmelo/streaming-pt/issues) to report broken links or suggest new streams.


Requirements
-----

- [Bash](https://www.gnu.org/software/bash/)
- [rtmpdump](https://rtmpdump.mplayerhq.hu/)
- [MPlayer](http://www.mplayerhq.hu/)

If you need assistance please check [installing dependencies](#installing-dependencies).


Usage
-----

```bash
$ ./tv.sh 
1) RTP 1                7) TVI24              13) RTP Acores
2) RTP 2                8) SIC Radical        14) RTP Africa
3) SIC                  9) SIC K              15) ARTV
4) TVI                 10) RTP Memoria        16) Porto Canal
5) RTP 3               11) RTP Internacional  17) Euronews
6) SIC Noticias        12) RTP Madeira        18) Kuriakos TV
Which TV channel do you want to watch?
```

```bash
$ ./radio.sh
1) Antena1       5) Comercial    9) MEO Music   13) Smooth
2) Antena2       6) Kiss FM     10) Renascenca  14) TSF
3) Antena3       7) M80         11) RFM         15) Vodafone
4) Cidade FM     8) Mega Hits   12) RUC         16) Radio Zero
Which radio do you want to listen? 
```


Installing dependencies
-----

```bash
# Debian / Ubuntu
$ apt-get install rtmpdump mplayer
```

```bash
# Arch Linux
$ pacman -S rtmpdump mplayer
```

```bash
# Mac OS X
$ brew install rtmpdump mplayer
```

How to catch RTMP streams
-----

```bash
# redirect outgoing RTMP traffic to localhost
$ iptables -t nat -A OUTPUT -p tcp --dport 1935 -j REDIRECT
```

```bash
# start rtmpsrv
$ rtmpsrv
```

Now open a web page containing media streamed over RTMP.  
RTMP requests will be caught by `iptables` and logged by `rtmpsrv`.

```bash
# remove redirection of outgoing RTMP traffic
$ iptables -t nat -D OUTPUT -p tcp --dport 1935 -j REDIRECT
```
