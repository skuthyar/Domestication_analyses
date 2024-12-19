# load CARD database
module load singularitypro
singularity exec -B /tscc/lustre/ddn/scratch,/tscc/projects/ps-aspenlab /tscc/nfs/home/skuthyar/rgi.sif rgi load --card_json ~/CARD/card.json --local

# annotate proteins
for SAMPLEID in $(cat ~/samples.txt);

do 
    echo "On sample: $SAMPLEID"  
    singularity exec -B /tscc/lustre/ddn/scratch,/tscc/projects/ps-aspenlab /tscc/nfs/home/skuthyar/rgi.sif rgi main -i ~/prokka/${SAMPLEID}/${SAMPLEID}.faa -o ~/prokka/${SAMPLEID}/${SAMPLEID}_protein_faa.card -t protein -a DIAMOND -n 6 --local --include_loose --clean --debug
done
