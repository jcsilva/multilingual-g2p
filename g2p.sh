#!/bin/bash
# create_lexicon.sh: generate lexicon file from a given word list file.

help_message="usage: `basename $0` <input-words-list-file> <output-lexicon-file> [number-of-splits]

Generate lexicon file from a given word list file.

input-words-list-file  File with one word per line.
output-lexicon-file    Output file in which the lexicon will be saved.
number-of-splits       If input words is too big (e.g. more than 10 million words),                       it must be splitted to avoid espeak seg faults. By default,                        number-of-splits is equal to 1.
"

WORDSLIST="$1"
LEXICON="$2"
SPLITS=1

if [ -z "$WORDSLIST" ] || [ -z "$LEXICON" ] ; then
  echo "$help_message" >&2
  exit 1
fi

if [ ! -z $3 ] && [ $3 -gt 0 ]; then
  SPLITS=$3
fi

echo "\"$WORDSLIST\" will be splitted in $SPLITS file(s)."

# create espeak "XML file". 
# createSSML splits WORDLIST and generates SSML files.
python createSSML.py $SPLITS $WORDSLIST

# for each SSML file, run espeak and concatenate 
# the results in the words-espeak file.
for idx in `seq $SPLITS`
do
  espeak -f out_$(($idx-1)).ssml -m -v pt -q -x --ipa=3 >> words-espeak
done

# generates the lexicon file.
python espeak2lexicon.py $WORDSLIST words-espeak > $LEXICON

# remove intermediate files.
rm words-espeak out_*

echo "Lexicon saved in file \"$LEXICON\""
