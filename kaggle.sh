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




_ # 1 config kaggle api
mkdir -p ~/.config/kaggle
cp ~/src/kaggle.json ~/.config/kaggle/
cp ~/kaggle.json ~/.config/kaggle/
chmod 600 ~/.config/kaggle/kaggle.json



_ # 2. init new kernel
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
kernelname="temp01"
mkdir $kernelname
cd $kernelname
# NOTE: metadata required for subsequent push
kaggle kernels pull --metadata $kernelname
cd ..
ls .


# 4. push kernel
kernelname="temp01"
echo kaggle kernels push --path ./$kernelname
cd $kernelname
printf "\n\n\n"
kaggle kernels push --path ./
printf "\n"
cd ..
# https://github.com/Kaggle/kaggle-api/issues/575
# Notebook not found (make sure saved at least 1 version of notebook)

kaggle kernels push


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

type kaggle

#add kaggle to path if needed
function setpath {

    if [ -d "$HOME/.local/bin" ] ; then
        PATH="$HOME/.local/bin:$PATH"
    fi
    type kaggle

}
