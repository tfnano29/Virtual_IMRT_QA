# Effects of L-Norm loss fuctions on Virtual IMRT QA
<p float="left" width="800">
   The purpose of this work is to compare the models resulting from using the mean squared error or the maximum possible error (max-error)  as a loss function. Our hypothesis was that reducing the mean error over the population, as done when using low-order norms, may not be appropriate because we might incur big errors for specific plans. Reducing the maximum possible error (max-error), as done when using Chebyshev Minimax or high-order norms, may help ensure that all plans are still predicted within a boundary at the cost of a increased mean error over the whole population.
</p>

<h1>In-sample performance with L2 and L-infinity (Minimax)</h1>
<p>
   Predicted and actual (measured) passing rate for OLS (top-left) and Minimax (top-right) models. Solid line is the perfect agreement line and +/-3% are dashed lines, showing that no plans pass this threshold with the MM model. Features of importance for OLS (bottom-left) and Minimax (bottom-right) models shows the two most important features for both models are ‘AvgArea’ and ‘Average MLC Aperture'.
</p>

<p float="left">
  <img src="figures/Figure1_pred_features.png" width="800" />
</p>

<h1>In-sample performance with various L-Norm loss functions</h1>
<p>
   Prediction error histograms from models using variou normalizations (L1 - L100). A larger number of predictions have zero error with low order Norms (L1 and L2), however, a narrower spread were found with higher order Norms (>L15) indicating a lower max error and fewer outliers.
</p>

<table border="0px">
   <tr>
      <td width="400">L-Norm = argmin <br/><img src="figures/normalization_eq.gif" width="150" /></td>
      <td><img src="figures/normalization_result_2.gif" width="400" /></td>
   </tr>
</table>

<!--
<img src="figures/normalization_eq.gif" width="150" /> <img src="figures/normalization_result_2.gif" width="500" />
-->

<h1>Out-of-sample performance</h1>
<p>
   Mean-squared error and max-error are shown on the training dataset for models of different normalization (left) and their out-of-sample performance using the leave-one-out method (right). The training results show that normalization as low as L15 give similar results as Minimax
</p>

<p float="left">
   <img src="figures/LNorm_train.png" width="400"/>
   <img src="figures/LNorm_test.png" width="400"/>
</p>

<h1>Bias-Variance Analysis</h1>
<p>
   Learning curves showing max absolute error for LSE (left) and Minimax (right) for training (black) and testing (red). For each dataset size, 100 training sets were generated to fit LSE and MM models that were tested on the same 50 testing cases. Mean value and standard deviation for the 100 training sets is plotted
</p>

<img src="figures/Bias_Variance_L2_15_Inf.png" width="800"/>

<h1>Key Findings</h1>
<ul>
   <li>Comparison of different L-norm optimized models shows that ordinary least-squares (L2-norm) performs best for out-of-sample performance and Minimax (L-infinity norm) performs best of in-sample testing or under ideal conditions.</li>
   <li>Chebyshev’s minimax optimization aims to reduce the maximum error, and is therefore the natural selection for quality assurance metrics, however, we show that out-of-sample performance with high-order L2-norm like Minimax has a large bias due to the variability of outliers between training and testing datasets.</li>
   <li>Efficient Virtual IMRT QA programs that ensure safe IMRT treatments should use L2-norm optimization to identify plans that are likely to fail QA criteria.</li>
</ul>
