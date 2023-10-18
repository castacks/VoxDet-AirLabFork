# Run VoxDet locally with Docker

# General info

Because VoxDet is build on many dependencies and some of them may cause compatibility issues with the users local system. We provide this dedicated instructions, as well as resources, to run VoxDet locally with Docker. 

The Docker images provided in the later section has almost all the the packages the user needs to run VoxDet. However, due to the design phylosofy of VoxDet, it needs to be `installed` to the system before we run it. This is the only thing that is not included in the Docker image since the code is subject to change after we release the docker images.

# Preparae the VoxDet code

Clone VoxDet from this fork as usual. Later in this instruction we will refer to the source code as `voxdet_src`.

# Prepare the data

We only use the [LM-O][lmo_dl] dataset to reproduce the evaluation number in this demo. The user need to use the [LM-O][lmo_dl] provided by us since VoxDet requires a specific format of the input data.

[lmo_dl]: https://drive.google.com/file/d/1cY8gWF6t0IhEa0nLPVWfHMcPlfTNFPwe/view?usp=sharing

You can download [LM-O][lmo_dl] and creat data structure like this, note that there is a `BOP` folder under `<data>` and `<data>` could be any place the user chooses to store the data.

```shell
<data>
├── BOP
│   ├── lmo
|   |   ├── test
|   |   ├── test_video
```

# Prepare the pre-trained model

Downlaod the pre-trained model from the link provided by the [original VoxDet repo][voxdet_ori_link]. Then unzip and move the extracted folder to `voxdet_src`. The folder structure should look like this: 

[voxdet_ori_link]: https://github.com/Jaraxxus-Me/VoxDet

```
outputs
├── VoxDet_p1
├── VoxDet_p2_1
└── VoxDet_p2_2
```

# Prepare the Docker images

## A touch of Docker

We have released the docker image via DockerHub. Normally, the images the user pulled from DockerHub have `root` as the default user. This imposes some issues and risks to the host system. So we developed a slightly more complicated procedure to prepare a Docker image after pulling it from DockerHub. Specifically, we provide a set of scripts that help the user to augment a freshly-pulled image such that the agumented version has the local user embedded and configured as the default user inside the Docker container.

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

Where `voxdet:99_local` is just a convidient naming such that it always appears at the last if we list and sort all the relevant image names.

# Run the demo

Assuming the tag of the Docker image is set to `voxdet:99_local`.

Copy the [start_container.sh](../../docker/start_container.sh) as `start_container_local.sh` (Anything ending with `_local` in the file name will be ignored by this git repo. So it is safe to keep it in the repo). Modify the `/path/to/voxdet_src/` and `/path/to/data/` entries to reflect the system settings. Then run the following command to start the container.

```bash
./start_container_local.sh voxdet:99_local
```
