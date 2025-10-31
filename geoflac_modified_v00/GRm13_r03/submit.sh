# -S /bin/sh
#PBS -q batch
#PBS -o stdout.$PBS_JOBID
#PBS -e stderr.$PBS_JOBID
#PBS -V
#PBS -q q25g2
#PBS -N GRm
#PBS -l nodes=1:ppn=8

export OMP_NUM_THREADS=8  # same as ppn

cd $PBS_O_WORKDIR
cp $PBS_NODEFILE nodelist.$PBS_JOBID

###coping input &submit file to geoflac_modified_input_and_submit_file
cp submit.sh /scratch2/humaorong/geoflac_modified_input_and_submit/geoflac_modified_v00/GRm13_r03
cp subduction.inp /scratch2/humaorong/geoflac_modified_input_and_submit/geoflac_modified_v00/GRm13_r03

D=/home/humaorong/geoflac_modified

### Recording state of the code
cp $D/src/snapshot.diff .

### Recording starting time
echo $(date)>logtime.txt

### Execute the model
$D/src/flac subduction.inp
#cp _contents.save _contents.rs
#$D/src/flac subduction2.inp

### Recording ending time
echo $(date)>>logtime.txt

### Convert model results
python3 $D/util/flac2vtk.py ./
python3 $D/util/flacmarker2vtk.py ./

# ~~~~ submit command ~~~~
# qsub < [script]



