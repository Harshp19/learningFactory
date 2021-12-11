import cv2
import roiprocessing as rp
from cv_types import colors,shape
import time
def cv_function(img,command,mbcoeff=3,atcoeff=5):
    '''mbcoeff and atcoeff can be made as adjustable variables according to 
    needs of user in different deploying environment. Adjustment can be made
    for expected identification results'''
    start_time = time.time()
    imgsize=img.shape
    x=max(imgsize[0],imgsize[1])
    y=min(imgsize[0],imgsize[1])
    x=720*x/y
    img=cv2.resize(img,(int(x),720),interpolation = cv2.INTER_AREA)
    wlowbound=50
    hlowbound=wlowbound
    whighbound=150
    hhighbound=whighbound
    xlowbound=0
    ylowbound=0
    xhighbound=int(x)
    yhighbound=720
    boundry=(wlowbound,hlowbound,whighbound,hhighbound,xlowbound,ylowbound,xhighbound,yhighbound)
    intoRpTime=time.time()
    info=rp.findRoi(img,boundry,mbcoeff,atcoeff)
    #print("RP finished --- %s seconds ---" % (time.time() - intoRpTime))
    datainfo=[]
    jsonstr="{\"list\":[\n"
    for item in info:

        if(command[0]!=shape.ALL_SHAPE):
            if(item[0]!=command[0]):
                continue
        if(command[1]!=colors.ALL_COLOR):
            if(item[1]!=command[1]):
                continue
        x=item[3][0]
        y=item[3][1]
        w=item[3][2]-x
        h=item[3][3]-y
       
        cv2.rectangle(img,(x,y),(x+w,y+h),(255,255,255),2)
        text=""
        if(item[0]==shape.CIRCLE):
            text = "Circle"
        elif(item[0]==shape.SQUARE):
            text = "Square"
        elif(item[0]==shape.V_SHAPE):
            text = "V_shape"
        elif(item[0]==shape.TRIANGLE):
            text = "Triangle"
        jsonstr+="{\n\"shape\":"+str(item[0].value)+",\n"
        cv2.putText(img,text,item[2],
                        cv2.FONT_HERSHEY_COMPLEX,1,(0,255,255),2)
        text=""
        if(item[1]==colors.RED):
            text = "Red"
        elif(item[1]==colors.BLUE):
            text = "Blue"
        elif(item[1]==colors.WHITE):
            text = "White"
        elif(item[1]==colors.BLACK):
            text = "Black"
        jsonstr+="\"color\":"+str(item[1].value)+",\n"
        cv2.putText(img,text,(item[2][0],item[2][1]+30),
                        cv2.FONT_HERSHEY_COMPLEX,1,(0,255,0),2)
        datainfo.append((item[0],item[1],item[2],(x,y,x+w,y+h)))
        jsonstr+="\"location\":["+str(item[2][0])+','+str(item[2][1])+"]\n},\n"
    jsonstr=jsonstr[:-2]
    jsonstr+="\n],\n\"Command\": ["+str(command[0].value)+","+str(command[1].value)+"]\n}"
    
    cv2.putText(img,str(command[0]),(20,50),cv2.FONT_HERSHEY_COMPLEX ,1,(0,0,200),2)
    cv2.putText(img,str(command[1]),(20,90),cv2.FONT_HERSHEY_COMPLEX ,1,(0,0,200),2)

    #This img now contain detection results. It can be sent out.                 
    cv2.imshow("result0",img)
    '''datainfo variable contain information(color, center coordinates) for each detected shape. 
    It can be used for other calculations.'''
    print(datainfo)
    f = open("output.json","w")
    f.write(jsonstr)
    f.close()
    # print(jsonstr)
    print("Process finished --- %s seconds ---" % (time.time() - start_time))
    cv2.waitKey(0)
    cv2.destroyAllWindows()


if __name__=="__main__":
    num=10
    #The input image(img) will be received from camera input
    img = cv2.imread(str(num)+'.jpg')
    
    #command format for shape: shape.SHAPEYOULIKETODISPLAY
    #command format for color: color.COLORYOULIKRTODISPLAY
    command=(shape.ALL_SHAPE,colors.ALL_COLOR)

    #invoke function below for detection process
    cv_function(img,command)