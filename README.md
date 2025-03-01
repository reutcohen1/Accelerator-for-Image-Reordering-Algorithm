# Accelerator-for-Image-Reordering-Algorithm

As the field of machine learning develops, the amount of data that needs to be stored is increasing. 
This project is a continuation of a previous project (see resources list) that focuses on optimizing the storage of image datasets used by machine learning networks in the field of autonomous driving. 
In the previous project, we explored various methods to improve the images compression.
The chosen algorithm involved using the average hash function to perform reordering, ensuring that neighboring images in the dataset would be as similar as possible. After reordering, we applied MPEG video compression, which exploits the similarity between adjacent frames to reduce storage requirements. 
Since the datasets we worked with contain temporal dependencies between images, this reordering process resulted in a significant performance improvement.
The goal of this project is to implement a hardware accelerator for the reordering algorithm to optimize and accelerate the process.
The project included the following stages: architecture, hardware implementation (design), software simulation(validation), functional simulation (verification), synthesis, and layout.

<h2>Useful Links</h2>
<ul>
https://github.com/sudoshivam/ai-for-self-driving-cars/tree/main
[AI for Self-Driving Cars (GitHub)](https://github.com/sudoshivam/ai-for-self-driving-cars/tree/main)  
<li><a href="https://github.com/sudoshivam/ai-for-self-driving-cars/tree/main">AI for Self-Driving Cars (GitHub)</a></li>

[Semantic Segmentation for Self-Driving Cars Dataset](https://www.kaggle.com/datasets/kumaresanmanickavelu/lyft-udacity-challenge)
<a href="https://www.kaggle.com/datasets/kumaresanmanickavelu/lyft-udacity-challenge">Semantic Segmentation for Self-Driving Cars Dataset</a>
</ul>
