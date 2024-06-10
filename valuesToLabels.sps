* Encoding: UTF-8.
* SPSS Python Macro to combine values and labels
* that are stored in separate labels
* by Jamie DeCoster

* This macro will take label information that is contained in one variable
* and use it to create value labels for a second variable. For this macro
* to work properly, there has to be a 1-to-1 relationship between the values
* variable and the label variable. The variables can be either numeric
* or strings. Additionally, the macro can export the syntax used to create
* the value labels to an external file if the user provides a filename.

**** Usage: valuesToLabels(valueVar, labelVar, syntaxFile = None)
**** valueVar is the name of the variable containing the values
**** labelVar is the name of the variable containing the labels
**** syntaxFile is an optional argument that contains the name of a
* syntax file to which the syntax used to generate the value labels
* will be written

**** Example
valuesToLabels("schoolNum", "schoolName", 
    syntaxFile = "c:\research\school project\schoolNum values.sps")
* This would add values to the schoolNum variable that are based
* on the corresponding values in the schoolName variable. The 
* syntax used to create the value labels will be saved to the file
* "c:\research\school project\schoolNum values.sps".

BEGIN PROGRAM PYTHON3.
import spss, spssdata

def getVariableIndex(variable):
   for t in range(spss.GetVariableCount()):
      if (variable.upper() == spss.GetVariableName(t).upper()):
         return(t)

def valuesToLabels(valueVar, labelVar, syntaxFile = None):
    valueIndex = getVariableIndex(valueVar)
    labelIndex = getVariableIndex(labelVar)

# Create a dictionary linking values to labels
    valueDict={}
    data = spssdata.Spssdata(indexes = (valueVar, labelVar),
        omitmissing = True)
    for row in data:
        if (valueVar not in valueDict):
            valueDict[row[0]] = row[1]
    data.CClose()

# Determine the variable types for values and labels
    valueType = spss.GetVariableType(valueIndex)
    labelType = spss.GetVariableType(labelIndex)

    valueSyntax = "value labels {0}".format(valueVar)
    if (valueType == 0 and labelType == 0):
        for v in valueDict:
            valueSyntax += "\n" + str(v) + " " + str(valueDict[v])
    if (valueType == 0 and labelType != 0):
        for v in valueDict:
            valueSyntax += "\n" + str(v) + " '" + valueDict[v].strip() + "'"
    if (valueType != 0 and labelType == 0):
        for v in valueDict:
            valueSyntax += "\n" + "'" + v.strip() + "' " + str(valueDict[v])
    if (valueType != 0 and labelType != 0):
        for v in valueDict:
            valueSyntax += "\n" + "'" + v.strip() + "' '" + valueDict[v].strip() + "'"

    valueSyntax += "\n."

# Export syntax if a filename is provided
    if (syntaxFile != None):
        f = open(syntaxFile, "w")
        f.write(valueSyntax)
        f.close()

# Run the value labels syntax
    spss.Submit(valueSyntax)
end program python.

********
* Version History
********
* 2018-10-08 Created
* 2023-02-16 Renamed to valuesToLabels
