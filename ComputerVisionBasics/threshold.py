#import skimage
import numpy as np

def canny(image,sigma,low_threshold,high_threshold):
    edges = skimage.feature.canny(image=image,
        sigma=sigma,
        low_threshold=low_threshold,
        high_threshold=high_threshold)
    return edges


def edgemap(image):#WIP
    npIMG = np.array(image)
    
    x,y = npIMG.shape
    
    edges = np.copy(npIMG)
    edges[edges<0]=0
    edges[edges>0]=1
   
    print(f'Your percent of pixels for edgemap is {edges.sum()/(x*y)*100}')   
    return edges