# Search sequence database (i.e. Prodigal protein translation files) against a single Pfam alignment
# Mike Bai
# August 2022

# Go to directory where Pfam alignment files are stored
cd /workdir/myb7/data/MuskegonLake/alignments

# Build HMM
hmmbuild "$1".hmm "$1".txt

# Make hmmer output directory
mkdir /workdir/myb7/data/MuskegonLake/hmmer/"$1"

# Search sequences in protein translation file from each sample against HMM
for sample in {91614..91629}
do
        #Search sequence database with profile HMM
        hmmsearch "$1".hmm /workdir/myb7/data/MuskegonLake/prodigal/s${sample}/${sample}_protein_translations.faa > ${sample}.out
        mv ${sample}.out /workdir/myb7/data/MuskegonLake/hmmer/"$1"
done

