
# VoxDet: Voxel Learning for Novel Instance Detection

### Bowen Li, Jiashun Wang, Yaoyu Hu, Chen Wang, and Sebastian Scherer

### NeurIPS'23 :star2: SpotLight :star2:

## NOTE

This is a fork for the internal development in the AirLab for other on-going research project. For the original official repo, please refer to the [VoxDet page][voxdet_ori_link].

[voxdet_ori_link]: https://github.com/Jaraxxus-Me/VoxDet

## Abstract

Detecting unseen instances based on multi-view templates is a challenging problem due to its open-world nature. Traditional methodologies, which primarily rely on $2 \mathrm{D}$ representations and matching techniques, are often inadequate in handling pose variations and occlusions. To solve this, we introduce VoxDet, a pioneer 3D geometry-aware framework that fully utilizes the strong 3D voxel representation and reliable voxel matching mechanism. VoxDet first ingeniously proposes template voxel aggregation (TVA) module, effectively transforming multi-view 2D images into 3D voxel features. By leveraging associated camera poses, these features are aggregated into a compact 3D template voxel. In novel instance detection, this voxel representation demonstrates heightened resilience to occlusion and pose variations. We also discover that a $3 \mathrm{D}$ reconstruction objective helps to pre-train the 2D-3D mapping in TVA. Second, to quickly align with the template voxel, VoxDet incorporates a Query Voxel Matching (QVM) module. The 2D queries are first converted into their voxel representation with the learned 2D-3D mapping. We find that since the 3D voxel representations encode the geometry, we can first estimate the relative rotation and then compare the aligned voxels, leading to improved accuracy and efficiency. In addition to method, we also introduce the first instance detection benchmark, RoboTools, where 20 unique instances are video-recorded with camera extrinsic. RoboTools also provides 24 challenging cluttered scenarios with more than $9 \mathrm{k}$ box annotations. Exhaustive experiments are conducted on the demanding LineMod-Occlusion, YCB-video, and RoboTools benchmarks, where VoxDet outperforms various 2D baselines remarkably with faster speed. To the best of our knowledge, VoxDet is the first to incorporate implicit 3D knowledge for 2D novel instance detection tasks.

## Pre-trained models

## Datasets

## Demos

Please refer the following list for running VoxDet on different platforms.

- Run locally following the original instructions.
- Run locally with docker.
- Run on PSC with singularity. 

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
