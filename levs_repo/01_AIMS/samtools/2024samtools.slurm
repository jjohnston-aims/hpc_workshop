#!/bin/bash

# To give your job a name, replace "MyJob" with an appropriate name
#SBATCH --job-name=SAMtools-test.slurm

# set your minimum acceptable walltime=days-hours:minutes:seconds
#SBATCH -t 2:00:00

# Load the environment variables
module load samtools/1.17

# Commands and comments derived from the basic SAMtools tutorial at: 
# http://quinlanlab.org/tutorials/samtools/samtools.html

curl https://s3.amazonaws.com/samtools-tutorial/sample.sam.gz > sample.sam.gz
gzip -d sample.sam.gz

sleep 120

# To do anything meaningful with alignment data from BWA or other aligners (which produce text-based SAM output), we need to 
# first convert the SAM to its binary counterpart, BAM format.

# To convert SAM to BAM, we use the samtools view command. We must specify that our input is in SAM format (by default it 
# expects BAM) using the -S option. We must also say that we want the output to be BAM (by default it produces BAM) with the -b 
# option. Samtools follows the UNIX convention of sending its output to the UNIX STDOUT, so we need to use a redirect operator 
# (“>”) to create a BAM file from the output.

samtools view -S -b sample.sam > sample.bam

# Indexing a genome sorted BAM file allows one to quickly extract alignments overlapping particular genomic regions. Moreover, 
# indexing is required by genome viewers such as IGV so that the viewers can quickly display alignments in each genomic region 
# to which you navigate.

samtools index sample.bam > sample.sorted.bam

# Now, let’s exploit the index to extract alignments from the 33rd megabase of chromosome 1. To do this, we use the samtools 
# view command, which we will give proper treatment in the next section.

samtools view sample.sorted.bam 1:33000000-34000000 > view33rdmega.txt

# How many alignments are there in this region?

samtools view sample.sorted.bam 1:33000000-34000000 | wc -l > 33rdaligncount.txt

# Count the total number of alignments

samtools view sample.sorted.bam | wc -l > totalaligncount.txt

# View the header
# One can ask the view command to report solely the header by using the -H option.

samtools view -H sample.sorted.bam > headeronly.txt

# Capture the FLAG. The FLAG field in the BAM format encodes several key pieces of information regarding how an alignment 
# aligned to the reference genome.
# 
# We often want to call variants solely from paired-end sequences that aligned “properly” to the reference genome. Why?
# 
# To ask the view command to report solely “proper pairs” we use the -f option and ask for alignments where the second bit is 
# true (proper pair is true).

samtools view -f 0x2 sample.sorted.bam > properalign.txt

# How many properly paired alignments are there?

samtools view -f 0x2 sample.sorted.bam | wc -l > propercount.txt

# Which alignments that are not properly paired. To do this, we use the -F option (opposite of -f)

samtools view -F 0x2 sample.sorted.bam > notproper.txt
samtools view -F 0x2 sample.sorted.bam | wc -l > notpropertcount.txt
