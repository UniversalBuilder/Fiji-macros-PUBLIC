from fiji.util.gui import GenericDialogPlus
from java.awt.event   import ActionListener

class ButtonClic(ActionListener):
    '''Class which unique function is to handle the button clics'''
 
    def actionPerformed(self, event): # self (or this in Java) to state that the method will be associated to the class instances
         
        # Check from where comes the event 
        Source = event.getSource() # returns the Button object
        print Source 
 
        # Do an action depending on the button clicked
        if Source.label == "A":
            print "You clicked A\n"
 
        elif Source.label == "B":
            print "You clicked B\n"
         
  
# Create an instance of GenericDialogPlus
gui = GenericDialogPlus("an enhanced GenericDialog")
 
# Add possibility to choose some images already opened in Fiji
gui.addImageChoice("Image1","Some description for image1")
gui.addImageChoice("Image2","Some description for image2")
 
 
# The GenericDialogPlus also allows to select files, folder or both using a browse button
gui.addFileField("Some_file path", "DefaultFilePath")
gui.addDirectoryField("Some_folder path", "DefaultFolderPath")
gui.addDirectoryOrFileField("Some_Path", "DefaultPath")

gui.addButton("A", ButtonClic() ) # We associate the button objects to some instance of the ButtonClic class
gui.addButton("B", ButtonClic() )
 
gui.showDialog()
 
# Recover the inputs in order of "appearance"
if gui.wasOKed():
    ImpImage1 = gui.getNextImage() # This method directly returns the ImagePlus object
    ImpImage2 = gui.getNextImage()
     
    # Path are recovered as string
    FilePath   = gui.getNextString()
    FolderPath = gui.getNextString()
    SomePath   = gui.getNextString()