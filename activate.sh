#!/bin/bash
CONTENT_PATH=/content
GPTME_PATH="${CONTENT_PATH}/gptme"

# Install dependencies
python3 -m pip install regex jsonlines
python3 -m pip install -U tqdm

# Set up grover
git clone https://github.com/rowanz/grover.git

# Begin bootstrap process
python3 ${GPTME_PATH}/bootstrap.py
cp -R ${GPTME_PATH}/sample ${CONTENT_PATH}/grover

cd grover
# Note:
# :%s#\\n#^M#g
# :%s#\\"#"#g
# :%s#\\'#\'#g
