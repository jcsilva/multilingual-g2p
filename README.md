# Grapheme to Phoneme
G2P based on [espeak](http://espeak.sourceforge.net/).

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


Languages
---------

This G2P may be used in several languages. By defautl, it is configured to Brazilian Portuguese. If you want to use for other languages, please change the value of LANGUAGE variable in g2p.sh.
