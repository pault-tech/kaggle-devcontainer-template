echo conda
conda install -y --name python3 -c conda-forge pandas seaborn \
papermill nbconvert

eval "$(conda shell.bash hook)"
conda activate python3
pip install -U hl7
