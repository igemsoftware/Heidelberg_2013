#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys
from optparse import OptionParser
import json
from nltk.tokenize import wordpunct_tokenize, word_tokenize
from nltk.stem.porter import PorterStemmer
from nltk.text import TokenSearcher
from nltk.corpus import stopwords
from nltk.probability import FreqDist

def stem_term(term, stemmer=PorterStemmer()):
    stripped = term.strip()
    tokenized = word_tokenize(stripped)
    stemmed = [[stemmer.stem(w.lower()) for w in tokenized]]
    stemmed.append("<%s>" % "> <".join(stemmed[0]))
    return (stripped, stemmed)

def find_terms(needle, haystack, num=None):
    found = {}
    for (term, processed) in needle.iteritems():
        length = len(haystack.findall(processed[1]))
        if length > 0:
            found[term] = length
    if len(found) > 0:
        needle_sorted = found.keys()
        needle_sorted.sort(lambda x,y: cmp(found[x], found[y]))
        return {term : found[term] for term in needle_sorted[0:num] if found[term] > 0}
    else:
        return {}

parser = OptionParser()
parser.add_option("-i", "--infile", dest="infile", help="Read JSON from FILE", metavar="FILE", default="-")
parser.add_option("-t", "--termsfile", dest="termsfile", help="Read MESH terms from FILE", metavar="FILE", default="")
parser.add_option("-m", "--methodsfile", dest="methodsfile", help="Read methods from FILE", metavar="FILE", default="")
parser.add_option("-o", "--outfile", dest="outfile", help="Write JSON output to FILE", metavar="FILE", default="infile")
parser.add_option("-n", "--numbermesh", dest="numbermesh", help="Retain top N MESH terms", metavar="N", default=5)
parser.add_option("-k", "--numberwords", dest="numberwords", help="Retain top N words", metavar="N", default=5)
options = parser.parse_args()[0]

stemmer = PorterStemmer()
meshterms = {}
methods = {}

termsfile = open(options.termsfile, 'r')
for meshterm in termsfile:
    stemmed = stem_term(meshterm, stemmer)
    meshterms[stemmed[0]] = stemmed[1]
termsfile.close()

methodsfile = open(options.methodsfile, 'r')
for method in methodsfile:
    if method.startswith("\t\t"):
        stemmed = stem_term(method, stemmer)
        methods[stemmed[0]] = stemmed[1]
methodsfile.close()

if options.infile == '-':
    inputfile = sys.stdin
else:
    inputfile = open(options.infile, 'r')
data = json.load(inputfile, "utf-8")
inputfile.close()

freq_dists = {}
stopwords_en = set(stopwords.words('english'))
freq_dist_background = {}
freq_dist_background_sum = 0

i = 1
for team in data:
    try:
        tokenized = wordpunct_tokenize(team['abstract'])
        tokenized_filtered = [w.lower() for w in tokenized if w.lower() not in stopwords_en and w.isalnum() and len(w) > 1]
        stemmed = [stemmer.stem(w) for w in tokenized_filtered]
        searcher = TokenSearcher(stemmed)
        team['meshterms'] = find_terms(meshterms, searcher, options.numbermesh)
        team['methods'] = find_terms(methods, searcher)
        information = 0
        team['information_content'] = len(tokenized_filtered) / float(len(tokenized))
        fdist = FreqDist(tokenized_filtered)
        freq_dists[(team['name'], team['year'])] = fdist
        for (word, count) in fdist.iteritems():
            if word not in freq_dist_background:
                freq_dist_background[word] = count
            else:
                freq_dist_background[word] += count
            freq_dist_background_sum += count
    except KeyError:
        pass
    print >> sys.stderr, "\r%d / %d" % (i, len(data)),
    i += 1

for team in data:
    try:
        fdist = freq_dists[(team['name'], team['year'])]
        for w in fdist.iterkeys():
            fdist[w] = (fdist[w] / float(fdist.N())) / (freq_dist_background[w] / float(freq_dist_background_sum))
        words = fdist.keys()
        words.sort(lambda x,y: cmp(fdist[x], fdist[y]))
        team['topwords'] = {word : fdist[word] for word in words[0:options.numberwords]}
    except KeyError:
        pass

print >> sys.stderr, "\n",

if options.outfile == '-':
    outfile = sys.stdout
else:
    outfile = open(options.outfile, 'w')
outfile.write(json.dumps(data, indent=4, ensure_ascii=False, encoding="utf-8").encode("utf-8"))
outfile.close()
