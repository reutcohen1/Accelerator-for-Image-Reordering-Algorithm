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
![image](https://github.com/user-attachments/assets/d446d0d6-c413-4495-85a3-26633e474014)

![image](https://github.com/user-attachments/assets/2cb823d4-2865-4884-a16a-29ad7171ba88)

![image](https://github.com/user-attachments/assets/2c653c5b-61f5-48c7-99cb-19cc775dbaef)

![image](https://github.com/user-attachments/assets/0299b2a5-39e2-46c6-acb4-0b30ed15ab3b)

![image](https://github.com/user-attachments/assets/c4260aa2-6aef-4e12-ae7f-34e98720302d)

![image](https://github.com/user-attachments/assets/25407c1d-2ac8-4799-b378-356c9feb296d)





