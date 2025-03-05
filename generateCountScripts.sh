#This script will generate individual count scripts for each sample mapped. Runs very quickly I reccomend testing one of the samples to make sure you have you reference directory
#properly set. 

baseDir=$(pwd)
gtf=${baseDir}/reference/UOB_LRV0_1_genomic.gtf
output=/path/to/output/counts/

mkdir -p ${output}

for i in ${baseDir}/output/mapped/*.bam; do
    s=$(basename ${i})
    stub=${s%_R1*}

    echo "#!/bin/bash" >> ${stub}_count.sh
    echo "#$ -M netid@nd.edu" >> ${stub}_count.sh
    echo "#$ -m abe" >> ${stub}_count.sh
    echo "#$ -q long" >> ${stub}_count.sh
    echo "#$ -pe smp 12" >> ${stub}_count.sh
    echo "#$ -N ${stub}_count" >> ${stub}_count.sh
    printf "\n\n" >> ${stub}_count.sh

    echo "conda activate featurecount" >> ${stub}_count.sh
    echo "featureCounts \\" >> ${stub}_count.sh
    echo "  -T 8 \\" >> ${stub}_count.sh
    echo "  -t gene \\" >> ${stub}_count.sh
    echo "  -g gene_id\\" >> ${stub}_count.sh
    echo "  -a ${gtf} \\" >> ${stub}_count.sh
    echo "  -o ${output}${stub}.feature.countsps \\" >> ${stub}_count.sh
    echo "  -p \\" >> ${stub}_count.sh
    echo "  -M \\" >> ${stub}_count.sh
    echo "  --fraction \\" >> ${stub}_count.sh
    echo "  ${i}" >> ${stub}_count.sh
    printf "\n\n\n" >> ${stub}_count.sh
    echo "conda deactivate" >> ${stub}_count.sh

done