Quote Characters
================

It is good practise to enclose the regular expression in single quotes, to prevent the shell from expanding the expression rather than the grep process. 

e.g., `grep 'ATEK' gattaca.txt` rather than `grep ATEK gattaca.txt`

Grep with Metacharacters
========================

Some examples of grep options with metacharacters.

* Print only the matched parts of a matching line with separate outline lines.
grep -o '"[^"]\+"' filename

* Count the number of empty lines in a file, '-c' is count.
grep -c '^$' filename

* Search for words without standard vowels, '-v' is invert match.
grep -v '[aeiou]' /usr/share/dict/words

* Case-insensitive search for lines that start with QANTAS, and only QANTAS (not QANTAS1, for example), in all files in the specified directory, and specify the line number in the file(s) that it appears in. The options '-i', '-w', '-n' are case-insensitive, whole word, and line-number respectively.
grep -iwn '^QANTAS' /usr/share/dict/*

############
#Faster Grep
############

# Localisation settings *might* slow down your grep search. Prefixing the search with LC_ALL forces applications to use the same language (US English). This speeds up grep in many cases because it is a singl-ebyte comparison rather than multi-byte (as is the case with UTF8).  It is not appropriate if you are searching file with non-ASCII standard characters!
# Use of `grep -F` (or `fgrep`) interprets the search pattern as a fixed string, rather than a regular expression - which means that one does not need any regular expression escape characters. If one is searching for strings rather than patterns this can be faster.

# Testing!
# Create a big file and run time over it. Does it make a difference?
# Note that grep -F has no strong quotes.

$ base64 /dev/urandom | head -c 1000000000 > bigfile.txt
$ time grep -i 'searchterm' '62I' < bigfile.txt > out1.txt
..
$ time LC_ALL=C grep 'grep '62I' < bigfile.txt > out2.txt
..
$ time grep -F searchterm 62I < bigfile.txt > out3.txt
..

###############
#Multiple Greps
###############

# The option `-l` with grep will print only the name of the each input file which matches the regular expression. This can be used with xargs to search multiple files for multiple search terms.

# Example: Search through multiple directories for a search term, starting from current working directory. Note that a recursive grep really should be used with `-l`. 

grep -rl searchterm .

# Example: Search through a directory of build scripts for those files that use the Tarball block, have an installstep parameter, and use the dummy toolchain.

grep -l 'Tarball' * -R | xargs grep -l 'installstep' | xargs grep -l 'dummy'

###############
# Parallel Grep
##############
#
# With GNU parallel or by piping find with xargs to grep, grep can be run in parallel. 
#
# This is especially useful when you have are searching through a lot of files or a large file.
#
# Start an interactive job, and load the parallel module for invoking parallel options for grep.
#
# For example, using the 2015 build system

sinteractive --nodes=1 ntasks-per-node=8 --time=1:00:00
module purge
/usr/local/module/spartan_old.sh
module load parallel/20150322-GCC-4.9.2

time find . -type f -print0 | parallel -k -j200% -n 1000 -m grep -i 'searchterm' {} > output3

# And the 2019 build system

sinteractive --nodes=1 ntasks-per-node=8 --time=1:00:00
module purge
module load foss/2019b
module load parallel/20190922

time find . -type f -print0 | parallel -k -j200% -n 1000 -m grep -i 'searchterm' {} > output3

# An alternative using find 

find . -type f -print0  | xargs -0 -P 8  grep 'searchterm' files > output

# For a single big file, it can be split into chunks with the --pipepart and --block options.

$ time parallel --pipepart -a bigfile.txt --block 100M grep '62I' > out5.txt


