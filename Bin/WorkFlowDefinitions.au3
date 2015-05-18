#cs ----------------------------------------------------------------------------

 AutoIt Version: 1.0
 Author:         Annie Åsberg, Jesper Lind

 Script Function:
	Run LIMS as a robot
	  N.B. Require Full windoW,

#ce ----------------------------------------------------------------------------

$row01Start_yval = 340
$row02Start_yval = 630
$ydelta = 38

$col01_xval = 650
$col02_xval = 1000
$col03_xval = 1300

;["Log sample", $col02_xval, $row01Start_yval + $ydelta * 1, "Log sample" ], _


;Local $workFlowPositions[2][2] = [ [1000, 365], [1300, 365] ]






Local $wfDef_KISLL_RGPM[30][5] = [ _
["Dummy", $col01_xval, $row01Start_yval, "Dummy", "1" ], _
["StudyManager", $col01_xval, $row01Start_yval + $ydelta * 0, "Clinical Trial Manager", "1"  ], _
["ProjectManager", $col01_xval, $row01Start_yval + $ydelta * 1, "Project Manager", "1" ], _
["SLM", $col01_xval, $row01Start_yval + $ydelta * 2, "Storage Location Manager", "1" ], _
["Analysis", $col01_xval, $row01Start_yval + $ydelta * 3, "Analysis", "1" ], _
["Update Group Lists", $col01_xval, $row01Start_yval + $ydelta * 4, "Select Dialog", "1" ], _
["Log and Store sample", $col02_xval, $row01Start_yval + $ydelta * 0, "Select storage location", "1" ], _
["Register File", $col02_xval, $row01Start_yval + $ydelta * 2, "Receive Shipment", "1" ], _
["Register File", $col02_xval, $row01Start_yval + $ydelta * 2, "Receive Shipment", "4" ], _
["Register File", $col02_xval,$row01Start_yval + $ydelta * 2, "Please Confirm", "2" ], _
["Import Samples by File", $col02_xval, $row01Start_yval + $ydelta * 3, "Select shipment", "1" ], _
["Recieve Samples", $col02_xval, $row01Start_yval + $ydelta * 4, "LIMS Browser", "1" ], _
["Recieve Samples", $col02_xval, $row01Start_yval + $ydelta * 4, "Browse dialog", "3" ], _
["General Search", $col03_xval, $row01Start_yval + $ydelta * 0, "Search Dialog", "1" ], _
["General Search", $col03_xval, $row01Start_yval + $ydelta * 0, "Search Dialog", "4" ], _
["General Search", $col03_xval, $row01Start_yval + $ydelta * 0, "Search Dialog", "1" ], _
["General Search", $col03_xval, $row01Start_yval + $ydelta * 0, "Search Dialog", "3" ], _
["General Search Folder manager", $col03_xval, $row01Start_yval + $ydelta * 0, "Folder Manager", "1" ], _
["Search by Location", $col03_xval, $row01Start_yval + $ydelta * 1, "LIMS Browser", "1" ], _
["Search by Location", $col03_xval, $row01Start_yval + $ydelta * 1, "SAMPLE Folder: Samples in a location", "1" ], _
["Search by Scanning", $col03_xval, $row01Start_yval + $ydelta * 2, "Bar Code Dialog", "1" ], _
["Search by Scanning", $col03_xval, $row01Start_yval + $ydelta * 2, "SAMPLE Folder:", "1" ], _
["Search by Shipment", $col03_xval, $row01Start_yval + $ydelta * 3, "Select shipment", "1" ], _
["Search by Shipment", $col03_xval, $row01Start_yval + $ydelta * 3, "Folder Manager", "1" ], _
["AdHoc Search", $col03_xval, $row01Start_yval + $ydelta * 4, "Data Explorer", "1" ], _
["Patient Manager", $col01_xval, $row02Start_yval + $ydelta * 0, "Patient Manager", "1" ], _
["Samples by patient", $col01_xval, $row02Start_yval + $ydelta * 1, "Sample donor information", "1" ], _
["Samples by patient", $col01_xval, $row02Start_yval + $ydelta * 1, "Information", "1" ], _
["Samples by patient", $col01_xval, $row02Start_yval + $ydelta * 1, "Folder Manager", "1" ], _
["Samples by Clin.Data", $col01_xval, $row02Start_yval + $ydelta * 2, "Data Explorer", "1" ] _
]

WinActive("LIMS_BB_DEV")
For $curFunction = 0 To 29
   $xpos = $wfDef_KISLL_RGPM[$curFunction][1]
   $ypos = $wfDef_KISLL_RGPM[$curFunction][2]
   $nrOfClick = 1
   MouseClick("primary", $xpos, $ypos, $nrOfClick)

   $actionType = $wfDef_KISLL_RGPM[$curFunction][4]
   Switch $actionType
	  Case "1"

		 $winCheck = WinWait($wfDef_KISLL_RGPM[$curFunction][3], "", 2)
		 ;sleep(1000)
		 If $winCheck <> 0 Then
			WinClose($winCheck)
		 EndIf
	  Case "2"
		 Send("!n")
	  Case "3"
		 Send("!c")
	  Case "4"
		 Sleep(3000)

   EndSwitch

Next



