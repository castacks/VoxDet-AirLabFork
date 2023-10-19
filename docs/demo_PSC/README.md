# Run VoxDet on PSC with Singularity

# General info

The general procedure and instructions are rather similar to [running demo locally with Docker](../demo_local_docker/README.md). With the difference that the Singularity image does not need augmentation (thus, the Singularity image does not need to add a new user). The user is encouraged to read the [instructions on using Docker](../demo_local_docker/README.md).

# Preparae the VoxDet code

Clone VoxDet from this fork as usual. Later in this instruction, we will refer to the source code as `voxdet_src`.

# Prepare the data

We only use the [LM-O][lmo_dl] dataset to reproduce the evaluation metrics in this demo. The user needs to use the [LM-O][lmo_dl] provided by us since VoxDet requires a specific format for the input data.

[lmo_dl]: https://drive.google.com/file/d/1cY8gWF6t0IhEa0nLPVWfHMcPlfTNFPwe/view?usp=sharing

You can download [LM-O][lmo_dl] and create a folder structure like this, note that there is a `BOP` folder under `<data>`. Here, `<data>` could be any place the user chooses to store the data.

```shell
<data>
├── BOP
│   ├── lmo
|   |   ├── test
|   |   ├── test_video
```

# Prepare the pre-trained model

Download the pre-trained model from the link provided by the [original VoxDet repo][voxdet_ori_link]. Then unzip and move the extracted folder to `voxdet_src`. The folder structure should look like this: 

[voxdet_ori_link]: https://github.com/Jaraxxus-Me/VoxDet

```
outputs
├── VoxDet_p1
├── VoxDet_p2_1
└── VoxDet_p2_2
```

# Prepare the Singularity image

The Singularity image could be generated from the Docker image we released for this research. Dicker images can be found at [the AirLab's DockerHub page](https://hub.docker.com/repository/docker/theairlab/voxdet/general). To build the Singularity image on PSC, run the following

```bash
cd <location for storing Singularity images>
singularity build \
    voxdet.sif \
    docker://theairlab/voxdet:03_python4voxdet
```

# Run the demo

## Prepare the working directory

Create a folder as the working directory of the demo. Results will be saved in this working directory.

Copy the scripts [inference.job](../../singularity/inference.job) and [inference.sh](../../singularity/inference.sh) to the working directory. Make sure that they are executable.

Modify the copied `inference.job` such that it reflects the correct system setting. Note that the data directory must be specified such that `BOP/` is the last part of the directory. Thus, the source data directory must be the folder that directly contains the `lmo` subfolder. Once the container starts, the above folders will be mapped to `\scripts\`, `\data\`, and `\WD\` folders inside the container. Then run the following command to start the container. 

## Start an interactive session on PSC

We only need a single GPU for running the demo.

## Run inference

```bash
cd <working directory>
./inference.job
```

The last part of a sample terminal printout may look like the following:

```
loading annotations into memory...
Done (t=0.01s)
creating index...
index created!
1
load checkpoint from local path: outputs/VoxDet_p2_2/iter_100.pth
[                                                  ] 0/1514, elapsed: 0s, ETA:
[>>>>>>>>>>>>>>>>>>>>>>>>>>>] 1514/1514, 9.0 task/s, elapsed: 169s, ETA:     0s
writing results to /WD/VoxDet_p2_2/lmo_100_202310.pkl

Evaluating bbox...
Loading and preparing results...
DONE (t=0.31s)
creating index...
index created!
Running per image evaluation...
Evaluate annotation type *bbox*
DONE (t=0.29s).
Accumulating evaluation results...
DONE (t=0.02s).
Average Recall     (AR) @[ IoU=0.50:0.95 | area=   all | maxDets=  1 ] = 0.293
Average Recall     (AR) @[ IoU=0.50      | area=   all | maxDets=  1 ] = 0.432
Average Recall     (AR) @[ IoU=0.75      | area=   all | maxDets=  1 ] = 0.335
Average Recall     (AR) @[ IoU=0.95      | area=   all | maxDets=  1 ] = 0.008
Average Recall     (AR) @[ IoU=0.50:0.95 | area= small | maxDets=  1 ] = 0.019
Average Recall     (AR) @[ IoU=0.50:0.95 | area=medium | maxDets=  1 ] = 0.330
Average Recall     (AR) @[ IoU=0.50:0.95 | area= large | maxDets=  1 ] = 0.328

+----------+-------+----------+-------+----------+-------+----------+-------+
| category | mAR@1 | category | mAR@1 | category | mAR@1 | category | mAR@1 |
+----------+-------+----------+-------+----------+-------+----------+-------+
| 1        | 0.281 | 5        | 0.374 | 6        | 0.205 | 8        | 0.120 |
| 9        | 0.472 | 10       | 0.336 | 11       | 0.133 | 12       | 0.557 |
+----------+-------+----------+-------+----------+-------+----------+-------+
OrderedDict()
```
