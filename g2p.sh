#!/bin/bash
# create_lexicon.sh: generate lexicon file from a given word list file.

help_message="usage: `basename $0` -w <input-words-list-file> [-l language]

Generate lexicon file from a given word list file.

-w <input-words-list-file>  Mandatory: File with one word per line.
[-l language]               Optional: Defines the language used to build the lexicon. By
                            default, it is Brazilian Portuguese. But, the following languages
                            may be used: 
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
"

LANGUAGE=pt #by default we will use it for brazilian portuguese. 
            #It may be used for other languages. 
            #Just check espeak supported languages 
            #(http://espeak.sourceforge.net/languages.html).


while getopts "h?w:l:" opt; do
    case "$opt" in
    h|\?)
        echo "$help_message"
        exit 0
        ;;
    w)  WORDSLIST=$OPTARG
        ;;
    l)  LANGUAGE=$OPTARG
        ;;
    esac
done

if [ ! -f "$WORDSLIST" ]; then
  echo "File \"$WORDSLIST\" does not exist."
  echo "$help_message" >&2
  exit 1
fi

while IFS='' read -r line || [[ -n "$line" ]]; do
  # generate transcription for each line of $WORDSLIST
  PHONEMES=$(espeak --stdin -v $LANGUAGE -q -x --ipa=3 --stdout <<< $line)

  # remove blank lines and unwanted symbols
  PHONEMES=$(echo $PHONEMES | sed -e '/^$/d' -e 's:_: :g' -e 's/ː//g' -e 's/ˈ//g' -e 's/ˌ//g')

  # build the output line
  echo -e "$line\t$PHONEMES"

done < $WORDSLIST
