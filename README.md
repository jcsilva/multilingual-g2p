# Multilingual Grapheme to Phoneme
Multilingual G2P based on [espeak](http://espeak.sourceforge.net/).

Languages
---------

This G2P may be used in several languages. By defautl, it is configured for Brazilian Portuguese. If you want to use it with other languages, please change the value of LANGUAGE variable in g2p.sh.


How to use
----------

* First of all, install *espeak*. On Ubuntu 14.04, `sudo apt-get install espeak`.

* Create a *words list* with one word per line. The file *words.egs* included in this repository is an example.

* Execute `g2p.sh`:
```
./g2p.sh words.egs lexicon.txt
```
The *lexicon.txt* will be generated.

* You must run `g2p.sh` with an extra parameter when the *words list* file has too many lines (e.g. more than 10 million lines). 
```
./g2p.sh words.egs lexicon.txt 3
```
It will split the *words list* into smaller files avoiding espeak seg faults.


Create a Brazilian Portuguese list of words
-------------------------------------------

All the following steps were based on this [recipe](http://spirit.blau.in/simon/tag/portuguese/).

1. [Get spelling dictionary](http://extensions.services.openoffice.org/en/project/Vero), the license is LGPL version 2.1.

2. Extract pt_BR.dic and pt_BR.aff files from the .oxt file that was downloaded in the previous step. It may be done using vim.

3. Convert pt_BR.dic and pt_BR.aff to UTF-8:
  ```
  iconv -f ISO8859-1 -t UTF-8 < pt_BR.dic > portuguese-brazilian-utf8.dic
  iconv -f ISO8859-1 -t UTF-8 < pt_BR.aff > portuguese-brazilian-utf8.aff
  ```
4. Change first line of file portuguese-brazilian-utf8.aff from SET ISO8859-1 to SET UTF-8.

5. Install *unmunch* tool:
  ```
  sudo apt-get install hunspell-tools
  ```

6. Generate a list with Brazilian Portuguese words:
  ```
  unmunch portuguese-brazilian-utf8.dic portuguese-brazilian-utf8.aff > portuguese-brazilian-wordlist
  ```
portuguese-brazilian-wordlist will have more than 80 million words and its size will be greater than 1 GB.
