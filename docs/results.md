# Evaluation:
To evaluate the predictions of lane markings against the ground truth, the lane markings are viewed as lines with 30 pixel width. Then, the **Jaccard Similarity** score or the **Intersection-over-union (IoU)** is computed between the ground truth and the predictions. To see which predictions are true positives (TP), a threshold of 0.5 is used on the Jaccard similarity value. Precision and Recall are calculated using TP, FP and FN as follows:

Precision = TP / (TP + FP), Recall = TP / (TP + FN)

With Precision and Recall, F1-measure is computed to report the final performance of the lane detection model as follows:

F1 = 2 Precision Recall / (Precision + Recall)

# Results on Glaze Subset:
After the preprocessing step of de-glazing is applied on all the images with glaze, the deglazed images were then used to train the SCNN model and the results were evaluated as described above. The following tables show the results of trained model just on the subset of images with glaze. The leftmost table shows the performance of just SCNN model. The next table shows the performance of SCNN model with deglaze preprocessing. The final table shows the performance of SCNN model with deglaze interpolation done by incorporating optical flow information.

<table>
<tr><th>SCNN</th><th>SCNN + DeGlaze</th><th>SCNN + DeGlaze + Flow</th></tr>
<tr><td>

| Measure | Value |
| :---: | :---: |
| Precision | 0.5762 |
| Recall | 0.5519 |
| F1-Measure | 0.5638 |

</td><td>

| Measure | Value |
| :---: | :---: |
| Precision | 0.5717 |
| Recall | 0.5651 |
| F1-Measure | 0.5684 |

</td><td>

| Measure | Value |
| :---: | :---: |
| Precision | 0.5783 |
| Recall | 0.5636 |
| F1-Measure | 0.5708 |

</td></tr>
</table>

As it can be clearly seen that the F1 score has improved from left to right. An improvement of `0.82%` in F1 measure was achieved over the state of the art model with just Deglaze preprocessing and an improvement of `1.3%` with incorporating optical flow information while interpolating.

Initially, with just deglaze, we were able to increase the F1 score slightly, but it also led to decrease in precision. However, after incorporating optical flow, we were able to improve the Precision over SCNN model also slightly. One could argue that this result is not statistically significant. But this may be because the the dataset of glaze images is too less (486 images) and we are confident that with our approach, given a bigger dataset, we can achieve a significant improvement of lane detection in glaze conditions.