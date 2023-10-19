# Run VoxDet locally with Docker

# General info

Because VoxDet is built on many dependencies and some of them may cause compatibility issues with the user's local system. We provide these dedicated instructions, as well as resources, to run VoxDet locally with Docker. 

The Docker image provided in the later section has almost all the packages the user needs to run VoxDet. However, due to the design philosophy of VoxDet, it needs to be `installed` in the system before we run it. This is the only thing that is not included in the Docker image since the code is subject to change after we release the Docker images.

# Preparae the VoxDet code

Clone VoxDet from this fork as usual. Later in this instruction, we will refer to the source code as `voxdet_src`.

# Prepare the data

We only use the [LM-O][lmo_dl] dataset to reproduce the evaluation number in this demo. The user needs to use the [LM-O][lmo_dl] provided by us since VoxDet requires a specific format for the input data.

[lmo_dl]: https://drive.google.com/file/d/1cY8gWF6t0IhEa0nLPVWfHMcPlfTNFPwe/view?usp=sharing

You can download [LM-O][lmo_dl] and create a data structure like this, note that there is a `BOP` folder under `<data>` and `<data>` could be any place the user chooses to store the data.

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

# Prepare the Docker images

## A touch of Docker

We have released the docker image via DockerHub. Normally, the images the user pulled from DockerHub have the `root` as the default user. This imposes some issues and risks to the host system. So we developed a slightly more complicated procedure to prepare a Docker image after pulling it from DockerHub. Specifically, we provide a set of scripts that help the user to augment a freshly-pulled image such that the augmented version has the local user embedded and configured as the default user inside the Docker container.

For users who do not like this idea, please skip the [Augment the raw Docker image](#augment-the-raw-docker-image) section and go to the next section.

## Get the Docker image from DockerHub

Images can be found at [the AirLab's DockerHub page](https://hub.docker.com/repository/docker/theairlab/voxdet/general).

## Augment the raw Docker image

Let's then add the local user to the raw docker image that is just pulled from DockerHub. We will need to clone a new repo and run a single script to do this. Please refer to [the dedicated instructions](https://github.com/castacks/dsta_docker#adding-the-host-user-to-an-image) for more details. 

```bash
cd <awesome location>
git clone https://github.com/castacks/dsta_docker.git
cd dsta_docker/scripts
./add_user_2_image.sh theairlab/voxdet:03_phython4voxdet voxdet:99_local
```

Where `voxdet:99_local` is just a convenient naming such that it always appears at the last if we list and sort all the relevant image names.

# Run the demo

## Start a Docker container
Assuming the tag of the Docker image is set to `voxdet:99_local`.

Create a folder as the working directory of the demo. Results will be saved in this working directory. 

Copy the [start_container.sh](../../docker/start_container.sh) to the working directory and make sure we have the execution permission enabled. Modify the `/path/to/voxdet_src/`, `/path/to/data/BOP/`, and `/path/to/working/directory/` entries to reflect the system settings. Note that the data directory must be specified such that `BOP/` is the last part of the directory. Thus, the source data directory must be the folder that directly contains the `lmo` subfolder. Once the container starts, the above folders will be mapped to `\scripts\`, `\data\`, and `\WD\` folders inside the container. Then run the following command to start the container. 

```bash
cd <working directory>
./start_container.sh voxdet:99_local
```

## Run the script

Copy the [run_inference.sh](../../docker/run_inference.sh) to the working directory. Also, make sure it is executable. Then while being inside the container, run the demo simply by

```bash
# Inside the container.
cd /WD
./run_inference.sh
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
