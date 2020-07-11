#encoding:utf-8
#import numpy as np
#import cv2

import cv2
import numpy as np
#from matplotlib import pyplot as plt
import sys

debug = False

#生成一个空灰度图像

pixel_width = 511
pixel_high = 511
pixel_len = pixel_width*pixel_high   

img = np.zeros((pixel_high,pixel_width),np.uint8)
    
def GetStockTxt(txt):
       lnum = 0
       stocks = []
       #img = np.zeros((240,320),np.uint8)#生成一个空灰度图像
       with open(txt, 'r') as fd:
            for line in fd:
                
                if (lnum < pixel_len):
                    i = (int(lnum/pixel_width))%pixel_high
                    
                    j = int(lnum%pixel_width)
                    #print i,j
                    img[i,j] = int(line.strip('\n'),4)
                    #print img[i,j]
                lnum += 1;			
            fd.close()
           

            
GetStockTxt('result.txt')
cv2.imwrite("./result.jpg", img)
cv2.namedWindow("Image")   
cv2.imshow("Image", img)   
cv2.waitKey (0)  
cv2.destroyAllWindows()









sys.exit(0)

