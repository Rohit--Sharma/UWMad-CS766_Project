---
layout: default
title: Home
nav_order: 1
---
 <head>
    <link rel="icon" type="image/png" href="images/favicon1.png">
</head>

## Team Members
- [Rohit Kumar Sharma](mailto:rsharma@cs.wisc.edu)
- [Varun Batra](mailto:vbatra@wisc.edu)
- [Vibhor Goel](mailto:vgoel5@wisc.edu)

---

## Abstract
Given the fact that we are headed towards autonomous driving vehicles, lane detection becomes one of the keyaspects  for  it. Although, there has been some work in the domain of Lane Detection [Lee and Moon, 2018], [Wang et al., 2018], [Leng and Chen, 2010],   real   time implementation  of  robust  lane  detection  algorithms  is still  missing  for  adverse  visibility  conditions.   In  fact, Escanilla  et  al  [Hancock and Escanilla, 2018]  at  UW-Madison  have  done  some  novel  work  in  the  domain of   lane   detection   last   year. Over   the   years,   several  works  on  detection  of  lanes  in  adverse  conditions from image scenes [Shibata et al., 2014], [Fu et al., 2017], [Shen et al., 2018], [Li et al., 2017] have been proposed. We have researched over the task of lane detection in conditions such of glare, provide assistance in autonomous driving vehicles. 

## Table of Contents:
* [Introduction](introduction.md)
* [Methodology](methodology.md)
* [Results](results.md)

## Conclusion:

### Challenges:
- One of the key issues we faced while working on the problem of adverse lane detection is with regards to availability of datasets for adverse conditions of glaze. In fact, there are not many standard datasets with appropriate lane markings even for normal lane images for comparison among different methods. We found [CULane](https://xingangpan.github.io/projects/CULane.html) to be the only dataset that tries to differentialte between different road conditions for detecting lanes. In the absence of large dataset for glaze conditions, we could not train our model over only the deglazed images through our algorithm, and see what improvements could be brought about through specific training.
- Another challenge faced was the availability of GPU clusters for training and testing. We tried gaining access to GPUs through [CHTC](http://chtc.cs.wisc.edu/) and [CloudLab](https://www.cloudlab.us/) clusters, but the GPUs available did not suffice our requirements. We finally setup our process on [WACC](http://wacc.wisc.edu/) cluster, which is a request based system for resource access.
- Further, most of the deglazing techniques known currently focus on interpolation from small glaze regions. However, in our case the glaze portion was quite large and interpolation directly on per-pixel basis added noise as explained in the methodology section. To handle this, we had to resort to heuristic based approaches. 

### Learnings:
- The project helped us learn more about the [Spatial CNN](https://arxiv.org/abs/1712.06080) which exploits the spatial information available on the image in a single layer instead of multiple layers. The Spatial CNN network shows a lot of promise in its basic idea which can be explored in a lot of different problems in computer vision. 
- We learned about the complete flow of lane detection procedure involving label generation (which in itself is very challenging and involves curve fitting techniques to generate pixel markings from manual markings), training, lane prediction, evaluation, etc. 

### Future Work:
- We have currently tested approaches such as optical flow and heuristic based deglazing to detect and interpolate glaze areas in the road images having glaze. Though we tried to train the model specifically on such images for better detection in glaze conditions, the problem of small dataset did not help in learning a good model. Since, we can see that only the testing of these images on normally trained model led to improvement, one direction is to learn specific model for deglaze images. 
- For now, we have kept our focus restricted to glaze images only among adverse visibility conditions in lane detection. There are several such cases which require specific handling as we have explained above such as night, crowded, no line, shadow, curve etc.. Similar to our approach for glaze images, all these conditions can be looked more specifically. Further, this may require a pre-detection of different adverse conditions and use of ensemble of models trained on specific cases for overall improvement.
- Further, we were currently restricted to images available to us collected earlier without camera control and single setting. However, we can control the exposure time available to images in continuous different frames, which can help in better detection of glaze.

## [References](references.md)

## Other Material:
- [Project Proposal](project_proposal.html)
- [Midterm Report](midterm_report.html)
- [End term Presentation](res/FinalPresentation.pptx)
- [Source Code](https://github.com/Rohit--Sharma/UWMad-CS766_Project/)
