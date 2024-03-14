Dialog.create("My inputs");
Dialog.addMessage("Some message to display");
 
var min = 0;
var max = 10;
var default = 5;
Dialog.addSlider("Some slider", min, max, default);
Dialog.addNumber("Some number", 0);
Dialog.addString("Some string", "DefaultString");
 
Dialog.addChoice("Type:", newArray("8-bit", "16-bit", "32-bit", "RGB"));
Dialog.addCheckbox("Ramp", true);
 
// One can add a Help button that opens a webpage
Dialog.addHelp("https://imagej.net/macros/DialogDemo.txt");
 
// Finally show the GUI, once all parameters have been added
Dialog.show();
 
// Once the Dialog is OKed the rest of the code is executed
// ie one can recover the values in order of appearance 
inNumber1 = Dialog.getNumber(); // Sliders are number too
inNumber2 = Dialog.getNumber();
inString  = Dialog.getString();
inChoice  = Dialog.getChoice();
inBoolean = Dialog.getCheckbox();
 
print("Number1:", inNumber1);
print("Number2:", inNumber2);
print(inString);
print("Choice:", inChoice);
print("Do something (1=True, 0=False):", inBoolean);