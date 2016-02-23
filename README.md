# Multilingual Grapheme to Phoneme
Multilingual G2P based on [espeak](http://espeak.sourceforge.net/). Based on [these](http://spirit.blau.in/simon/tag/portuguese/) ideas.

Languages
---------

This G2P may be used in several languages. By defautl, it is configured for Brazilian Portuguese. 

How to use
----------

* First of all, install *espeak*. On Ubuntu 14.04, `sudo apt-get install espeak`.

* Create a *words list* with one word per line. The file *words.egs* included in this repository is an example.

* Execute `g2p.sh`:
```
./g2p.sh -w words.egs 
```
The lexicon will be thrown in /dev/stdout.

* You may choose a different language simply setting the parameter "l". For example, the following command line will generate a French lexicon.
```
./g2p.sh -w words.egs -l fr
```

The following languages are valid:
```
af (Afrikaans), bs (Bosnian), ca (Catalan), cs (Czech),
da (Danish), de (German), el (Greek), en (Default English),
en-us (American English), en-sc (Scottich English),
en-n (Northern British English), en-rp (Received Pronunciation British English),
en-wm (West Midlands British English), eo (Esperanto), es (Spanish),
es-la (Spanish - Latin America), fi (Finnish), fr (French), hr (Croatian),
hu (Hungarian), it (Italian), kn (Kannada), ku (Kurdish), lv (Latvian),
nl (Dutch), pl (Polish), pt (Portuguese (Brazil)), pt-pt (Portuguese (European)),
ro (Romanian), sk (Slovak), sr (Serbian), sv (Swedish), sw (Swahihi),
ta (Tamil), tr (Turkish), zh (Mandarin Chinese)
```

Create a Brazilian Portuguese list of words
-------------------------------------------

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
