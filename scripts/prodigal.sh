#Run contig fasta files through Prodigal gene annotation tool

# -i: input fasta file
# -o: output file (gbk)
# -d: output mRNA file (fa)
# -a: output protein translation file
# -g: translation table (default 11)
# -q: quiet

#Make main Prodigal output directory
mkdir /workdir/myb7/data/MuskegonLake/prodigal


for sample in {91614..91629}
do
	#Make Prodigal sample output directory
	mkdir /workdir/myb7/data/MuskegonLake/prodigal/s${sample}
	#Go to sample output directory
	cd /workdir/myb7/data/MuskegonLake/prodigal/s${sample}

	#Start message
	echo "Starting gene prediction for $sample"

	#Run prediction
	prodigal -i /workdir/myb7/data/MuskegonLake/megahit/s${sample}/final.contigs.fa -g 11 -o ${sample}_predicted_genes.gff -d ${sample}_mrna.fa -a ${sample}_protein_translations.faa -q
	
	#Finish message
	echo "Finished gene prediction for $sample" 
done
