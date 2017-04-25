#!/bin/bash

if [ "${BASH_ARGC}" != "1" ]
then
  virtualenv_dir="__"
else
  virtualenv_dir="${BASH_ARGV[0]}"
fi  

echo "virtualenv_dir: ${virtualenv_dir}"

if [ ! -d ${virtualenv_dir} ]
then
  echo "no ${virtualenv_dir}. will create one"
  the_python=`which python3`
  if [ "${the_python}" == "" ]
  then
    the_python=`which python`
  fi
  virtualenv --prompt="[`basename \`pwd\` `] " -p "${the_python}" "${virtualenv_dir}"
fi

source ${virtualenv_dir}/bin/activate
the_python_path=`which python`
echo "python: ${the_python_path}"

echo "current_dir: "
pwd

# requires
pip install pyramid==1.7
pip install sniffer

# post setup
python setup.py develop

rm setup.py
rm -rf .git

pcreate -s init_dev3 .
rm -rf app.egg-info

python setup.py develop

pip install -r requirements.txt

git init; git add .; git commit -m "init dev"
