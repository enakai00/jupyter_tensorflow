#!/bin/bash 
trap 'pkill -f jupyter-notebook; sleep 3; exit 0' EXIT

if [ "${PASSWORD-undef}" = "undef" ]; then
  export PASSWORD='passw0rd'
fi

if ! grep -E '^c.NotebookApp.password =' $HOME/.jupyter/jupyter_notebook_config.py; then
  HASH=$(python -c "from IPython.lib import passwd; print(passwd('${PASSWORD}'))")
  echo "c.NotebookApp.password = u'${HASH}'" >>$HOME/.jupyter/jupyter_notebook_config.py
fi
unset PASSWORD
unset HASH

mkdir -p $HOME/notebook
cd $HOME/notebook
jupyter notebook
