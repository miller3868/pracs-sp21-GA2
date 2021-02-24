This is a repository for my second assignment.

# Workflow Documentation:

## Make directory, load Git, make README.md file:

`cd /fs/ess/PAS1855/users/miller3868/week06`

`mkdir pracs-sp21-GA2`

`cd pracs-sp21-GA2`

`git init`

`git status` #Not commits yet

`touch README.md` #Make README file in directory and update README as work flow progresses

`git add README.md`

`git commit -m "Create and Add README.md file"` #First commit before adding and manipulating data

## Adding and Committing FASTQ files to Data directory:

`mkdir data`

`cd data`

`mkdir FASTQ`

`cd FASTQ`

`cp /fs/ess/PAS1855/data/week05/fastq/*.fastq .` #Copy the fastq files into my fastq directory

`ls` #Confirm that the files arrived in my directory

`echo "*.fastq" >> .gitignore` #Makes Git ignore fastq files

`git add .gitignore` 

`git add /fs/ess/PAS1855/users/miller3868/week06/pracs-sp21-GA2/data/FASTQ/*` 

`git status`  #Reveals that I can't add the pathways to the fastq data files because I already gave the command to ignore them. Should I have committed the files before I pushed the .gitignore?

`git commit -m "Made .gitignore file"` 

Went up to assignment file to add and commit changes to the README.md file: `cd ../..` 

`git add README.md`

`git commit -m "Updated README file"`

## Load Conda and Cutadapt:

`module load python/3.6-conda5.2`

Configured channels like we did in class:

conda config --add channels defaults

conda config --add channels bioconda

conda config --add channels conda-forge

conda config --get channels #Used to check priorities

`conda create -n cutadapt-env cutadapt` #This creates the new environment with cutadapt installed. I did this in class so didn't need to do it again here. 

`source activate cutadapt-env` #This activates the cutadapt environment

`cutadapt --version` #This checks to make sure it works. 

`conda env export -n Cutadapt > environment.yml` #This exports the environment description to a YAML file. 

git add and git commit YAML file

`source deactivate` 

## Cutadapt script for one sample:

`sinteractive -A PAS1855 -t 20` #provide instructions to the SLURM scheduler to specify the resources (cores/memory/time/etc) needed (20 min specified above)

`sbatch -A PAS1855 -t 20 cutadaptsingle.sh "$f_read" "$output_dir" "$forward_primer" "$reverse_primer"` #Execute the script

`squeue -u $USER`  #Check on the job status

`less slurm-3054013.out` #Check output. This brings up the file in the terminal and I don't know how to get out of it. 

`ls -lh $output_dir`  #Check output directory

`git add --all` 

`git commit -m "Update and add all new files"` #Add and commit all files and changes 


