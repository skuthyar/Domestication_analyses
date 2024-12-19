conda activate dbcan

for SAMPLEID in $(cat ~/samples.txt);

do 
    echo "On sample: $SAMPLEID"  
    cd ~/prokka/${SAMPLEID}
    run_dbcan ~/prokka/${SAMPLEID}/${SAMPLEID}.faa protein --db_dir ~/dbcan/db/ --out_dir ~/${SAMPLEID}/${SAMPLEID}_dboutput
done
