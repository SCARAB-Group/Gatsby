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
   ["Skip","","","","","Template",0, "Standard"], _
   ["Glass","m","MOLDERM_TER","","","Study",$stdSleep, "Standard"], _
   ["List","k","","","","Clincial Site",$stdSleep, "Standard"], _
   ["Skip","","","","","Personal number",0, "Standard"], _
   ["Text","","TER 88",$maliciousString,"","Subject ID",$stdSleep, "Malware"], _
   ["Text","",getTestValue("MOLDERM", "LabelID1"),getTestValue("MOLDERM", "LabelID1"),"","LabelID",$stdSleep, "Standard"], _
   ["List","s","","","","Sample Type",$stdSleep, "Standard"], _
   ["Sprec","","","","","Sprec",0, "Standard"], _
   ["Skip","","","","","Sampled Date",0, "Standard"], _
   ["Skip","","","","","Sampled Volume/Amount",0, "Standard"], _
   ["Glass","m","ML","","","Sample Units",$stdSleep, "Standard"], _
   ["List","f","","","","Sample Form",$stdSleep, "Standard"], _
   ["Skip","","","","","Sampled Volume/Amount",0, "Standard"], _
   ["Skip","","","","","Sampled Volume/Amount",0, "Standard"], _
   ["Close","","","","","", "", "Standard"] _
   ]
   addTestScheme("MOLDERM", "Log sample", $moldermLoginSampleTestScheme)
EndFunc



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



