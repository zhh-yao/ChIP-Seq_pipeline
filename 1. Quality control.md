## Quality control (QC)
### Check the sequencing quality
Using [FastQC](https://www.bioinformatics.babraham.ac.uk/projects/fastqc/) to provide a quality control report which can spot problems which originate either in the sequencer or in the starting library material.

```shell
conda install fastqc
fastqc --version
```

Run FastQC:

```shell
fastqc -o fastqc/report/address -f fastq fastq/R1.fastq
fastqc -o fastqc/report/address -f fastq fastq/R2.fastq
```

After generating reports for different samples, [MultiQC](https://multiqc.info/) can help you merge the results together. 

```shell
conda install multiqc
multiqc --version
```

Run MultiQC:

```shell
cd fastqc/report/address
multiqc .
```

You will find a `multiqc_report.html` file containing FastQC results for all samples.

### Trim sequencing
You need to clean the reads based on the QC report. [Cutadapt](https://cutadapt.readthedocs.io/en/stable/) is a tool for this.

```shell
conda create -n cutadaptenv cutadapt
conda activate cutadaptenv
cutadapt --version
```
For example, trimming the universal illumina adapter

```shell
cutadapt -a AGATCGGAAGAGCACACGTCTGAACTCCAGTCA -A AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT -o tr_R1.fastq -p tr_R2.fastq R1.fastq R2.fastq
```

or removing a fixed number (10bp) of bases

```shell
cutadapt -u 10 -o tr_R1.fastq -p tr_R2.fastq R1.fastq R2.fastq
```

or removing too short reads (usually caused by trimming adapter)

```shell
cutadapt -m 10 -o tr_R1.fastq -p tr_R2.fastq R1.fastq R2.fastq
```

The above are just some trimming examples. The specific parts that need to be cleaned up must be strictly based on your QC report.
