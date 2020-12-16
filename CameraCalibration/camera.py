from scipy import linalg
import numpy as np

class Camera(object):
    """ Class for representing pin-hole cameras. """
    
    def __init__(self,P):
        """ Initialize P = K[R|t] camera model. """
        self.P = P
        self.K = None # calibration matrix
        self.R = None # rotation
        self.t = None # translation
        self.c = None # camera center
        
    def project(self,X):
        """ Project points in X (4*n array) and normalize coordinates. """
        x = np.dot(self.P,X)
        for i in range(3):
            x[i] /= x[2]
        return x