SPLITS=2
WORDSLIST="words.egs"
LEXICON="lexicon.txt"

python createSSML.py $SPLITS $WORDSLIST

for idx in `seq $SPLITS`
do
  espeak -f out_$(($idx-1)).ssml -m -v pt -q -x --ipa=3 >> words-espeak
done

python espeak2lexicon.py $WORDSLIST words-espeak > $LEXICON

rm words-espeak out_*

echo "Done. Lexicon saved in file \"$LEXICON\""
