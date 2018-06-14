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
1) RTP 1                8) RTP 1 HD           15) SIC K
2) RTP 2                9) RTP Memoria        16) ARTV
3) SIC                 10) RTP Internacional  17) Porto Canal
4) TVI                 11) RTP Madeira        18) Euronews
5) RTP 3               12) RTP Acores         19) Kuriakos TV
6) SIC Noticias        13) RTP Africa
7) TVI24               14) SIC Radical
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
