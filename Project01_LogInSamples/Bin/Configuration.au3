#cs ----------------------------------------------------------------------------

 AutoIt Version: 1.0
 Author:         Annie Åsberg, Jesper Lind

 Script Function:
	Run LIMS as a robot
	  N.B. Require Full windoW,

#ce ----------------------------------------------------------------------------


; =================================================
; Configuration
; =================================================

Local $curEnvironment = "LIMS_BB_TEST"

local $nrOfGroups = 1
local $userConfigArray[2][3] = [ _
["TEST_MOL","abcde12345",12], _
["TEST_HERM","abcde12345",13], _
["TEST_PATOL","abcde12345",13] _
]

Local $workFlowPositions[2][2] = [ [1000, 365], [1300, 365] ]
Local $nrOfFunctions = 0
Local $stdSleep = 750

Local $curLabelID = "VAL_" & _Now()

local $maliciousString = "') DROP TABLE KI_VERY_VERY_IMPORTANT_DATATABLE --"

local $curfieldType
Local $curProposedInit
Local $curProposedValue
Local $curExpectedOutcome
Local $curFieldText
Local $curSleepValue

Local $curTestIndex

