#Assess read quality through fastqc and multiqc

mkdir fastqc_html #Make directory for fastqc outputs
mkdir multiqc_html #Make directory for multiqc outputs
for number in {91614..91629} #91614 through 91629 represent sample numbers
do
  	mkdir fastqc_html/s$number #Create subdirectories for each sample

	# -o: output directory where fastqc output files will be created
	# -q: only reports error messages
	fastqc s*/*/*${number}*.fastq -o fastqc_html/s$number -q #fastqc on each read

	# -o: output directory where multiqc output files will be created
	# -n: name of output file
	multiqc fastqc_html/s$number/*${number}*.zip \ #multiqc on each fastq.zip file
	-o multiqc_html -n ${number}_report.html
done 
