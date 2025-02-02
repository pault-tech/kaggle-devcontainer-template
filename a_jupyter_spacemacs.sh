#NOTE: prefered method in spacemacs is to use python mode (dont enable ipython-notebook) and install jupytext

#NOTE:a running jupyter server is required for spacemacs ipython-notebook
#for jupytext conversion to work in spacemacs ipython-notebook layer need to
#Have an IPython notebook running and jupytext installed (for conversion)
pip install --user jupytext #sync ipynb .py files; required for 
echo TERM=xterm-256color jupyter notebook #for ipython-notebook

jupytext --to py:percent --output aa.py mynotebook.ipynb #eg command
ls *.py

# unexpected indent FIX
ipython profile create default
# warn(('Ignoring {0} in favour of {1}. Remove {0} to '
# [ProfileCreate] Generating default config file: PosixPath('/home/ubuntu/.ipython/profile_default/ipython_config.py')
# [ProfileCreate] Generating default config file: PosixPath('/home/ubuntu/.ipython/profile_default/ipython_kernel_config.py')
echo "c.TerminalInteractiveShell.autoindent=False" >> ~/.ipython/profile_default/ipython_config.py


#use (ein:notebooklist-open)
