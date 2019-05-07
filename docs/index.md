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
	- [Motivation](introduction.md/#motivation)
	- [Spatial Convolutional Neural Network](introduction.md/#spatial-convolutional-neural-network)
* [Methodology](methodology.md)
	- [Adverse Condition - Glaze](methodology.md/#adverse-condition---glaze)
		1. [DeGlazing](methodology.md/#1.-deglazing)
		2. [SCNN + DeGlaze Training](methodology.md/#2.-scnn-+-deglaze-training)
	- [Testing SCNN + DeGlaze](methodology.md/#testing-scnn-+-deglaze)
* [Results](results.md)
	- [Evaluation Metric](results.md/#evaluation-metric)
	- [Results on Glaze Subset](results.md/#results-on-glaze-subset)
* [Conclusion](conclusion.md)
	- [Challenges](conclusion.md/#challenges)
	- [Learnings](conclusion.md/#learnings)
	- [Future Work](conclusion.md/#future-work)
* [References](references.md)

## Other Material:
- [Project Proposal](project_proposal.html)
- [Midterm Report](midterm_report.html)
- [End term Presentation](res/FinalPresentation.pptx)
- [Source Code](https://github.com/Rohit--Sharma/UWMad-CS766_Project/)
