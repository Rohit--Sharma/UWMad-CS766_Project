# Evaluation Metric:
To evaluate the predictions of lane markings against the ground truth, the lane markings are viewed as lines with `30` pixel width. Then, the **Jaccard Similarity** score or the **Intersection-over-union (IoU)** is computed between the ground truth and the predictions. To see which predictions are true positives (*TP*), a threshold of `0.5` is used on the *Jaccard similarity* value. Precision and Recall are calculated using *TP*, *FP* and *FN* as follows:

$$
P = \frac{TP}{TP+FP} \\
R = \frac{TP}{TP+FN}
$$

With Precision and Recall, F1-measure is computed to report the final performance of the lane detection model as follows:

$$
F1 = \frac{2PR}{P+R}
$$

# Results on Glaze Subset:
After the preprocessing step of de-glazing is applied on all the images with glaze, the deglazed images were then used to train the SCNN model and the results were evaluated as described above. The following tables show the results of trained model just on the subset of images with glaze. The leftmost table shows the performance of just SCNN model. The next table shows the performance of SCNN model with deglaze preprocessing. The final table shows the performance of SCNN model with deglaze interpolation done by incorporating optical flow information.

<table align="center">
<tr><th>SCNN</th><th>SCNN + DeGlaze</th><th>SCNN + DeGlaze + Flow</th></tr>
<tr>
<td>
<table>
<tr><th>Measure</th><th>Value</th></tr>
<tr><td>Precision</td><td>0.5762</td></tr>
<tr><td>Recall</td><td>0.5519</td></tr>
<tr><td>F1-Measure</td><td>0.5638</td></tr>
</table>
</td><td>
<table>
<tr><th>Measure</th><th>Value</th></tr>
<tr><td>Precision</td><td>0.5717</td></tr>
<tr><td>Recall</td><td>0.5651</td></tr>
<tr><td>F1-Measure</td><td>0.5684</td></tr>
</table>
</td><td>
<table>
<tr><th>Measure</th><th>Value</th></tr>
<tr><td>Precision</td><td>0.5783</td></tr>
<tr><td>Recall</td><td>0.5636</td></tr>
<tr><td>F1-Measure</td><td>0.5708</td></tr>
</table>
</td>
</tr>
</table>

As it can be clearly seen that the F1 score has improved from left to right. An improvement of `0.82%` in F1 measure was achieved over the state of the art model with just Deglaze preprocessing and an improvement of `1.3%` with incorporating optical flow information while interpolating.

Initially, with just deglaze, we were able to increase the F1 score slightly, but it also led to decrease in precision. However, after incorporating optical flow, we were able to improve the Precision over SCNN model also slightly. One could argue that this result is not statistically significant. But this may be because the the dataset of glaze images is too less (486 images) and we are confident that with our approach, given a bigger dataset, we can achieve a significant improvement of lane detection in glaze conditions.

The below video shows lane predictions by the model on real data:

<style>
.image-caption {
  text-align: center;
  font-size: .8rem;
  color: light-grey;
}
</style>

![Video_normal](images/result_normal.gif?raw=true "Video_normal")

{:.image-caption}
*Lane Predictions*

|![Video_deglaze](images/glaze_high.gif?raw=true "Video_glaze")|![Video_deglaze](images/glaze_low.gif?raw=true "Video_deglaze")|
| :---: | :---: |
|Before DeGlaze|After DeGlaze|


{% include lib/mathjax.html %}