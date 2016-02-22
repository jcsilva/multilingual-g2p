#!/bin/bash
# create_lexicon.sh: generate lexicon file from a given word list file.

help_message="usage: `basename $0` -w <input-words-list-file> -o <output-lexicon-file> [-s num_splits] [-l language]

Generate lexicon file from a given word list file.

-w <input-words-list-file>  Mandatory: File with one word per line.
-o <output-lexicon-file>    Mandatory: Output file in which the lexicon will be saved.
[-s number-of-splits]       Optional: If input words is too big (e.g. more than 10 million words),
                            it must be splitted to avoid espeak seg faults. By default,
                            number-of-splits is equal to 1.
[-l language]               Optional: Defines the language used to build the lexicon. By
                            default, it is Brazilian Portuguese. But, the following languages
                            may be used:
                            af     Afrikaans
                            bs     Bosnian
                            ca     Catalan
                            cs     Czech
                            da     Danish
                            de     German
                            el     Greek
                            en     Default English
                            en-us  American English
                            en-sc  Scottich English
                            en-n   Northern British English
                            en-rp  Received Pronunciation British English
                            en-wm  West Midlands British English
                            eo     Esperanto
                            es     Spanish
                            es-la  Spanish - Latin America
                            fi     Finnish
                            fr     French
                            hr     Croatian
                            hu     Hungarian
                            it     Italian
                            kn     Kannada
                            ku     Kurdish
                            lv     Latvian
                            nl     Dutch
                            pl     Polish
                            pt     Portuguese (Brazil)
                            pt-pt  Portuguese (European)
                            ro     Romanian
                            sk     Slovak
                            sr     Serbian
                            sv     Swedish
                            sw     Swahihi
                            ta     Tamil
                            tr     Turkish
                            zh     Mandarin Chinese
"

SPLITS=1
LANGUAGE=pt #by default we will use it for brazilian portuguese. 
            #It may be used for other languages. 
            #Just check espeak supported languages 
            #(http://espeak.sourceforge.net/languages.html).


while getopts "h?w:o:s:l:" opt; do
    case "$opt" in
    h|\?)
        echo "$help_message"
        exit 0
        ;;
    w)  WORDSLIST=$OPTARG
        ;;
    o)  OUTFILE=$OPTARG
        ;;
    s)  SPLITS=$OPTARG
        ;;
    l)  LANGUAGE=$OPTARG
        ;;
    esac
done

if [ -z "$WORDSLIST" ] || [ -z "$OUTFILE" ] ; then
  echo "aqui"
  echo "$help_message" >&2
  exit 1
fi


echo "\"$WORDSLIST\" will be splitted in $SPLITS file(s)."

# create espeak "XML file". 
# createSSML splits WORDLIST and generates SSML files.
python createSSML.py $SPLITS $WORDSLIST

# for each SSML file, run espeak and concatenate 
# the results in the words-espeak file.
for idx in `seq $SPLITS`
do
  espeak -f out_$(($idx-1)).ssml -m -v $LANGUAGE -q -x --ipa=3 >> words-espeak
done

# generates the lexicon file.
python espeak2lexicon.py $WORDSLIST words-espeak > $OUTFILE

# remove intermediate files.
rm words-espeak out_*

echo "Lexicon saved in file \"$OUTFILE\""
