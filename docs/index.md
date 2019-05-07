---
layout: default
title: Home
nav_order: 1
---

## Team Members
- [Rohit Kumar Sharma](mailto:rsharma@cs.wisc.edu)
- [Varun Batra](mailto:vbatra@wisc.edu)
- [Vibhor Goel](mailto:vgoel5@wisc.edu)

---
# Abstract


* [Introduction](introduction.md)
* [Methodology](methodology.md)
* [Results](results.md)

## Other Material:
- [Project Proposal](project_proposal.html)
- [Midterm Report](midterm_report.html)
- [End term Presentation](res/FinalPresentation.pptx)
- [Source Code](https://github.com/Rohit--Sharma/UWMad-CS766_Project/)

## Conclusion:

### Challenges:

- One of the key issues we faced while working on the problem of adverse lane detection is with regards to availability of datasets for adverse conditions of glaze. In fact, there are not many standard datasets with appropriate lane markings even for normal lane images for comparison among different methods. We found CULANE to be the only dataset that tries to differentialte between different road conditions for detecting lanes. In the absence of large dataset for glaze conditions, we could not train our model over only the deglazed images through our algorithm, and see what improvements could be brought about through specific training.

- Another challenge faced was the availability of GPU clusters for training and testing. We tried gaining access to GPUs through CHTC and cloudlab clusters, but the GPUs available did not suffice our requirements. We finally setup our process on WACC cluster, which is a request based system for resource access.

- Further, most of the deglazing techniques known currently focus on interpolation from small glaze regions. However, in our case the glaze portion was quite large and interpolation directly on per-pixel basis added noise as explained in the methodology section. To handle this, we had to resort to heuristic based approaches. 

### Learnings:

- The project helped us learn more about the Spatial CNN which exploits the spatial information available on the image in a single layer instead of multiple layers. The Spatial CNN network shows a lot of promise in its basic idea which can be explored in a lot of different problems in computer vision. 

- We learned about the complete flow of lane detection procedure involving label generation (which in itself is very challenging and involves curve fitting techniques to generate pixel markings from manual markings), training, lane prediction and evaluation etc.. 

### Future Work:


### Future Work:

## [References](references.md)
