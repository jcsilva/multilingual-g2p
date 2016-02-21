import sys
import math

def usage():
  sys.stderr.write('USAGE:\n')
  sys.stderr.write('python createSSML.py [number_of_splits] [words_list]\n')
  exit()

def numLines(filename):
  return sum(1 for line in open(filename, 'r'))

try:
  num_splits = int(sys.argv[1])
  words_list = sys.argv[2]
  
  num_lines = numLines(words_list)
  
  max_lines_per_file = math.ceil(float(num_lines) / num_splits )

  with open(words_list, 'r') as inp_file:
    for n in range(num_splits):
      with open('out_'+str(n)+'.ssml', 'w') as out_file:
        out_file.write('<speak version="1.0" xml:lang="hu">\n')
        out_file.write('<audio/>\n')
        line_counter = 0
        while line_counter < max_lines_per_file:
          out_file.write('<audio>' + inp_file.readline().strip() + '</audio>\n')
          line_counter += 1      
        out_file.write('</speak>')
except Exception,e:
  print str(e)
  usage()

