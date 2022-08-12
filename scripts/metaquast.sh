#Run MEGAHIT/spades output files (final.contigs.fa) through metaQUAST
#Mike Bai
#July 2022

#Command
# -o: output directory
# -t: number of threads used

for sample in {91614..91629}
do
        #Go to sample directory
        cd /workdir/myb7/data/MuskegonLake/megahit/s${sample}

        #Start message
        echo "Evaluating assembly of Sample $sample"

        #Run metaQUAST
        metaquast.py final.contigs.fa -t 55 -o /workdir/myb7/data/MuskegonLake/quast_results/s${sample}

        #Finish message
        echo "Finished evaluating assembly of Sample $sample"
done

echo "All assemblies evaluated"
