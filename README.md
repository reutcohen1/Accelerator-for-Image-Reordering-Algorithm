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
<li><a href="https://github.com/sudoshivam/ai-for-self-driving-cars/tree/main">AI for Self-Driving Cars (GitHub)</a></li>
<li><a href="https://www.kaggle.com/datasets/kumaresanmanickavelu/lyft-udacity-challenge">Semantic Segmentation for Self-Driving Cars Dataset</a></li>
</ul>

<h2>Architecture</h2>
<img width="500" alt="image" src="https://github.com/user-attachments/assets/9e1cc971-b086-4efa-b3a7-16e9bc421da9" />

<h2>Design</h2>

<img width="350" alt="image" src="https://github.com/user-attachments/assets/8c78665a-0167-4071-bf28-486986f8a2c0" />

<img width="350" alt="image" src="https://github.com/user-attachments/assets/586bc728-c397-482d-9dd2-bec0a6e1ab47" />

<img width="350" alt="image" src="https://github.com/user-attachments/assets/38496e04-6f31-44f9-b936-c6b061582e1a" />

<img width="350" alt="image" src="https://github.com/user-attachments/assets/3049971a-9cac-4d28-ade9-aaea1509db9e" />

<img width="350" alt="image" src="https://github.com/user-attachments/assets/9d004158-92cf-4e21-869e-91f05475fa2c" />






