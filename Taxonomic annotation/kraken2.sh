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

#Generate combined abundance tables in mpa format
mkdir braken/species/mpa
mkdir braken/genus/mpa
mkdir braken/phylum/mpa

for i in ~/kraken2/kraken2-2.1.3/k2_reports/braken/species/*_report_bracken_species.txt;
do
  filename=$(basename "$i")
  fname="${filename%_report_bracken_species.txt}"
  python ~/kraken2/kraken2-2.1.3/kreport2mpa.py -r $i -o ~/kraken2/kraken2-2.1.3/k2_reports/braken/species/mpa/${fname}_mpa.txt --display-header
done

mkdir ~/kraken2/kraken2-2.1.3/k2_reports/braken/species/mpa/combined
python ~/kraken2/kraken2-2.1.3/combine_mpa.py -i ~/kraken2/kraken2-2.1.3/k2_reports/braken/species/mpa/*_mpa.txt -o ~/kraken2/kraken2-2.1.3/k2_reports/braken/species/mpa/combined/combined_species_mpa.txt
grep -E "(s__)|(#Classification)" ~/kraken2/kraken2-2.1.3/k2_reports/braken/species/mpa/combined/combined_species_mpa.txt > bracken_abundance_species_mpa.txt

for i in ~/kraken2/kraken2-2.1.3/k2_reports/braken/genus/*_report_bracken_genuses.txt;
do
  filename=$(basename "$i")
  fname="${filename%_report_bracken_genues.txt}"
  python ~/kraken2/kraken2-2.1.3/kreport2mpa.py -r $i -o ~/kraken2/kraken2-2.1.3/k2_reports/braken/genus/mpa/${fname}_mpa.txt --display-header
done

mkdir ~/kraken2/kraken2-2.1.3/k2_reports/braken/genus/mpa/combined
python ~/kraken2/kraken2-2.1.3/combine_mpa.py -i ~/kraken2/kraken2-2.1.3/k2_reports/braken/genus/mpa/*_mpa.txt -o ~/kraken2/kraken2-2.1.3/k2_reports/braken/genus/mpa/combined/combined_genus_mpa.txt
grep -E "(g__)|(#Classification)" ~/kraken2/kraken2-2.1.3/k2_reports/braken/genus/mpa/combined/combined_genus_mpa.txt > bracken_abundance_genus_mpa.txt

for i in ~/kraken2/kraken2-2.1.3/k2_reports/braken/phylum/*_report_bracken_phylums.txt;
do
  filename=$(basename "$i")
  fname="${filename%_report_bracken_phylums.txt}"
  python ~/kraken2/kraken2-2.1.3/kreport2mpa.py -r $i -o ~/kraken2/kraken2-2.1.3/k2_reports/braken/genus/mpa/${fname}_mpa.txt --display-header
done
mkdir ~/kraken2/kraken2-2.1.3/k2_reports/braken/phylum/mpa/combined
python ~/kraken2/kraken2-2.1.3/combine_mpa.py -i ~/kraken2/kraken2-2.1.3/k2_reports/braken/phylum/mpa/*_mpa.txt -o ~/kraken2/kraken2-2.1.3/k2_reports/braken/phylum/mpa/combined/combined_phylum_mpa.txt
grep -E "(p__)|(#Classification)" ~/kraken2/kraken2-2.1.3/k2_reports/braken/phylum/mpa/combined/combined_phylum_mpa.txt > bracken_abundance_phylum_mpa.txt

#Cleaning up sample names
sed -i -e 's/_report_bracken.txt//g' ~/kraken2/kraken2-2.1.3/k2_reports/braken/species/mpa/combined/bracken_abundance_species_mpa.txt
sed -i -e 's/_report_bracken.txt//g' ~/kraken2/kraken2-2.1.3/k2_reports/braken/genus/mpa/combined/bracken_abundance_genus_mpa.txt
sed -i -e 's/_report_bracken.txt//g' ~/kraken2/kraken2-2.1.3/k2_reports/braken/phylum/mpa/combined/bracken_abundance_phylum_mpa.txt

#Cleaning up top-level folders
mkdir bracken_abundance_files
cp ~/kraken2/kraken2-2.1.3/k2_reports/braken/species/mpa/combined/bracken_abundance_species_mpa.txt ~/kraken2/kraken2-2.1.3/k2_reports/braken/bracken_abundance_files/.
cp ~/kraken2/kraken2-2.1.3/k2_reports/braken/genus/mpa/combined/bracken_abundance_genus_mpa.txt ~/kraken2/kraken2-2.1.3/k2_reports/braken/bracken_abundance_files/.
cp ~/kraken2/kraken2-2.1.3/k2_reports/braken/phylum/mpa/combined/bracken_abundance_phylum_mpa.txt ~/kraken2/kraken2-2.1.3/k2_reports/braken/bracken_abundance_files/.
