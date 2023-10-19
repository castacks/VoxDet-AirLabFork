#!/bin/bash

echo ""
echo "==================================="
echo "========== Before VoxDet =========="
echo "==================================="
echo ""

MODEL_SAVE_DIR=VoxDet_p2_2
CONFIG=VoxDet_test_containerized
ITER=100

OUTPUT_SUFFIX="202310"

cd /scripts/

# ========== Augment the container. ==========

# Install/Refresh VoxDet while in a container.
pip3 install -e .

# ========== Perform inference. ==========

# Set up the output directory.
mkdir -p /WD/${MODEL_SAVE_DIR}/

# Inference on LM-O dataset.
DATASET="lmo"
python3 tools/test.py \
	--config configs/voxdet/${CONFIG}.py \
	--checkpoint outputs/${MODEL_SAVE_DIR}/iter_${ITER}.pth \
	--out /WD/${MODEL_SAVE_DIR}/${DATASET}_${ITER}_${OUTPUT_SUFFIX}.pkl \
	| tee /WD/${MODEL_SAVE_DIR}/${DATASET}_${ITER}_${OUTPUT_SUFFIX}.txt

echo ""
echo "=================================="
echo "========== After VoxDet =========="
echo "=================================="
echo ""
