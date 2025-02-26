
# Run VoxDet locally (almost the original instructions)

# NOTE

Most of the instructions here are copied from the [original VoxDet repo][voxdet_ori_link], WITHOUT testing simply because VoxDet's original way of code deployment may cause some compatibility issues. Users are encouraged to follow the instructions for using [Docker](../demo_local_docker/README.md) and [Singularity](../demo_PSC/README.md) where environments are isolated in containers and no compatibility issues should occur.

[voxdet_ori_link]: https://github.com/Jaraxxus-Me/VoxDet

# Requirements

The original repo is tested under Python 3.7, PyTorch 1.7.0, Cuda 11.0, and mmcv==1.2.5.

# Installation

This repo is built based on [mmdetection](https://github.com/open-mmlab/mmdetection). 

For evaluation, you also need [bop_toolkit](https://mega.nz/file/BAEj3TgS#yzwX2AHUg9CtCsmDV17rxVkmFhw4mh34y6gvQ3FDS4E)

You can use the following commands to create conda env with related dependencies.
```shell
conda create -n voxdet python=3.7 -y
conda activate voxdet
conda install pytorch=1.7.0 torchvision cudatoolkit=11.0 -c pytorch -y
pip install mmcv-full==1.2.7
pip install -r requirements.txt
pip install -v -e . 

cd ..
cd bop_toolkit
pip install -e .
```

# Prepare datasets

We only use the [LM-O][lmo_dl] dataset to reproduce the evaluation number in this demo. The user need to use the [LM-O][lmo_dl] provided by us since VoxDet requires a specific format of the input data.

[lmo_dl]: https://drive.google.com/file/d/1cY8gWF6t0IhEa0nLPVWfHMcPlfTNFPwe/view?usp=sharing

You can download [LM-O][lmo_dl] and creat data structure like this, note that there is a `BOP` folder under `data`:

```shell
VoxDet
├── mmdet
├── tools
├── configs
├── data
│   ├── BOP
│   │   ├── lmo
|   |   |   ├── test
|   |   |   ├── test_video
```

You can also compile your custom instance detection dataset using [this toolkit](https://github.com/Jaraxxus-Me/OWID-toolkit.git), it is very useful :)

# Testing

Our trained [models and raw results](https://drive.google.com/file/d/1VrXcT6tQwhR0zDlANribjcyAritFqKn7/view?usp=sharing) for all the stages are available for download. 

Place it under `outputs/` and run the following commands to test VoxDet on LM-O dataset.

```shell
bash tools/test.sh
```

By default, the script will only calculate results from the raw `.pkl` files, to actually run VoxDet, you need to change the output file name in the command like

```shell
# lmo
python3 tools/test.py --config configs/voxdet/${CONFIG}.py --out outputs/$OUT_DIR/lmo1.pkl \
--checkpoint outputs/VoxDet_p2_2/iter_100.pth >> outputs/$OUT_DIR/lmo1.txt
```

The results will be shown in the `.txt` file.

# Training

Our training set OWID will be released upon acceptance, while we provide the code and script here:

```shell
# Single-GPU training for the reconstruction stage
bash tools/train.sh

# Multi-GPU training for the base detection, this should already produce the results close to table 1
bash tools/train_dist.sh

# Optional, use ground truth rotation for supervision for (slightly) better result, see table 4 for details
bash tools/train_dist_2.sh

```

