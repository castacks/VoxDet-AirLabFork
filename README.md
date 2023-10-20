
# VoxDet: Voxel Learning for Novel Instance Detection

### Bowen Li, Jiashun Wang, Yaoyu Hu, Chen Wang, and Sebastian Scherer

### NeurIPS'23 :star2: SpotLight :star2:

## NOTE

This is a fork for the internal development in the AirLab for other on-going research project. For the original official repo, please refer to the [VoxDet page][voxdet_ori_link].

[voxdet_ori_link]: https://github.com/Jaraxxus-Me/VoxDet

## Abstract

Detecting unseen instances based on multi-view templates is a challenging problem due to its open-world nature. Traditional methodologies, which primarily rely on $2 \mathrm{D}$ representations and matching techniques, are often inadequate in handling pose variations and occlusions. To solve this, we introduce VoxDet, a pioneer 3D geometry-aware framework that fully utilizes the strong 3D voxel representation and reliable voxel matching mechanism. VoxDet first ingeniously proposes template voxel aggregation (TVA) module, effectively transforming multi-view 2D images into 3D voxel features. By leveraging associated camera poses, these features are aggregated into a compact 3D template voxel. In novel instance detection, this voxel representation demonstrates heightened resilience to occlusion and pose variations. We also discover that a $3 \mathrm{D}$ reconstruction objective helps to pre-train the 2D-3D mapping in TVA. Second, to quickly align with the template voxel, VoxDet incorporates a Query Voxel Matching (QVM) module. The 2D queries are first converted into their voxel representation with the learned 2D-3D mapping. We find that since the 3D voxel representations encode the geometry, we can first estimate the relative rotation and then compare the aligned voxels, leading to improved accuracy and efficiency. In addition to method, we also introduce the first instance detection benchmark, RoboTools, where 20 unique instances are video-recorded with camera extrinsic. RoboTools also provides 24 challenging cluttered scenarios with more than $9 \mathrm{k}$ box annotations. Exhaustive experiments are conducted on the demanding LineMod-Occlusion, YCB-video, and RoboTools benchmarks, where VoxDet outperforms various 2D baselines remarkably with faster speed. To the best of our knowledge, VoxDet is the first to incorporate implicit 3D knowledge for 2D novel instance detection tasks.

## Pre-trained models

Pre-trained models is provided by the [origianl VoxDet repo][voxdet_ori_link] and can be accessed directly [here](https://drive.google.com/file/d/1VrXcT6tQwhR0zDlANribjcyAritFqKn7/view). 

The folder structure of the downloaded zip file looks like the following.

```
outputs
├── VoxDet_p1
├── VoxDet_p2_1
└── VoxDet_p2_2
```

where p1 and p2 are for different phases of the training process.

NOTE: the folder also contains the original model outputs that are present in the published paper. The default behavior of the code is to retreive the results from the saved files if they are available. So it is important to configure the command line argument when running the following demos in the such a way that new results are generated instead of reading old results from the file system.

## Datasets

VoxDet is trained on a newly created dataset that we created for this research project. It is tested on some existing public datasets and a new benchmark dataset we created just for evaluating VoxDet and baseline models. For more details about the datasets, please refer to the [original VoxDet repo][voxdet_ori_link].

For running the following demos, we only use the LM-O dataset considering its smaller size. Since VoxDet assumes that input data is arranged in a specific format, the user needs to download a [specific version](https://drive.google.com/file/d/1cY8gWF6t0IhEa0nLPVWfHMcPlfTNFPwe/view) of the LM-O dataset to be able to run the demos.

## Demos

Please refer the following list for running VoxDet on different platforms.

- [Run locally following the original instructions.](docs/demo_local_original/README.md)
- [Run locally with docker.](docs/demo_local_docker/README.md)
- [Run on PSC with singularity. ](docs/demo_PSC/README.md)

## Reference
If our work inspires your research, please cite us as:

```
@INPROCEEDINGS{Li2023vox,       
	author={Li, Bowen and Wang, Jiashun and Hu, Yaoyu and Wang, Chen and Scherer, Sebastian},   
	booktitle={Proceedings of the Advances in Neural Information Processing Systems (NeurIPS)}, 
	title={{VoxDet: Voxel Learning for Novel Instance Detection}},
	year={2023},
	volume={},
	number={}
}
```

## Point of contact

For using and discussing this particulary fork, plcase contact [Yaoyu Hu](mailto:yaoyuh@andrew.cmu.edu).
