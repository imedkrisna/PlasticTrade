
cd "C:\github\PlasticTrade\data\stata"

// for exporters

use miede.dta,clear
sum if substr(HSXCODE,1,4)=="3915"
bys year: sum if substr(HS2012,1,4)=="3915"

/* 9308 11983 15309 17121 17427 41054 47666 48856 49172 49317 52165 52220 56884 56903
>  57007 57043 57062 57068 57842 65201 65218 68860
*/

// for importers

use miidi.dta,clear
sum if substr(HS2012,1,4)=="3915"
bys year: sum if substr(HS2012,1,4)=="3915"

/* 13908 13997 14329 17992 22825 22904 22907 28582 29904 35701 45477 48683 49150 4931
> 7 50637 51578 51748 51907 54625 56855 59345 59361 59376 59394 59960 60373 65958 
> 67374 68423 68431 68469 68863 70575
*/

// Generate plastic importers

use miidi.dta,clear
gen impor=0
replace impor = 1 if substr(HS2012,1,4)=="3915"

// aggregate by countries
// aggregate by 3915

