# Preparation of interval list file for GATK WES analysis

## BedToIntervalList
# Picard tools require intevral_list instead of Bed files to annotate coordinates of genomic regions.
# In this analysis are two Bed files converted to interval_lists and then combined. The aim is to combine two original interval_lists and keep only genomic regions which are present in both original interval_lists.

# Tried to run BedToIntervalList but got error message
# Received error: Sequence 'chr1' was not found in the sequence dictionary
# Removed 'chr' from chromosome_name of bed file
cat twist_exome.bed | sed 's/chr//g' > twist_exome_v2.bed

# Then received error message picard.PicardException: Sequence '7_gl000195_random' was not found in the sequence dictionary
# Removed contig from the bed file
cat twist_exome_v2.bed | sed '/7_gl000195_random/d' > twist_exome_v3.bed

# Convert a BED file to a Picard Interval List (GATK tool)
source /software/scripts/useuse
reuse Picard-Tools
reuse Java-1.8

java -jar picard.jar BedToIntervalList \
      I=/dir/twist_exome_v3.bed \
      O=/dir/twist_exome.interval_list/
      SD=/dir/reference_hg19/Homo_sapiens_assembly19.fasta



## IntervalListTools (overlaps)
# Combine the intervals from two interval lists, and keeping only overlapping intervals (GATK tool)
java -jar picard.jar IntervalListTools \
       ACTION=OVERLAPS \
       I=dir/twist_exome_v3.bed \
       SI=dir/IDT.interval_list \
       O=dir/combined.interval_list 



## VcfToIntervalList
# Tried to run VcfToIntervalList Picard function and received following error
# Unable to parse header with error: Your input file has a malformed header: We never saw the required CHROM header line
# Downloaded xyz.vcf.gz file and using samtools run
tabix xyz.vcf.gz

# then
java -jar picard.jar VcfToIntervalList \
      I=/dir/xyz.vcf.gz \
      O=/dir/xyz.interval_list/

