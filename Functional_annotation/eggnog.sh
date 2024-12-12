for SAMPLEID in $(cat ~/samples.txt);
do 
    echo "On sample: $SAMPLEID"  
    ~/eggNOG/eggnog-mapper-2.1.12/emapper.py -i ~/MAGs/${SAMPLEID}/Bins_${SAMPLEID}.faa --dmnd_db ~/eggNOG/eggnog-mapper-2.1.12/data/eggnog_proteins.dmnd --data_dir ~/eggNOG/eggnog-mapper-2.1.12/data/ -o ~/MAGs/${SAMPLEID}/${SAMPLEID}.eggout --cpu 0 --matrix BLOSUM62 --seed_ortholog_evalue 1e-5 --dbtype seqdb -m diamond
done
