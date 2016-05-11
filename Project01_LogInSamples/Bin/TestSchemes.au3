#cs ----------------------------------------------------------------------------

 AutoIt Version: 1.0
 Author:         Annie Åsberg, Jesper Lind

 Script Function:
   Setup the test schemes in this script, i.e. a number of steps to perform
   to test something.

   Short how-to:
	  - Define your test scheme in a 2D-array in the function setupTests().
	  - Add the test definition to the group config
	  --> Use existing test definitions as an example.

#ce ----------------------------------------------------------------------------

; TODO: fetch this from database instead?

; TestTypes: None, Standard, Malware
Func setupTests()

   local $moldermLoginSampleTestScheme[16][8] = [ _
   ["Click","",getTestValue("MOLDERM", "LogSampleButtonCoords"),"","","Log sample", "", "Standard"], _
   ["Skip","","","","","Template",$stdSleep, "Standard"], _
   ["Glass","m","MOLDERM_TER","","","Study",$stdSleep, "Standard"], _
   ["List","k","","","","Clincial Site",$stdSleep, "Standard"], _
   ["Text","","TER 88","TER 88","","Subject ID",$stdSleep, "Standard"], _
   ["Skip","","","","","Personal number",$stdSleep, "Standard"], _
   ["Text","",getTestValue("MOLDERM", "LabelID1"),getTestValue("MOLDERM", "LabelID1"),"","LabelID",$stdSleep, "Standard"], _
   ["List","s","","","","Sample Type",$stdSleep, "Standard"], _
   ["Sprec","","","","","Sprec",$stdSleep, "Standard"], _
   ["Skip","","","","","Sampled Date",$stdSleep, "Standard"], _
   ["Skip","","","","","Sampled Volume/Amount",$stdSleep, "Standard"], _
   ["Glass","m","ML","","","Sample Units",$stdSleep, "Standard"], _
   ["List","f","","","","Sample Form",$stdSleep, "Standard"], _
   ["Skip","","","","","Number of samples to log",$stdSleep, "Standard"], _
   ["Skip","","","","","Aliquot sample",$stdSleep, "Standard"], _
   ["ClickOK","","","","","Log sample", "", "Standard"] _
   ]
   addTestScheme("MOLDERM", "Log sample", $moldermLoginSampleTestScheme)



   ;["Skip","","","","","Sampled date", $stdSleep, "Standard"], _
   ;["Skip","2015-05-02","","","","Mottagardatum", $stdSleep, "Standard"] _

   ;["Skip","","","","","Study", $stdSleep, "Standard"], _
   Local $btbLoginSampleTestScheme[9][8] = [ _
   ["Click","",getTestValue("BTB", "PatientButtonCoords"),"","","Patient Manager", "", "Standard"], _
   ["Text","","19121212-1212","19121212-1212","","Svenskt personnummer (12 siff) ",$stdSleep, "Standard"], _
   ["Click","",getTestValue("BTB", "LoginSampleButtonCoords"),"","","Log sample (Scan field)", "", "Standard"], _
   ["Glass","B","","","","Study",$stdSleep, "Standard"], _
   ["List","U","","","","Clincial Site",$stdSleep, "Standard"], _
   ["Text","","Pad","Pad","", "Referral Number (PAD)", $stdSleep, "Standard"], _
   ["Text","",getTestValue("BTB", "LabelID1"),getTestValue("BTB", "LabelID1"),"", "BBk849 ID", $stdSleep, "Standard"], _
   ["ClickOK","","","","","Log sample", "", "Standard"], _
   ["CloseDialog","","","","","", "", "Standard"] _
   ]
   addTestScheme("BTB", "Log sample", $btbLoginSampleTestScheme)

   ; ---------- BBK Patol ----------
   Local $bbkPatolLoginSampleTestScheme[8][8] = [ _
   ["Click","",getTestValue("BBK_PATOL", "LogSampleButtonCoords"),"","","Log sample", "", "Standard"], _
   ["Text","",getTestValue("BBK_PATOL","NonPreRegLID"),getTestValue("BBK_PATOL","NonPreRegLID"),"","ProvID",$stdSleep, "Standard"], _
   ["CloseUserDialog","","","","","Ange provets position", $stdSleep, "Standard"], _
   ["DismissDialog","","","","","Information", $stdSleep, "Standard"], _
   ["Text","","PAD","PAD","","PAD-nummer",$stdSleep, "Standard"], _
   ["Text","","19121212-1212","19121212-1212","","Personnummer",$stdSleep, "Standard"], _
   ["Glass","B","BBK","","","Samling",$stdSleep, "Standard"], _
   ["ClickOK","","","","","Log sample", "", "Standard"] _
   ]
   addTestScheme("BBK_PATOL", "Log sample non-prereg", $bbkPatolLoginSampleTestScheme)

