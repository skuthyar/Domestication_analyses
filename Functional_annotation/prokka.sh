for SAMPLEID in $(cat ~/prokka_samples.txt);

do 
   	echo "On sample: $SAMPLEID"   
    prokka --outdir ~/${SAMPLEID}_prokka ~/${SAMPLEID}_bins_assembly_*_1.fa --locustag ${SAMPLEID}
done

