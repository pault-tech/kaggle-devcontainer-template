#NOTE: prefered method in spacemacs is to use python mode (dont enable ipython-notebook) and install jupytext

#NOTE:a running jupyter server is required for spacemacs ipython-notebook
#for jupytext conversion to work in spacemacs ipython-notebook layer need to
#Have an IPython notebook running and jupytext installed (for conversion)
pip install --user jupytext #sync ipynb .py files; required for 
echo TERM=xterm-256color jupyter notebook #for ipython-notebook

#use (ein:notebooklist-open)
