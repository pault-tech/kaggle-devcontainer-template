i
# TODO: merge this with working project versions

echo a_build.sh $0 $1 $2
echo filename arg $1
echo optional dobatch arg $2

# exit

PROJDIR="/workspaces/_proj-dir/"
cd $PROJDIR
homedir="/home/_todo_"
symlnk="_todo_"



function kaggle_push_kernel {

bn=`basename $1`
fname="${bn%.*}"
echo name is $fname

#
# 4. push kernel
# Kernel push error: Notebook not found
# NOTE above error if notebook was not saved at least once
tm="60" kernelname="_kernel-gnn-p1" #NOTE: underscore and uppercase are invalid chars. eg helloWorld_01 is invalid
tm="120" kernelname="$fname" #NOTE: underscore and uppercase are invalid chars. eg helloWorld_01 is invalid
echo kaggle kernels push --path ./$kernelname
cd $kernelname
pwd
printf "\n\n\n"
kaggle kernels push --path ./
printf "\n"
cd ..
# echo $homedir/bin/winutils.sh kag_mon > /tmp/execstr_kag.sh $tm
echo "$homedir/bin/winutils.sh kag_mon $tm $kernelname" > /tmp/execstr_kag.sh
date
# https://github.com/Kaggle/kaggle-api/issues/575
# Notebook not found (make sure saved at least 1 version of notebook)
}
# kaggle_push_kernel $1
# date

function push_to_gpu {
    
# TODO: use gnu screen on gpu instance for long running cmds
scp -i ~/e104*pem fname/fname_p4.ipynb  ec2-user@gpu:~/
ssh -i ~/e104*pem  ec2-user@gpu \
'source activate pytorch && jupyter nbconvert --to notebook --execute fname_p4.ipynb --output=new.ipynb'


}
# push_to_gpu
# date




function local_jupyter_batch {

#NOTE if needed install papermill 
# echo eval "$(conda shell.bash hook)"
# echo conda activate python3
# echo pip install nbconvert # for batch submission of notebooks
# echo pip install papermill # for batch submission of notebooks

echo      conda install -y --name python3 -c conda-forge papermill nbconvert
# if $( conda list -n python3  | grep -q papermill ); then
# : # do nothing
# else
# conda install -y --name python3 -c conda-forge papermill nbconvert
# fi

bn=`basename $1`
fname="${bn%.*}"
echo name is $fname

# source ~/.bashrc; source ../.env; conda activate python3; echo $CONDA_PREFIX; type ipython
eval "$(conda shell.bash hook)"
conda activate python3

cd $PROJDIR/$fname
set -x
kernelname="_kernel-tts-p1"
kernelname="_kernel-llm"
tm="60" kernelname="$fname" #NOTE: underscore and uppercase are invalid chars. eg helloWorld_01 is invalid
papermill $kernelname.ipynb $kernelname.batchrun.ipynb --log-output -k python3

# kernelname="_kernel-llm"
jupyter nbconvert --to html $kernelname.batchrun.ipynb

# kernelpath="$PROJDIR/$fname/$kernelname.batchrun.ipynb"
# echo "scp spot01:$PROJDIR/$fname/$fname* $homedir/$symlnk/Downloads/;  explorer.exe c:/; " > /tmp/execstr_kag.sh
# echo "scp spot01:$PROJDIR/$fname/$fname*html $homedir/$symlnk/Downloads/;  explorer.exe c:/; " > /tmp/execstr_kag.sh
echo "scp spot01:$PROJDIR/$fname/$fname*html $homedir/$symlnk/Downloads/;  explorer.exe c:/; t 3 '{ctrl+w}{alt+tab}{ctrl+2}r'; " > /tmp/execstr_kag.sh
# sleep 3; ~/bin/t 0 '{ctrl+w}' 

set +x
echo done
date


}
# local_jupyter_batch $1
# date

function _tmp_fix_ipynb_diff_cell_ids {

_git diff cleanup notebook ipynb for magit, eg noisy changing cell-ids cellIds in diffs

pip install nbstripout 

# Using as a Git filter
# Set up the git filter and attributes as described in the manual installation instructions below:

nbstripout --install

# NOTE after installing add --keep-output to commands in .git/config 

# nbstripout --keep-output

pip install nbdime

# To configure all diff/merge drivers and tools, simply call:

# nbdime config-git (--enable | --disable) [--global | --system]
# This command will register nbdime with git for the current project (repository), or on the global (user), or sytem level according to the --global or --system options.
nbdime config-git  --enable

}

# echo optional dobatch arg $2
if [ "$2" = "dobatch" ]; then
    local_jupyter_batch $1
    date
else
    kaggle_push_kernel $1
    date
fi


