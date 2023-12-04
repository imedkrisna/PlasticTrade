
cd "C:\github\PlasticTrade\data\stata"

// for exporters

use miede.dta,clear
sum if substr(HSXCODE,1,4)=="3915"
bys year: sum if substr(HSXCODE,1,4)=="3915"

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

/*
use miede.dta,clear
gen plastic=0
replace plastic = 1 if substr(HSXCODE,1,4)=="3915"
bys year plastic: egen pctr=sum(NETWTHS)
duplicates drop year plastic,force
keep if plastic==1
keep year pctr
*/

use miidi.dta,clear
gen plastic=0
replace plastic = 1 if substr(HS2012,1,4)=="3915"
bys year plastic: egen pctr=sum(NILAI__U)
duplicates drop year plastic,force
keep if plastic==1
keep year pctr
export delimited using "../impor", replace

clear all
use miidi.dta,clear
gen plastic=0
replace plastic = 1 if substr(HS2012,1,4)=="3915"
gen disic5 = DISIC508
replace disic5=DISIC509 if disic5==""
replace disic5=DISIC510 if disic5==""
replace disic5=DISIC511 if disic5==""
replace disic5=DISIC512 if disic5==""
gen disic2=substr(disic5,1,2)
drop if plastic ==0
bys year disic2: egen pctr=sum(NILAI__U)
keep year disic2 pctr
duplicates drop year disic2,force

clear all
use miidi.dta,clear
gen plastic=0
replace plastic = 1 if substr(HS2012,1,4)=="3915"
merge m:m psid year using paper2si
replace plastic = 0 if plastic==.

// aggregate by countries
// aggregate by 3915

