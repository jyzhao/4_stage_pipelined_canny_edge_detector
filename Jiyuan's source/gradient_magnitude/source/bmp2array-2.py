import Image
import numpy as np
import os
import sys

if (len(sys.argv) != 2):
	print "Usage: python bmp2array-2.py <Image.bmp>"
	sys.exit(1)
else:
	img = Image.open(sys.argv[1],'r')

a = np.array(img.convert('P', palette=Image.ADAPTIVE, colors=4))
blockLengthX = np.argmin(a[0]==a[0,0])
blockLengthY = np.argmin(a[:,0]==a[0,0])
result = a[::blockLengthX, ::blockLengthY]

sys.exit(0)
