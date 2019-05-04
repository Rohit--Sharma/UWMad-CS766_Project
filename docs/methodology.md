## Heuristic-Deglazing

We first aimed to deglaze images in our dataset using a heuristic based approach. We identified that the main glazed area of concern for lane detection belonged at the bottom portion of the image near the car panes. 
We then divided this bottom region in three windows and identify the glaze pixels using seperate thresholds for the three color channels. 
This is based on the assumption that the glazed pixels are saturated. Further, our selection of only the bottom pane for getting the glaze region helps us avoid saturation caused by sun in the images.
Now, we select only one of the windows as our glazed region, after which we try to interpolate the saturated pixels with neighbouring images. 
We replace the pixel values with nearest unsaturated frame. 

### Smoothing 
We later realised that replacing at the level of pixels added some noise, for which we use gaussian smoothing. 
These deglazed images were then used for training new model as described below. We also evaluated the results of these deglazed directly on pretrained model.   

## SCNN Training

We trained the deglazed images created above using the tensorflow based implementation provided by [SCNN-tensorflow](https://github.com/cardwing/Codes-for-Lane-Detection).
The model was trained on GPU machines provided by [Wisconsin Applied Computing Center](http://wacc.wisc.edu/).
The model for training takes as input the image files as well as their lane markings. The training requires per pixel labels, which are generated using a seperate 
method provided at [Seg_label_generate](https://github.com/XingangPan/seg_label_generate). 

### Segment label generation
This method tries to fit a spline curve by extrapolating the already present manual markings, and write out the per pixel labels. It also identifies the coordinates of the lanes 
using the provided manual points. The authors of SCNN use the same method for their training and evaluation. 

The deglazed images were divided into validation, test and training sets contaning 100, 86, and 300 images respectively. 
We ran the training for 10000 iterations with intermittent checkpointing using a learning rate of 0.01 and nesterov momentum of 0.9. 
The GPU machines used were 4 Tesla V100-SXM2 with a memory fraction of 0.85. We trained the images in batch sizes of 8 using asynchronous training.
  
However, we observed that the number of images for training were very less and the model trained was not good. 
This calls for requirement of more data specific to glazing images to be able to perform training on them.

## Test methodology

We evaluate our results on both the pretrained model and our trained model created above.
For testing on our model, we used a random subset of 100 images sampled above. The models predict probabilities for presence of lane at each pixel in the images.
These probabilities map are then used to generate lane segment predictions. These lane predictions are then connected using spline curve fitting to form continous markings. 
The predicted lanes are compared with the labelled markings on a per-pixel basis, using the evaluation metric described below.    
  

