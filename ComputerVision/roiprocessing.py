import cv2
import numpy as np
from cv_types import colors,shape
#find region of interest
def findRoi(img,boundry,mbcoeff,atcoeff):
    imgCpy=img.copy()
    gray = cv2.cvtColor(imgCpy, cv2.COLOR_BGR2GRAY)
    median = cv2.medianBlur(gray, mbcoeff)
    thresh = cv2.adaptiveThreshold(median,255,cv2.ADAPTIVE_THRESH_MEAN_C,
                                cv2.THRESH_BINARY_INV,atcoeff,2)
    contours,hierarchy = cv2.findContours(thresh, cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_NONE)
    roi=[]
    for cnt in contours:
        (x, y, w, h) = cv2.boundingRect(cnt)
        if w > boundry[0] and h > boundry[1] and w <boundry[2] and h <boundry[3] and x>boundry[4] and y>boundry[5] and x<boundry[6] and y<boundry[7]:
            imgPass=img[y-5:y+h+5, x-5:x+w+5]
            imgPass=cv2.resize(imgPass,(200,200),interpolation = cv2.INTER_AREA)
            info = (imgPass,(int((2*x+w)/2),int((2*y+h)/2)),(x,y,x+w,y+h))
            roi.append(info)
    res=labelRoi(roi)
    resreturn=[]

    for item in res:
        if item !=shape.NONE_ERR and item[1] != colors.NONE_ERR and item[1] != colors.EMPTY_ERR:
            resreturn.append(item)
    return resreturn
#Detect shapes in regions of interest
def labelRoi(roi):
    result=[]

    for im in range(len(roi)):
        img=roi[im][0]
        coord=roi[im][1]
        reccoord=roi[im][2]
        res=(detectShapeinfo(img,coord,reccoord))
        if res !=None:
            result.append(res)
    return result
#Extract features of different shape and detect color
def detectShapeinfo(img,coord,reccord):
 
    vcolor = np.array(3)

    gray = cv2.cvtColor(img.copy(),cv2.COLOR_BGR2GRAY)
    median = cv2.medianBlur(gray, 5)   
    thresh = cv2.adaptiveThreshold(gray,255,cv2.ADAPTIVE_THRESH_MEAN_C,
                            cv2.THRESH_BINARY_INV,13,2)

    contours,hierarchy=cv2.findContours(thresh,cv2.RETR_EXTERNAL,
                        cv2.CHAIN_APPROX_NONE)

    for cnt in contours:
        area =cv2.contourArea(cnt)
        
        if area > 2000:
            peri =cv2.arcLength(cnt,True)
            approx=cv2.approxPolyDP(cnt,0.01*peri,True)
            objCor=len(approx)
            if objCor == 3:
                colorstr = colortostr(img[100,100])
                return (shape.TRIANGLE,colorstr,coord,reccord)
            elif objCor == 4:
                colorstr = colortostr(img[100,100])
                return (shape.SQUARE,colorstr,coord,reccord)
                
            elif objCor > 5:
                if area>15000:
                    colorstr = colortostr(img[100,100])
                    return (shape.CIRCLE,colorstr,coord,reccord)   
                else:
                    
                    for point in approx:
                        if point[0][0] > 50 and point[0][0] < 150 and point[0][1] > 170:
                            vcolor=img[point[0][1]-30,point[0][0]]
                            break
                        elif point[0][0] > 170 and point[0][1] < 150 and point[0][1] > 50:
                            vcolor=img[point[0][1],point[0][0]-30]
                            break
                        elif point[0][0] > 50 and point[0][0] < 150 and point[0][1] < 30:
                            vcolor=img[point[0][1]+30,point[0][0]]
                            break
                        elif point[0][0] < 30 and point[0][1] < 150 and point[0][1] > 50:
                            vcolor=img[point[0][1],point[0][0]+30]
                            break
                    colorstr=colortostr(vcolor)
                    vcentercolor=img[100][100]
                    if vcentercolor[0]<100 and vcentercolor[1] > 100:
                        return (shape.V_SHAPE,colorstr,coord,reccord)
            else:
                return shape.NONE_ERR
    
def colortostr(color):
    if color.sum() ==3:
        return colors.EMPTY_ERR
    if max(color) == color[0]:
        return colors.BLUE
    elif max(color) == color[2] and color[0] < 90 and color[1]<90 and color[2] > 120:
        return colors.RED
    elif max(color) == color[2] and color[0] > 100 and color[1]>100:
        return colors.WHITE
    elif color.mean() < 100 and abs(color[2]-color[1])<15:
        return colors.BLACK
            
    else:
        return colors.NONE_ERR

 

