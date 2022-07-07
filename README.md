# mobilegenes_mb_2022

# Summer 2022 Project

## Installing SRA Toolkit
1. Fetch tar file from [NCBI github]([url](https://github.com/ncbi/sra-tools/wiki/02.-Installing-SRA-Toolkit))
2. Extract contents of tar.gz file with the command:
```
tar -vxzf sratoolkit.tar.gz
```

3. Begin toolkit configuration with the command:
```
vdb-config -i
```
On the new screen:
  - Enabled Local Access on the main screen 
  - Enabled Local File-Cacheing on the "Cache" tab
  - Set Location of User Repository to /workdir/myb7/data/MuskegonLake/SRA_data
  - Accepted to "report cloud instance identity" in the "AWS" tab

## Downloading Metagenomic Sequences

- Sequences can be found on [NCBI]([url](https://www.ncbi.nlm.nih.gov/sra?linkname=bioproject_sra_all&from_uid=705524))
- Compile sequences into an Accession List text file using "Send to:"
- Download sequences with: 
```
prefetch --option file SraAccList.txt
```
Prefetch is a command in the SRA toolkit that downloads sequence files
- for --option file, input a list of sequence files, i.e. an Accession List.

