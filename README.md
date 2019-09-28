streaming-pt
============

Live Portuguese TV and radio.

**Disclaimer:**  
All streams are official.

Please add a [new issue](https://github.com/marmelo/streaming-pt/issues) to report broken links or suggest new streams.


Requirements
-----

- [Bash](https://www.gnu.org/software/bash/)
- [mpv](https://mpv.io/)

If you need assistance please check [installing dependencies](#installing-dependencies).


Usage
-----

```bash
$ ./tv.sh 
1) RTP 1                7) TVI24              13) SIC Radical
2) RTP 2                8) RTP Memoria        14) SIC K
3) SIC                  9) RTP Internacional  15) ARTV
4) TVI                 10) RTP Madeira        16) Porto Canal
5) RTP 3               11) RTP Acores         17) Euronews
6) SIC Noticias        12) RTP Africa         18) Kuriakos TV
Which TV channel do you want to watch?
```

```bash
$ ./radio.sh
1) Antena1       6) Kiss FM     11) Radar       16) TSF
2) Antena2       7) M80         12) Renascenca  17) Vodafone
3) Antena3       8) Mega Hits   13) RFM         18) Zero
4) Cidade FM     9) MEO Music   14) RUC
5) Comercial    10) Oxigénio    15) Smooth
Which radio do you want to listen? 
```


Installing dependencies
-----

```bash
# Debian / Ubuntu
$ apt-get install mpv
```

```bash
# Arch Linux
$ pacman -S mpv
```

```bash
# Mac OS X (two alternatives)
$ brew install mpv
$ port install mpv
```

How to catch RTMP streams
-----

For this you will need `iptables` and `rtmpdump`.

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
