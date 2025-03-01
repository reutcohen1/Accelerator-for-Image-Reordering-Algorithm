from PIL import Image
import os
import shutil
import math
import numpy as np

def loading_original_data(images_folder):
    image_files = [f for f in os.listdir(images_folder) if f.endswith('.jpg') or f.endswith('.png')]
    image_files.sort(key=lambda x: int(x[11:-4]))
    return image_files
    
def preprocessing(image, size=16):
    image = image.resize((size, size)).convert('L')
    return image
    
def average_hash(image, file_name):
    pixels = list(image.getdata())
    avg = math.floor(sum(pixels) / len(pixels))
    print ("pixels: " , pixels)
    print ("avg:" ,avg)
    bits = "".join(['1' if pixel >= avg else '0' for pixel in pixels])[::-1]
    hash_size = len(bits);
    hash_value = int(bits,2)
    hash_value_str = format(int(bits,2), f'0{hash_size}b')
    print("hash value:", (hash_value_str))
    return hash_value, file_name

def calc_hamming_distance(hash1, hash2):
    return bin(hash1 ^ hash2).count('1')
    
def update_minimum (hamming_distance1,file_name1,hamming_distance2 ,file_name2):
    if (hamming_distance1<hamming_distance2):
        global temp_minimum
        temp_minimum = hamming_distance1
        global temp_new_referance
        temp_new_referance=file_name1
    return True

    
def reorder_controller(images_folder):
    hashes = {}
    global temp_minimum 
    global temp_new_referance
    image_files = loading_original_data(images_folder)
    for file_name in image_files:
        image_path = os.path.join(images_folder, file_name)
        with Image.open(image_path) as img:
            after_preprocessing_img = preprocessing(img)
            img_hash,file_name = average_hash(after_preprocessing_img,file_name)
            hashes[file_name] = img_hash 
    ordered_files = []
    current_file = image_files[0]
    remaining_files = list(image_files[1:])
    ordered_files.append(current_file)
    while remaining_files:
        hamming_distance = calc_hamming_distance(hashes[current_file], hashes[remaining_files[0]])
        temp_minimum = hamming_distance
        temp_new_referance=remaining_files[0] 
        for next_file in remaining_files[1:]:
            hamming_distance = calc_hamming_distance(hashes[current_file], hashes[next_file]);
            update_minimum (hamming_distance, next_file, temp_minimum, temp_new_referance)
        next_file = temp_new_referance
        current_file = next_file
        remaining_files.remove(next_file)
        ordered_files.append(current_file)
    return ordered_files


def rename_images(images_folder, segmentation_folder, ordered_files):
    new_folder1 = os.path.join(images_folder, "average_sorted_images")
    new_folder2 = os.path.join(segmentation_folder, "average_sorted_images")
    os.makedirs(new_folder1, exist_ok=True)
    os.makedirs(new_folder2, exist_ok=True)
    for index, file_name in enumerate(ordered_files):
        original_path = os.path.join(images_folder, file_name)
        new_name = f"sort_image{index+1}.png"
        new_path = os.path.join(new_folder1, new_name)
        shutil.copy2(original_path, new_path)
        original_path = os.path.join(segmentation_folder, file_name)
        new_name = f"sort_image{index+1}.png"
        new_path = os.path.join(new_folder2, new_name)
        shutil.copy2(original_path, new_path)
        
def print_reorder(reordered_files):
    for index, filename in enumerate(reordered_files):
        number = int(filename.replace("RandomImage", "").replace(".png", ""))
        print(f"Index {index} -> {number}")
    
images_folder = "./"
segmentation_folder = "./segmentation"
reordered_files = reorder_controller(images_folder)
print_reorder(reordered_files)
rename_images(images_folder, segmentation_folder, reordered_files)



