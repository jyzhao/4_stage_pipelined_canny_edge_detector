#!/usr/bin/python

import Image
import ImageOps
import numpy, scipy
import os
import sys

#input argument check
if (len(sys.argv) != 2):
	print "Usage: python array2bmp.py <PixelArray>"
	sys.exit(1)
else:
	inputFile = open(sys.argv[1],'r')

i = 0
j = 0

#create empty output array
outputArray = numpy.empty((512,512),numpy.uint8)

#read just from the second line of input file
lines = inputFile.readlines()
lines = lines[1:]

for line in lines:
	if (j > 511):
		j = 0
		i = i + 1
	
	#print i,j

	#convert str to hex then to int
	token = line.split(':')
	token = token[1].split(';')
	token = token[0].strip()
	pixel = int(token,16)

	#write to output array
	outputArray[i-1][j] = pixel

	j = j + 1

outputArray3 = numpy.array(outputArray)

#convert pixel array back to image file
outputImage = Image.fromarray(outputArray3)

#save image file
outputImage.save("output_image.bmp")

#outputArray.close()

sys.exit(0)
