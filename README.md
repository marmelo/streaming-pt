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
1) RTP 1              6) SIC Noticias          11) RTP Acores
2) RTP 2              7) TVI24 (N/A)           12) RTP Africa
3) SIC                8) RTP Memoria           13) ARTV (N/A)
4) TVI (N/A)          9) RTP Internacional     14) ETV
5) RTP Informacao    10) RTP Madeira           15) Euronews
Which TV channel do you want to watch?
```

```bash
$ ./radio.sh
1) Antena1     4) Cidade FM   7) M80         10) RFM         13) Sudoeste
2) Antena2     5) Comercial   8) Mega Hits   11) RUC         14) TSF
3) Antena3     6) Kiss FM     9) Renascenca  12) Smooth      15) Vodafone
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
