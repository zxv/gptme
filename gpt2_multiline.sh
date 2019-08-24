#!/bin/bash
SCRIPT_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
RUN_FROM=/content/grover

cd ${RUN_FROM}
${SCRIPT_PATH}/get_input.sh | PYTHONPATH=${RUN_FROM} python3 ${RUN_FROM}/sample/contextual_generate_cli_multiline.py -model_config_fn lm/configs/mega.json -samples 10 -model_ckpt models/mega/model.ckpt.800000
