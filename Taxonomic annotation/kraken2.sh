# create a standard kraken2 database
kraken2-build --standard --db kraken_db

# classify with kraken2
for SAMPLEID in $(cat ~/kraken_samples.txt);
do    	
  echo "On sample: $SAMPLEID"   
  ~/kraken2/kraken2-2.1.3/kraken2 --db ~/kraken2/kraken2-2.1.3/kraken_db -t 5 --quick ~/prokka/${SAMPLEID}/${SAMPLEID}.fna --unclassified-out ~/prokka/${SAMPLEID}/${SAMPLEID}_unclassified.txt --classified-out ~/prokka/${SAMPLEID}/${SAMPLEID}_classified.txt --output ~/prokka/${SAMPLEID}/${SAMPLEID}_output.txt --use-names --report ~/prokka/${SAMPLEID}/${SAMPLEID}_kraken_report.txt --use-mpa-style
done

# bracken for the three taxonomic levels
for i in *_report.txt
do
  filename=$(basename "$i")
  fname="${filename%_report.txt}"
  ~/kraken2/kraken2-2.1.3/Bracken-2.9/bracken -d ~kraken2/kraken2-2.1.3/kraken_db -i $i -t 10 -l S -o ${fname}_report_species.txt
done

mv *_bracken_species.txt ~/kraken2/kraken2-2.1.3/k2_reports/braken/species/.


for i in *_report.txt
do
  filename=$(basename "$i")
  fname="${filename%_report.txt}"
  ~/kraken2/kraken2-2.1.3/Bracken-2.9/bracken -d ~/kraken2/kraken2-2.1.3/kraken_db -i $i -t 10 -l G -o ${fname}_report_genus.txt
done

mv *_bracken_genuses.txt ~/kraken2/kraken2-2.1.3/k2_reports/braken/genus/.


for i in *_report.txt
do
  filename=$(basename "$i")
  fname="${filename%_report.txt}"
  ~/kraken2/kraken2-2.1.3/Bracken-2.9/bracken -d ~/kraken2/kraken2-2.1.3/kraken_db -i $i -t 10 -l P -o ${fname}_report_phylum.txt
done

mv *_bracken_phylums.txt ~/kraken2/kraken2-2.1.3/k2_reports/braken/phylum/.

