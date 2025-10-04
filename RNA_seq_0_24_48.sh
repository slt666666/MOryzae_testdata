hisat2-build assembly.fasta assembly

for i in infect_0h_rep1 infect_0h_rep2 infect_0h_rep3 infect_24h_rep1 infect_24h_rep2 infect_24h_rep3 infect_48h_rep1 infect_48h_rep2 infect_48h_rep3;do
    wget -O ${i}.fastq.gz https://raw.githubusercontent.com/slt666666/MOryzae_testdata/refs/heads/main/${i}.fastq.gz
    hisat2 -x assembly -U ${i}.fastq.gz | samtools sort -O bam > ${i}.bam
    samtools index ${i}.bam
done

stringtie *.bam -o transcripts.gtf

featureCounts -a transcripts.gtf -o counts.txt *.bam