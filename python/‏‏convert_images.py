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
    
    
def save_data_image(img, arrays):
    img = preprocessing(img)
    pixels = list(img.getdata())  # Get the flattened image array
    arrays.append(pixels)  # Append it to the list
    return arrays

def write_arrays_to_file(arrays, save_path):
    print(f"Writing arrays to: {save_path}")
    with open(save_path, 'w') as file:
        for i, array in enumerate(arrays):
            file.write(f"// Image {i}\n")
            for pixel in array:  # Now 'array' is a 1D list of pixels
                file.write(f"{pixel}\n")
    print("File writing complete.")

def convert_images(images_folder):
    arrays = []
    image_files = loading_original_data(images_folder)
    for file_name in image_files:
        image_path = os.path.join(images_folder, file_name)
        with Image.open(image_path) as img:
            arrays = save_data_image(img, arrays)
            after_preprocessing_img = preprocessing(img)
    write_arrays_to_file(arrays, "./output.txt")

def main():
    images_folder = "./"
    convert_images(images_folder)

if __name__ == "__main__":
    main()
