#Run interleaved fastq files through MEGAHIT for assembly

#Command
# --12: list of interleaved paired-end libraries (fastq.gz format)
# -o: output directory
# -t: number of threads
# -m: amount of memory
# --min-contig-len: minimum length of contig in output

for sample in {91614..91629}
do
	#Go to sample directory
	cd /workdir/myb7/data/MuskegonLake/qc_seqs/s${sample}

	#Start message
	echo "Starting assembly for $sample"

	#Run assembly
	megahit --12 trimmomatic_bbduk_dedupe_${sample}_L003_interleaved.fastq.gz,trimmomatic_bbduk_dedupe_${sample}_L004_interleaved.fastq.gz,trimmomatic_bbduk_dedupe_${sample}_L005_interleaved.fastq.gz,trimmomatic_bbduk_dedupe_${sample}_L006_interleaved.fastq.gz,trimmomatic_bbduk_dedupe_${sample}_L007_interleaved.fastq.gz \
	-o /workdir/myb7/data/MuskegonLake/megahit/s${sample} -t 55 -m 0.45 --min-contig-len 2000

	#Finish message
	echo "Finished assembly for $sample"
done

echo "All samples assembled"

# Ex: megahit --12 s91614/trimmomatic_bbduk_dedupe_91614_L003_interleaved.fastq.gz,s91614/trimmomatic_bbduk_dedupe_91614_L004_interleaved.fastq.gz,s91614/trimmomatic_bbduk_dedupe_91614_L005_interleaved.fastq.gz,s91614/trimmomatic_bbduk_dedupe_91614_L006_interleaved.fastq.gz,s91614/trimmomatic_bbduk_dedupe_91614_L007_interleaved.fastq.gz \ 
# -o megahit_s91614 -t 55 -m 0.45
