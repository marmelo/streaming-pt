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
1) RTP 1           7) TVI24              13) SIC Internacional
2) RTP 2           8) RTP Memoria        14) ARTV
3) SIC             9) RTP Madeira        15) Porto Canal
4) TVI            10) RTP Acores         16) Euronews
5) RTP 3          11) RTP Africa         17) Kuriakos TV
6) SIC Noticias   12) RTP Internacional
Which TV channel do you want to watch?
```

```bash
$ ./radio.sh
1) Antena1       6) Kiss FM     11) Orbital     16) RUC
2) Antena2       7) M80         12) Oxigénio    17) Smooth
3) Antena3       8) Mega Hits   13) Radar       18) TSF
4) Cidade FM     9) MEO Music   14) Renascenca  19) Vodafone
5) Comercial    10) Nova Era    15) RFM         20) Zero
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
