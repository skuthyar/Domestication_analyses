## Packages and versions
The first step for annotations is to annotate the assembled sequences with prokka. The prokka output has many files, but I mostly used the protein (.faa), the nucleotide (.fna), and the .gff files. 

The eggNOG, dbcan3, and rgi annotations can happen in parallel. 

# prokka
https://github.com/tseemann/prokka

Installation:
conda install -c conda-forge -c bioconda -c defaults prokka

Software Requirements:
| Dependencies | 
| ------------- | 
| BioPerl |
| GNU Parallel | 
| BLAST+ | 
| Prodigal | 
| TBL2ASN |

# eggNOG
https://github.com/eggnogdb/eggnog-mapper/wiki/eggNOG-mapper-v2.1.5-to-v2.1.12

Software Requirements:
| Dependencies | version |
| ------------- | ------------- |
| Python | 3.7 | 
| BioPython | 1.76 | 
| psutil | 5.7.0 | 
| sqlite | (>=3.8.2)| 

Installation:
conda install -c bioconda -c conda-forge eggnog-mapper

Export to path:
export PATH=/home/user/eggnog-mapper:/home/user/eggnog-mapper/eggnogmapper/bin:"$PATH"

export EGGNOG_DATA_DIR=/home/user/eggnog-mapper-data

Download databases: download_eggnog_data.py 

# dbcan3 for CAZyme annotation
https://dbcan.readthedocs.io/en/latest/

Software Requirements:
| Dependencies | version |
| ------------- | ------------- |
| Python | 3.6|

Installation:
conda install dbcan -c conda-forge -c bioconda

Build database:
dbcan_build --cpus 8 --db-dir db --clean

# rgi for AMR annotation
https://github.com/arpcard/rgi
Installed via singularity
