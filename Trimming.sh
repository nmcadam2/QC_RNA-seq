#!/bin/bash
#$ -M netid@nd.edu
#$ -m abe
#$ -q long
#$ -pe smp 17
#$ -N projectName

dir=$(pwd)
mkdir -p ${dir}/output/trimmed/reports/

for input in ${dir}/input/*R1*gz; do
    i=$(basename ${input})
    I=$(echo ${input} | sed 's/R1/R2/g')
    out=$(echo ${i} | sed 's/fastq/trimmed.fastq/g')
    o=${dir}/output/trimmed/${out}
    O=$(echo ${o} | sed 's/R1/R2/g')
    j=${dir}/output/trimmed/reports/$(echo $i | sed 's/_R1.*//g').json
    h=${dir}/output/trimmed/reports/$(echo $i | sed 's/_R1.*//g').html

    /path/to/installed/software/fastp/fastp \
    -i ${input} \
    -I ${I} \
    -o ${o} \
    -O ${O} \
    -l 60} \
    -q 30 \
    -w 16 \
    --detect_adapter_for_pe \
    --dont_eval_duplication \
    --json ${j} \
    --html ${h}
done
