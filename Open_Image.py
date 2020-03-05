# Open the image given its path and store it in the variable 'image'
from ij import IJ

current_dir = IJ.getDirectory('current')
path = current_dir+"images\logo_cif.png"

image = IJ.openImage(path)
# then display it.
image.show()
 
