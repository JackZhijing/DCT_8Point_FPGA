import math
import scipy
import numpy as np
from scipy.fftpack import fft, dct

arr = np.array([10., 50., 100., 150., 200., 250., 100., 0])
##arr = np.array([255., 0., 0., 255., 255., 0., 0., 255])
##arr = np.array([155., 0., 0., 155., 155., 0., 0., 155])

##arr = np.array([155., 154., 153., 152., 151., 150., 149., 148])
##print dct(arr, 2)

factor = []
factor.append(16)
factor.append(15)
factor.append(14)
factor.append(13)
factor.append(11)
factor.append(9)
factor.append(6)
factor.append(3)

##bitWidth = 4
##
##factor_space = np.linspace(0,7,8)
##
##for a in factor_space:
##    temp = int (round(float(math.cos(a * math.pi /16)*(2**bitWidth))))
##    factor.append(temp)
##    print temp
    
factor_arr = np.array([[factor[4],factor[4],factor[4],factor[4],factor[4],factor[4],factor[4],factor[4]],
                       [factor[1],factor[3],factor[5],factor[7],-factor[7],-factor[5],-factor[3],-factor[1]],
                       [factor[2],factor[6],-factor[6],-factor[2],-factor[2],-factor[6],factor[6],factor[2]],
                       [factor[3],-factor[7],-factor[1],-factor[5],factor[5],factor[1],factor[7],-factor[3]],
                       [factor[4],-factor[4],-factor[4],factor[4],factor[4],-factor[4],-factor[4],factor[4]],
                       [factor[5],-factor[1],factor[7],factor[3],-factor[3],-factor[7],factor[1],-factor[5]],
                       [factor[6],-factor[2],factor[2],-factor[6],-factor[6],factor[2],-factor[2],factor[6]],
                       [factor[7],-factor[5],factor[3],-factor[1],factor[1],-factor[3],factor[5],-factor[7]]])
result_arr = np.dot(factor_arr,arr)
print result_arr
