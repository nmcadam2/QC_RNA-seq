#This script generates job scripts for each pair of reads within a project. Only use if dealing with a large number of samples and want to submit them in batches.
#Direct $i in the forloop to trimmed and if necessary decontaminated reads. Run locally to generate scripts which will then be submitted as jobs individually.
#Remember that before you can run mapping you need to have a genomic.fna file, a genomic.gtf/gff file, and you need to use hisat2-build to index the genome.
#see hisat --help for more details.
for i in /path/to/trimmed/output/trimmed/*R1*trimmed.fastq.gz;do
    R1=$i
    R2=$(echo $R1 | sed 's/_R1_/_R2_/g')
    ref=/path/to/genomic/reference/LRV0
    outstub=$(basename $R1)
    sam=${outstub%trimmed*}mapped.sam
    outdir=/path/to/outputs
printf "#!/bin/bash\n#$ -M netid@nd.edu\n#$ -m abe\n#$ -q long\n#$ -pe smp 12\n#$ -N ProjName\n\nmodule load bio/2.0\n\nhisat2 -p 10 -x ${ref} -1 $R1 -2 $R2 -S $outdir/$sam --max-intronlen 5000 --new-summary --summary-file $outdir/${sam%sam}stats.txt\n\n\nsamtools sort $outdir/$sam > $outdir/${sam%%sam}bam\nsamtools index $outdir/${sam%%sam}bam\nrm $outdir/$sam">./${sam%mapped*}sh

done
