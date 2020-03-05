from fiji.util.gui import GenericDialogPlus
 
# Create an instance of GenericDialogPlus
gui = GenericDialogPlus("an enhanced GenericDialog")
 
# Add possibility to choose some images already opened in Fiji
gui.addImageChoice("Image1","Some description for image1")
gui.addImageChoice("Image2","Some description for image2")
 
 
# The GenericDialogPlus also allows to select files, folder or both using a browse button
gui.addFileField("Some_file path", "DefaultFilePath")
gui.addDirectoryField("Some_folder path", "DefaultFolderPath")
gui.addDirectoryOrFileField("Some_Path", "DefaultPath")
 
gui.showDialog()
 
# Recover the inputs in order of "appearance"
if gui.wasOKed():
    ImpImage1 = gui.getNextImage() # This method directly returns the ImagePlus object
    ImpImage2 = gui.getNextImage()
     
    # Path are recovered as string
    FilePath   = gui.getNextString()
    FolderPath = gui.getNextString()
    SomePath   = gui.getNextString()