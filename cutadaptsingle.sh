#!/bin/bash
#SBATCH --account=PAS1855
#SBATCH --time=20
#SBATCH --nodes=1
#SBATCH --cpus-per-task=1
#SBATCH --ntasks=1

set -e -u -o pipefail

module load python/3.6-conda5.2
source activate cutadapt-env

#8. Let the script take 4 arguments that can be passed to it on the command-line
f_read=$1  #Path to FASTQ file with forward reads
output_dir=$2  #Name of output directory for trimmed FASTQ files
forward_primer=$3 #Sequence of forward primer
reverse_primer=$4 #Sequence of reverse primer

f_read=data/FASTQ/201-S4-V4-V5_S53_L001_R1_001.fastq
output_dir=/fs/ess/PAS1855/users/miller3868/week06/pracs-sp21-GA2/results/trim
forward_primer="GAGTGYCAGCMGCCGCGGTAA"
reverse_primer="TTACCGCGGCKGCTGRCACTC"

echo "Forward read file $f_read"
echo "Output directory $output_dir"
echo "Forward primer $forward_primer"
echo "Reverse primer $reverse_primer"

#9. Compute the reverse complement for each primer
forward_primer_rc=$(echo "$forward_primer" | tr ATCGYRKMBVDH TAGCRYMKVBHD | rev)
reverse_primer_rc=$(echo "$reverse_primer" | tr ATCGYRKMBVDH TAGCRYMKVBHD | rev)

#10. For file name of forward reads, infer the name of the corresponding FASTQ file with reverse reads
#11. Assign output file paths
r_read="$(dirname "$f_read")/$(basename -s ".fastq" "$f_read" | sed -e 's/_R1_/_R2_/').fastq"

outputF="$output_dir/$(basename -s ".fastq" "$f_read")_trimmed.fastq"
outputR="$output_dir/$(basename -s ".fastq" "$r_read")_trimmed.fastq"

echo "Trimmed forward read $outputF"
echo "Trimmed reverse read $outputR"

#13. Cutadapt
cutadapt -a "$forward_primer"..."$reverse_primer_rc" \
    -A "$reverse_primer"..."$forward_primer_rc" \
    --discard-untrimmed --pair-filter=any \
    -o "$outputF" -p "$outputR" "$f_read" "$r_read"

