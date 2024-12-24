#utility script for kaggle competitions
# https://www.kaggle.com/competitions/<competition-path>

function cmd_hints {


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

mkdir -p ~/.config/kaggle
cp ~/src/kaggle.json ~/.config/kaggle/
chmod 600 ~/.config/kaggle/kaggle.json

# kaggle kernels pull gusthema/parkinson-s-disease-progression-prediction-w-tfdf
source ~/.profile #add .local/bin to path
KERNAL_PATH="pt1001/enterhere"
kaggle kernels pull $KERNAL_PATH


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

mkdir mykernel
kaggle kernels init --path mykernel

# metadata required for subsequent push
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
