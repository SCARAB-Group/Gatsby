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

; ================
; "New" stuff here
;=================
; Set group name to run the tests for. Set to empty string to run all groups
local $testForGroup = "MOLDERM"; "BBK_PATOL"; "BTB"

; Set test schemes to run. If all groups should be run then all test schemes are run
local $testForSchemes = "" ;[1] = ["LOG_SAMPLE"]

; Declare the required base object that holds everything
Local $groupConfigurations = ObjCreate("Scripting.Dictionary")

; This is a function because variables containing test schemes are not declared
; at the time of including this file (chicken-and-egg situation)
Func setupConfigurations()
   ; Declare the required base object that holds everything
   $groupConfigurations = ObjCreate("Scripting.Dictionary")

   ; ----------- MOLDERM ------------
   createGroupConfig("MOLDERM", "TEST_MOL", "abc123")
   local $btnCoords[2] = [1000, 375]
   addTestValue("MOLDERM", "LogSampleButtonCoords", $btnCoords)
   addTestValue("MOLDERM", "LabelID1", "L" & Random(0, 1000000, 1))

   ; ----------- BTB ------------
   createGroupConfig("BTB", "TEST_BTB", "TEST_BTB")
   local $btnCoords[2] = [1000, 315]
   addTestValue("BTB", "PatientButtonCoords", $btnCoords)
   addTestValue("BTB", "LabelID1", "BTB_L12345")
   $btnCoords[0] = 300
   $btnCoords[1] = 50
   addTestValue("BTB", "LoginSampleButtonCoords", $btnCoords)

   ; ----------- BBK Patol -----------
   createGroupConfig("BBK_PATOL", "TEST_PATOL", "abc123")
   local $btnCoords[2] = [1000, 335]
   addTestValue("BBK_PATOL", "LogSampleButtonCoords", $btnCoords)
   addTestValue("BBK_PATOL", "NonPreRegLID", "L" & getTrimmedTimeStamp())

EndFunc




; =========== "OLD" stuff =====================
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
Local $logSampleSleepValue = 5000
Local $curTestIndex


