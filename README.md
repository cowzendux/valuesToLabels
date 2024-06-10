# valuesToLabels
SPSS Python Macro to combine values and labels that are stored in separate labels

This macro will take label information that is contained in one variable and use it to create value labels for a second variable. For this macro to work properly, there has to be a 1-to-1 relationship between the values variable and the label variable. The variables can be either numeric or strings. Additionally, the macro can export the syntax used to create the value labels to an external file if the user provides a filename.

This and other SPSS Python Extension functions can be found at http://www.stat-help.com/python.html

## Usage
**valuesToLabels(valueVar, labelVar, syntaxFile = None)**
* valueVar is the name of the variable containing the values
* labelVar is the name of the variable containing the labels
* syntaxFile is an optional argument that contains the name of a syntax file to which the syntax used to generate the value labels will be written

## Example
**valuesToLabels(valueVar = "schoolNum",    
labelVar = "schoolName",    
syntaxFile = "c:\research\school project\schoolNum values.sps")**
* This would add values to the schoolNum variable that are based on the corresponding values in the schoolName variable.
* The syntax used to create the value labels will be saved to the file "c:\research\school project\schoolNum values.sps".
