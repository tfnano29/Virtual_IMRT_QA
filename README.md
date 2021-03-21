# Effects of L-Norm loss fuctions on Virtual IMRT QA
<p float="left" width="800">
   The purpose of this work is to compare the models resulting from using the mean squared error or the maximum possible error (max-error)  as a loss function. Our hypothesis was that reducing the mean error over the population, as done when using low-order norms, may not be appropriate because we might incur big errors for specific plans. Reducing the maximum possible error (max-error), as done when using Chebyshev Minimax or high-order norms, may help ensure that all plans are still predicted within a boundary at the cost of a increased mean error over the whole population.The purpose of this work is to compare the models resulting from using the mean squared error or the maximum possible error (max-error)  as a loss function. Our hypothesis was that reducing the mean error over the population, as done when using low-order norms, may not be appropriate because we might incur big errors for specific plans. Reducing the maximum possible error (max-error), as done when using Chebyshev Minimax or high-order norms, may help ensure that all plans are still predicted within a boundary at the cost of a increased mean error over the whole population.
</p>

<h1>In-sample performance of L2 and L-infinity (Minimax)</h1>
<p float="left">
  <img src="figures/LS_model_11.png" width="400" />
  <img src="figures/MM_model_11.png" width="400" />
</p>

<h1>Prediction errors for various L-Norm loss functions</h1>
<table border="0px">
   <tr>
      <td width="400"><img src="figures/normalization_eq.gif" width="150" /></td>
      <td><img src="figures/normalization_result_2.gif" width="400" /></td>
   </tr>
</table>

<!--
<img src="figures/normalization_eq.gif" width="150" /> <img src="figures/normalization_result_2.gif" width="500" />
-->

<h1>Out-of-sample performance</h1>
<p float="left">
   <img src="figures/LNorm_train.png" width="400"/>
   <img src="figures/LNorm_test.png" width="400"/>
</p>

<h1>Bias-Variance Analysis</h1>
<img src="figures/Bias_Variance_L2_15_Inf.png" width="800"/>

<h1>Key Findings</h1>
