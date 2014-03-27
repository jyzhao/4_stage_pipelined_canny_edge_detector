#!/usr/bin/python

import Image
import ImageOps
import numpy, scipy
import os
import sys

#input argument check
if (len(sys.argv) != 2):
	print "Usage: python bmp2array.py <Image.bmp>"
	sys.exit(1)
else:
	inputImage = Image.open(sys.argv[1],'r')

#convert the image to gray scale image, 8 bit per pixel
inputImage = inputImage.convert('L')

#resize the image to 512 by 512 pixels
inputImage = inputImage.resize((512,512),Image.ANTIALIAS)

#create 4-pixel border
inputImage = ImageOps.expand(inputImage,border=4,fill='black')

#convert image to pixel array
imageArray = numpy.array(inputImage)

#inputArray = open('inputArray','w')

#inputArray.write(imageArray)

#inputArray.close()

#open the pixel array file to write to
outputArray = open('pixelArray','w')

row_number = 0

element_number = 0

outputArray.write("<address>:<data value in hexidecimal>;\n")

for row in imageArray:
	row_number = row_number + 1

	column_number = 0

	#print row

	for element in row:
		#print element

		#write data to output file in HEX(CAPS)
		outputArray.write("%d:%02X;\n" % (element_number,element))
		
		element_number = element_number + 1
		column_number = column_number + 1
	
	#print column_number

#print numpy.shape(imageArray)

#convert pixel array back to image file
outputImage = Image.fromarray(imageArray)

#save image file
outputImage.save("new_imange.bmp")

outputArray.close()

sys.exit(0)
