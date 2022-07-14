# README
## DATA

Data was transferred from the path /Volumes/Expansion/2022-utexas-OchmcompPOD/projects/2021_pafl_metaG/data/qc-seqs/ to the path /workdir/myb7/data/MuskegonLake/qc_seqs/ via Filezilla

Samples were numbered from 91614 to 91629. Each sample had five flow cell lanes, numbered from 3 to 7. Two reads were taken from each cell lane, for a total of 160 reads stored in fastq files. Each flow cell lane also had an interleaved fastq.gz file containing its two reads, for a total of 80 interleaved files. In total, 240 files were transferred.

Following transfer, fastq files were run through md5sum to verify data integrity using md5sum.sh script and tmux session "md5sum"

Quality fastq files were assessed for quality through fastqc and multiqc in fastqc_multiqc.sh shell script
