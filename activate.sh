#!/bin/bash
CONTENT_PATH=/content
GPTME_PATH="${CONTENT_PATH}/gptme"

ln -s ${CONTENT_PATH} ~/content -f

# Install dependencies
python3 -m pip install regex jsonlines
python3 -m pip install -U tqdm

# Set up grover
git clone https://github.com/rowanz/grover.git

# Begin bootstrap process
cd grover
python3 ${GPTME_PATH}/bootstrap.py
cp -R ${GPTME_PATH}/sample ${CONTENT_PATH}/grover

# Start SSH reverse shell
${GPTME_PATH}/ssh.sh

# Note:
# :%s#\\n#^M#g
# :%s#\\"#"#g
# :%s#\\'#\'#g