;~    ["Skip","","","","","",200, "Standard"], _
;~    ["Skip","","","","","",200, "Standard"], _
;~    ["Skip","","","","","",200, "Standard"], _
;~    ["Skip","","","","","",200, "Standard"], _
;~    ["Skip","","","","","",200, "Standard"], _
;~    ["Skip","","","","","",200, "Standard"], _
;~    ["Skip","","","","","",200, "Standard"], _
;~    ["Skip","","","","","",200, "Standard"], _
;~    ["Skip","","","","","",200, "Standard"], _
;~    ["Skip","","","","","",200, "Standard"], _
;~    ["Skip","","","","","",200, "Standard"], _
;~    ["Skip","","","","","",200, "Standard"], _
;~    ["Skip","","","","","",200, "Standard"], _
;~    ["Skip","","","","","",200, "Standard"], _
;~    ["Skip","","","","","",200, "Standard"], _
;~    ["Skip","","","","","",200, "Standard"], _
;~    ["Skip","","","","","",200, "Standard"], _
;~    ["Skip","","","","","",200, "Standard"], _
;~    ["Skip","","","","","",200, "Standard"], _
;~    ["Skip","","","","","",200, "Standard"], _

EndFunc

;~    ["List","U","","","","Clincial Site",$stdSleep, "Standard"], _
;~    ["Text","","Pad","Pad","", "Referral Number (PAD)", $stdSleep, "Standard"], _
;~    ["Text","","BBk849","Bbk849","", "Bbk849Id", $stdSleep, "Standard"], _
;~    ["Text","","2D rör Id","2D rör Id","", "2D Rör-ID", $stdSleep, "Standard"], _
;~    ["Text","","Sample Id","Sample Id","", "Sample Id", $stdSleep, "Standard"], _
;~    ["List","s","","","","Sample Type",$stdSleep, "Standard"], _
;~    ["Sprec","","","","","Sprec",0, "Standard"], _
;~    ["List","B","","","","Localization",$stdSleep, "Standard"], _
;~    ["List","M","","","","Diagnosis (MORF-kod)",$stdSleep, "Standard"] _



; ======= "Old" test schemes ==========

;~ Local $groupConfigArray[12][8] = [ _
;~ ["Skip","","","","","Template",0, "None"], _
;~ ["Glass","m","MOLDERM_TER","","","Study",$stdSleep, "None"], _
;~ ["List","k","","","","Clincial Site",$stdSleep, "None"], _
;~ ["Skip","","","","","Personal number",0, "None"], _
;~ ["Text","","TER 88",$maliciousString,"","Subject ID",$stdSleep, "Malware"], _
;~ ["Text","",$curLabelID,$maliciousString,"","LabelID",$stdSleep, "Malware"], _
;~ ["List","s","","","","Sample Type",$stdSleep, "None"], _
;~ ["Sprec","","","","","Sprec",0, "None"], _
;~ ["Skip","","","","","Sampled Date",0, "None"], _
;~ ["Skip","","","","","Sampled Volume/Amount",0, "None"], _
;~ ["Glass","m","ML","","","Sample Units",$stdSleep, "None"], _
;~ ["List","f","","","","Sample Form",$stdSleep, "None"] _
;~ ]

