#Heuristic-Deglazing

We first aimed to deglaze images in our dataset using a heuristic based approach. We identified that the main glazed area of concern for lane detection belonged at the bottom portion of the image near the car panes. 
We then divided this bottom region in three windows and identify the glaze pixels using seperate thresholds for the three color channels. 
This is based on the assumption that the glazed pixels are saturated. Further, our selection of only the bottom pane for getting the glaze region helps us avoid saturation caused by sun in the images.
Now, we select only one of the windows as our glazed region, after which we try to interpolate the saturated pixels with neighbouring images. 
We replace the pixel values with nearest unsaturated frame. 

We later realised that replacing at the level of pixels added some noise, for which we use gaussian smoothing. 
These deglazed images were then used for training new model as described below. We also evaluated the results of these deglazed directly on pretrained model.   

## SCNN Training

We trained the deglazed images created above using the tensorflow based implementation provided by [SCNN-tensorflow](https://github.com/cardwing/Codes-for-Lane-Detection).
The model was trained on GPU machines provided by [Wisconsin Applied Computing Center](http://wacc.wisc.edu/).
The model for training takes as input the image files as well as their lane markings. The training requires per pixel labels, which are generated using a seperate 
method provided at [Seg_label_generate](https://github.com/XingangPan/seg_label_generate). This method tries to fit a spline curve on already present manual markings. 
This gives us the lane markings and labels per pixel basis, and is the same method used by the authors of SCNN for their training and evaluation. 
The deglazed images were divided into validation, test and training sets and run till 100000 iterations. However, we observed that the number of images for training were very less and the model trained was not good. 
This calls for requirement of more data specific to glazing images to be able to perform training on them.

## Evaluation  

   
 