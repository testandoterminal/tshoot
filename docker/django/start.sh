#!/bin/bash

workdir=/opt/helloworld/app
python_bin="/usr/local/bin/python"

cd ${workdir}
source .venv/bin/activate
${python_bin} manage.py runserver 0.0.0.0:8080


