from PIL import Image
import os
import shutil

def divide_images(source_image_folder, source_seg_folder, target_base_folder):
    # Create the target folders
    index = ['A','B','C','D','E']

    # Get all PNG images from the source folder
    image_files = [f for f in os.listdir(source_image_folder) if f.endswith('.png')]
    seg_files = [f for f in os.listdir(source_seg_folder) if f.endswith('.png')]
    image_files.sort(key=lambda x: int(x[5:-4]))
    seg_files.sort(key=lambda x: int(x[10:-4])) 
    
    # Divide images into 5 folders with 2 images each
    for i in range(len(image_files)):
        folder_index = index[(i // 2) % 5]
        target_folder = os.path.join(target_base_folder, f'data{folder_index}', f'data{folder_index}')
        target_image_folder = os.path.join(target_folder, f'CameraRGB')
        target_seg_folder = os.path.join(target_folder, f'CameraSeg')
        source_image_path = os.path.join(source_image_folder, image_files[i])
        target_image_path = os.path.join(target_image_folder, image_files[i])
        source_seg_path = os.path.join(source_seg_folder, seg_files[i])
        target_seg_path = os.path.join(target_seg_folder, image_files[i])
        print (source_image_path, target_image_path)
        shutil.copy2(source_image_path, target_image_path)
        shutil.copy2(source_seg_path, target_seg_path)

# Define the source folder and the target base folder
source_image_folder = r'.\images\average_sorted_images\recovered_images'
source_seg_folder = r'.\segmentation\average_sorted_images'
target_base_folder = r'.\output'

# Divide the images
divide_images(source_image_folder, source_seg_folder, target_base_folder)
