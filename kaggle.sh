#utility script for kaggle competitions
# https://www.kaggle.com/competitions/<competition-path>

function cmd_hints {


_ # 0. install cli kaggle api
sudo apt update

sudo apt-get install python3-pip -y

alias pip=pip3

alias python=python3

#NOTE: prefered method in spacemacs is to use python mode (dont enable ipython-notebook) and install jupytext
pip install --user jupytext #sync ipynb .py files; required for 

type jupytext

pip install --user kaggle

pip install kaggle

echo $PATH

cp /workspaces/dotfiles/.profile_golang ~/.profile #NOTE s3 devcontainer image .profile breaks path so fix with this as of 2024/12. also see setpath below

type kaggle

kaggle competitions list


}


function config_kaggle {
pip install --user kaggle

_ # 1 config kaggle api
mkdir -p ~/.config/kaggle
cp ~/src/kaggle.json ~/.config/kaggle/
cp ~/kaggle.json ~/.config/kaggle/
chmod 600 ~/.config/kaggle/kaggle.json
sleep 1
kaggle competitions list
cp ~/dotfiles-spacemacs/.dir-locals.el ./  # initialize mysubmit-build-cmd


}

# 2. init new kernel
function init_kernel {

kernelname="tmp1"
mkdir $kernelname
kaggle kernels init --path $kernelname
ls $kernelname/

mv $kernelname/kernel-metadata.json $kernelname/_kernel-metadata.json.orig
# {
#   "id": "accountid/INSERT_KERNEL_SLUG_HERE",
#   "title": "INSERT_TITLE_HERE",
#   "code_file": "INSERT_CODE_FILE_PATH_HERE",
#   "language": "Pick one of: {python,r,rmarkdown}",
#   "kernel_type": "Pick one of: {script,notebook}",
#   "is_private": "true",
#   "enable_gpu": "false",
#   "enable_tpu": "false",
#   "enable_internet": "true",
#   "dataset_sources": [],
#   "competition_sources": [],
#   "kernel_sources": [],
#   "model_sources": []
# }

IFS=  && read -d EOM json_config << EOM
{
  "id": "accountid/$1",
  "title": "$1",
  "code_file": "$1",
  "language": "$2",
  "kernel_type": "$3",
  "is_private": "true",
  "enable_gpu": "false",
  "enable_tpu": "false",
  "enable_internet": "true",
  "dataset_sources": [],
  "competition_sources": [],
  "kernel_sources": [],
  "model_sources": []
}
EOM
# echo $json_config
echo $json_config > $kernelname/kernel-metadata.json
cat $kernelname/kernel-metadata.json

kaggle help kernels init

}

# 3. pull existing kernel
# kaggle kernels pull gusthema/parkinson-s-disease-progression-prediction-w-tfdf
source ~/.profile #add .local/bin to path
# kernelname="helloworld-01" #NOTE: underscore and uppercase are invalid chars. eg helloWorld_01 is invalid
kernelname="adl-1-gradientcalc" #NOTE: underscore and uppercase are invalid chars. eg helloWorld_01 is invalid
mkdir $kernelname
cd $kernelname
# NOTE: metadata required for subsequent push
printf "\n\n"
set -x
kaggle kernels pull --metadata $kernelname
set +x
cd ..
ls .



}



function kaggle_push_kernel {
#
# 4. push kernel
# Kernel push error: Notebook not found
# NOTE above error if notebook was not saved at least once
# https://github.com/Kaggle/kaggle-api/issues/575
# Notebook not found (make sure saved at least 1 version of notebook)
kernelname="temp01" #NOTE: underscore and uppercase are invalid chars. eg helloWorld_01 is invalid
echo kaggle kernels push --path ./$kernelname
cd $kernelname
printf "\n\n\n"
kaggle kernels push --path ./
printf "\n"
cd ..
}


if [ "$1" = "config_kaggle" ]; then
    config_kaggle
else
    kaggle_push_kernel
fi






function cmd_hints2 {

KERNAL_NAME=""
jupyter nbconvert --to python $KERNAL_NAME

# mkdir -p input/amp-parkinsons-disease-progression-prediction
DATA_PATH=""
mkdir -p input/$DATA_PATH

cd input/DATA_PATH
kaggle competitions download -c DATA_PATH
unzip DATA_PATH

kaggle datasets list

cd workspace/kaggle*


# pip install --user tensorfljow (throws killed error, mb oom?)
# pip install --user tensorflow --no-cache-dir
pip install --user tensorflow_decision_forests --no-cache-dir
# %pip install --quiet --exists-action i --disable-pip-version-check -r ../requirements.txt --user


whoami
pwd
sudo mkdir /kaggle
sudo chown codespace /kaggle
ln -s /workspaces/kaggle-parkinsons/input /kaggle/
ls /kaggle/input/

pip install --user nbconvert

#NOTE: required for spacemacs!!
#for jupytext conversion to work in spacemacs ipython-notebook layer need to
#Have an IPython notebook running
pip install --user jupytext #sync ipynb .py files; required for 
jupyter notebook


curl localhost:8888
echo done


# NOTE: metadata required for subsequent push
kaggle kernels pull --metadata pt1001/parkinson-s-disease-progression-prediction-w-tfdf

# mkdir kernels
cd kernels
kaggle kernels pull cdeotte/prot-bert-finetune-lb-0-30
kaggle kernels pull gusthema/parkinson-s-disease-progression-prediction-w-tfdf
#
jupyter nbconvert --to html parkinson-s-disease-progression-prediction-w-tfdf.ipynb

# kaggle kernels push --path parkinson-s-disease-progression-prediction-w-tfdf.ipynb

kaggle kernels push --path ./

kaggle kernels output pt1001/parkinson-s-disease-progression-prediction-w-tfdf

kaggle kernels

kaggle kernels output

}





#add kaggle to path if needed
function setpath {

    if [ -d "$HOME/.local/bin" ] ; then
        PATH="$HOME/.local/bin:$PATH"
    fi
    type kaggle

}