;~ Local $groupConfigArray[1][12][8] = [ _
;~ [ _
;~ ["Skip","","","","","Template",0, "Standard"], _
;~ ["Glass","m","MOLDERM_TER","","","Study",$stdSleep, "Standard"], _
;~ ["List","k","","","","Clincial Site",$stdSleep, "Standard"], _
;~ ["Skip","","","","","Personal number",0, "Standard"], _
;~ ["Text","","TER 88",$maliciousString,"","Subject ID",$stdSleep, "Malware"], _
;~ ["Text","",$curLabelID,$curLabelID,"","LabelID",$stdSleep, "Malware"], _
;~ ["List","s","","","","Sample Type",$stdSleep, "Standard"], _
;~ ["Sprec","","","","","Sprec",0, "Standard"], _
;~ ["Skip","","","","","Sampled Date",0, "Standard"], _
;~ ["Skip","","","","","Sampled Volume/Amount",0, "Standard"], _
;~ ["Glass","m","ML","","","Sample Units",$stdSleep, "Standard"], _
;~ ["List","f","","","","Sample Form",$stdSleep, "Standard"] _
;~ ] _
;~ ]


;TestTypes: None, Standard, Malware

Local $groupConfigArray[2][14][8] = [ _
[ _
["Skip","","","","","Template",0, "Standard"], _
["Glass","m","MOLDERM_TER","","","Study",$stdSleep, "Standard"], _
["List","k","","","","Clincial Site",$stdSleep, "Standard"], _
["Skip","","","","","Personal number",0, "Standard"], _
["Text","","TER 88",$maliciousString,"","Subject ID",$stdSleep, "Malware"], _
["Text","",$curLabelID,$curLabelID,"","LabelID",$stdSleep, "Malware"], _
["List","s","","","","Sample Type",$stdSleep, "Standard"], _
["Sprec","","","","","Sprec",0, "Standard"], _
["Skip","","","","","Sampled Date",0, "Standard"], _
["Skip","","","","","Sampled Volume/Amount",0, "Standard"], _
["Glass","m","ML","","","Sample Units",$stdSleep, "Standard"], _
["List","f","","","","Sample Form",$stdSleep, "Standard"], _
["Skip","","","","","Sampled Volume/Amount",0, "Standard"], _
["Skip","","","","","Sampled Volume/Amount",0, "Standard"] _
], _
[ _
["Skip","","","","","Template",0, "Standard"], _
["Glass","m","MDS_HERM_TEST","","","Study",$stdSleep, "Standard"], _
["List","h","","","","Clincial Site",$stdSleep, "Standard"], _
["Skip","","","","","Personal number",0, "Standard"], _
["Text","","MDS_188",$maliciousString,"","Subject ID",$stdSleep, "Malware"], _
["Text","",$curLabelID,$curLabelID,"","LabelID",$stdSleep, "Malware"], _
["List","s","","","","Sample Type",$stdSleep, "Standard"], _
["Sprec","","","","","Sprec",0, "Standard"], _
["Skip","","","","","Sampled Date",0, "Standard"], _
["Skip","","","","","Sampled Volume/Amount",0, "Standard"], _
["Glass","m","MG","","","Sample Units",$stdSleep, "Standard"], _
["List","f","","","","Sample Form",$stdSleep, "Standard"], _
["RadioButton","","False","","","Aliquot Sample",0, "Standard"] _
] _
]
;~ ], _
;~ [ _
;~ ["Text", "", $tvBBKPATOL.Item("LabelID"), $tvBBKPATOL.Item("LabelID"), "", "LabelID", $stdSleep, "Standard"]
;~ ] _
;~ ]



