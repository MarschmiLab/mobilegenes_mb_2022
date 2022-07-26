#Check integrity of fastq files following transfer


# -c: read md5 sums from file and check them
# --quiet: don't print ok messages, only error messages
mkdir ../qc_seqs/md5sums
for file in /workdir/myb7/data/MuskegonLake/qc_seqs/s916*/*/*.fastq
do
	md5sum $file > ${file}_checkmd5.md5
	md5sum -c --quiet ${file}_checkmd5.md5
	mv /workdir/myb7/data/MuskegonLake/scripts/${file}_checkmd5.md5 /workdir/myb7/data/MuskegonLake/qc_seqs/md5sums
done
echo "Finished testing files"
