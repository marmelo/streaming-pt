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
Canais disponíveis:
 1. RTP 1
 2. RTP 2
 3. SIC
 4. TVI
 5. RTP 3
 6. SIC Notícias
 7. CNN Portugal
 8. Euronews
 9. ARTV
10. RTP Memória
11. RTP Madeira
12. RTP Açores
13. RTP África
14. RTP Internacional
15. TVI Internacional
16. TVI África
17. TVI Ficção
18. TVI Reality
19. Porto Canal
20. Kuriakos TV

Digite o nº do canal de TV que deseja ver (ou 'x' para sair): x
```

```bash
Rádios disponíveis:
 1. Antena1
 2. Antena2
 3. Antena3
 4. Cidade FM
 5. Comercial
 6. Kiss FM
 7. M80
 8. Mega Hits
 9. MEO Music
10. Nova Era
11. Orbital
12. Oxigénio
13. Radar
14. Renascenca
15. RFM
16. RUC
17. Smooth
18. TSF
19. Rádio Clube de Lamego
20. Rádio Douro Nacional

Digite o nº da rádio que deseja ouvir (ou 'x' para sair): x
```

You can also play a specific channel directly, for eg.:
```bash
echo 5 | ./radio.sh
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

Note that some channels only play if you have recent versions of ffmpeg (6.0 or above) installed.

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
