#!/usr/bin/env python
# -*- coding: utf-8 -*-
import sys

def usage():
  sys.stderr.write('USAGE:\n')
  sys.stderr.write('python espeak2lexicon.py [words_list] [espeak_file]\n')
  exit()

def parseTranscription(t):
  t = t.replace('_', ' ')
  t = t.replace("ˈ", "")
  t = t.replace("ˌ", "")
  t = t.replace("ː",'')
  return t

try:
  words_file  = sys.argv[1]
  espeak_file = sys.argv[2]
  
  with open(words_file,'r' ) as wf:
    with open(espeak_file, 'r') as ef:
      for word in wf:
        ef_line = ef.readline().strip()
        while len(ef_line) == 0:
          ef_line = ef.readline().strip()
          continue
        transcription = parseTranscription(ef_line)
        print(word.strip() + '\t' + transcription)
except  Exception,e: 
  print str(e)
  usage()
