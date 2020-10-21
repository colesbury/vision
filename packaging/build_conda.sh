#!/bin/bash
set -ex

script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
. "$script_dir/pkg_helpers.bash"

export BUILD_TYPE=conda
setup_env 0.6.0
export SOURCE_ROOT_DIR="$PWD"
setup_conda_pytorch_constraint
setup_conda_cudatoolkit_constraint
setup_visual_studio_constraint
setup_junit_results_folder
mkdir output_folder
conda build -c $CONDA_CHANNEL -c defaults --no-test --output-folder output_folder --python "$PYTHON_VERSION" packaging/torchvision
built_package="$(find output_folder/ -name '*torchvision*.tar.bz2')"
cp "$built_package" "$PYTORCH_FINAL_PACKAGE_DIR/"
