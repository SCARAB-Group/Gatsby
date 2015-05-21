#cs ----------------------------------------------------------------------------

 AutoIt Version: 1.0
 Author:         Annie Åsberg, Jesper Lind

 Script Function:
   Setup configurations in this script. These values are:
	  - Environment
	  - User groups
	  - LIMS user name
	  - LIMS password
	  - Values to write in fields
	  - Click coordinates
	  - probably more...

   Note: test schemes are setup in TestSchemes.au3

#ce ----------------------------------------------------------------------------

;~ #include <TestSchemes.au3>

; =================================================
; Configuration
; =================================================
Local $curEnvironment = "LIMS_BB_TEST"

local $nrOfGroups = 1
local $userConfigArray[3][3] = [ _
["TEST_MOL","abcde12345",12], _
["TEST_HERM","abcde12345",13], _
["TEST_PATOL","abcde12345",13] _
]

Local $workFlowPositions[2][2] = [ [1000, 375], [1300, 375] ]
Local $nrOfFunctions = 0
Local $stdSleep = 750
local $maliciousString = "') DROP TABLE KI_VERY_VERY_IMPORTANT_DATATABLE --"

Local $curLabelID = "VAL_" & _Now()
local $curfieldType
Local $curProposedInit
Local $curProposedValue
Local $curExpectedOutcome
Local $curFieldText
Local $curSleepValue

Local $curTestIndex

; ================
; "New" stuff here
;=================
; Set group name to run the tests for. Set to empty string to run all groups
local $testForGroup = "" ;"MOLDERM"

; Set test schemes to run. If all groups should be run then all test schemes are run
local $testForSchemes = "" ;[1] = ["LOG_SAMPLE"]


; =================================================
; Group-specific test values are defined here
; =================================================
; Holds all test values (dictionary-type object). This object holds a dictionary for each group's test values
local $testValuesAll = ObjCreate("Scripting.Dictionary")

; ######################## EXAMPLE #########################
; ------ Values for TEST_GROUP added below ------
; Create the group's dictionary
local $testValuesTestGroup = ObjCreate("Scripting.Dictionary")

; Add some values
$testValuesTestGroup.ADD("LID", "12345678")
$testValuesTestGroup.ADD("PAD", "12345678")
$testValuesTestGroup.ADD("PNR", "19121212-1212")

; Add the group's dictionary to the main dictionary
$testValuesAll.ADD("TEST_GROUP", $testValuesTestGroup)
; ####################### END EXAMPLE #######################


;~ ; ------ Values for MOLDERM added below ------
;~ local $testValuesMOLDERM = ObjCreate("Scripting.Dictionary")
;~ $testValuesMOLDERM.ADD("LabelID", "VAL_" & _Now())
;~ $testValuesAll.ADD("MOLDERM", $testValuesMOLDERM)

;~ ; ------ Values for MDS_HERM added below ------
;~ local $testValuesMDSHERM = ObjCreate("Scripting.Dictionary")
;~ $testValuesMDSHERM.ADD("LabelID", "VAL_" & _Now())
;~ $testValuesAll.ADD("MDS_HERM", $testValuesMDSHERM)


;~ ; ------ Values for BBK_PATOL added below ------
;~ local $testValuesBBKPATOL = ObjCreate("Scripting.Dictionary")
;~ $testValuesBBKPATOL.ADD("LabelID", "VAL_" & _
;~    StringReplace( StringReplace( StringReplace(_Now(), " ", "_"), ":", ""), "-", ""))
;~ $testValuesAll.ADD("BBK_PATOL", $testValuesBBKPATOL)


; =================================================
; The even newer way of defining all configurations
; =================================================
; Declare the required base object that holds everything
Local $groupConfigurations = ObjCreate("Scripting.Dictionary")

; This is a function because variables containing test schemes are not declared
; at the time of including this file (chicken-and-egg situation)
Func setupConfigurations()
   ; Declare the required base object that holds everything
   $groupConfigurations = ObjCreate("Scripting.Dictionary")

   ; ----------- MOLDERM ------------
   createGroupConfig("MOLDERM", "TEST_MOL", "abcde12345")
   local $btnCoords[2] = [1000, 375]
   addTestValue("MOLDERM", "LogSampleButtonCoords", $btnCoords)
   addTestValue("MOLDERM", "LabelID1", "L12345")

EndFunc
