clear all
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
bys year: egen pltr=sum(NILAI__U)
duplicates drop year plastic,force
keep if plastic==1
gen pct=pctr/pltr*100
keep year pctr pltr pct
export delimited using "../impor", replace

clear all
use miidi.dta,clear
gen plastic=0
replace plastic = 1 if substr(HS2012,1,4)=="3915"
keep if plastic==1
bys psid year: egen implas=sum(NILAI__U)
duplicates drop psid year,force
keep psid year implas plastic
merge 1:m psid year using paper2si
replace plastic=0 if plastic==.
replace disic5=disic5*100 if disic5<999
tostring disic5,replace
gen disic44=substr(disic5,1,4)

destring disic44,replace

// convert ISIC 3 (2008 & 2009) to ISIC4 (2010,2011,2012)

quietly do isic
tostring disic44,replace
replace disic44="0162" if disic44=="162"
gen disic22=substr(disic44,1,2)

la var	dprovi	"Province"
la var	dkabup	"Regency/Municipality"
la var	dkecam	"Sub-regency"
la var	ddesa	"Village"
la var	dsta	"Ownership" // 1=PMDN 2=PMA 3=Non-fasilitas
la var	loca	"Industrial Zone" // 1=inside 2=outside 0=ngatau .=ngatau
la var	disic5	""
la var	disic4	""
la var	disic3	""
la var	disic2	""
la var	dpusat	"Ownership by central government (%)"
la var	dpemda	"Ownership by local government (%)"
la var	ddmstk	"Ownership by private domestic (%)"
la var	dasing	"Ownership by private foreign (%)"
la var	ceksum	"Ownership total (%)"
la var	ltlnou	"Number of workers"
la var	zpdvcu	"Total wage of production workers (IDR)"
la var	zndvcu	"Total wage of non-production workers (IDR)"
la var	it1vcu	"Total other expenses (including tax) (current IDR)"
la var	oelkhu	"Electricity sold (KwH)"
la var	yelvcu	"Electricity sold (IDR)"
la var	eplkhu	"Electricity bought from PLN (KwH)"
la var	eplvcu	"Electricity bought from PLN (IDR)"
la var	enpkhu	"Electricity bought from non-PLN (KwH)"
la var	enpvcu	"Electricity bought from non-PLN (IDR)"
la var	esgkhu	"Self-Generated electricity (KwH)"
la var	efuvce	"Self-Generated electricity (IDR)"
la var	efuvcu	"Total Energy-related materials including for input (IDR)"
la var	rdnvcu	"Domestic input (IDR)"
la var	rimvcu	"Imported input (IDR)"
la var	rtlvcu	"total input (IDR)"
la var	yprvcu	"Total sales / Revenue (IDR)"
la var	prprca	"Utilization rate (%)"
la var	yisvcu	"Income from industrial service (Makloon) (IDR)"
la var	yrnvcu	"Other income (IDR)"
la var	ytivcu	"Makloon+other income (IDR)"
la var	v1101	"Fixed asset: Land (IDR)"
la var	v1103	"Fixed asset: Building (IDR)"
la var	v1106	"Fixed asset: Machinery (IDR)"
la var	v1109	"Fixed asset: Vehicles (IDR)"
la var	v1112	"Fixed asset: Others (IDR)"
la var	v1115	"Total fixed asset (IDR)"
la var	ctttcu	"Asset purchased (IDR)"
la var	ctsacu	"Asset sold (IDR)"
la var	ctdacu	"Depreciation (IDR)"
la var	iinput	"Total expenses / input (IDR)"
la var	output	"Total output / sales (IDR)"
la var	vtlvcu	"Total Value Added (IDR)"
la var	prprex	"Fraction of exported output %)"

save datause,replace

/*
levelsof disic44 if plastic==1
"1063"	"1312"	"1313"	"1391"	"1399"	"1411"	"1512"	"1520"	"1701"	"2022"	"2030"	"2220"	"2222"	"2223"	"2229"	"2593"	"2599"	"2930"	"3220"

levelsof psid if plastic==1
13908	13997	14329	17992	22825	22904	22907	28582	29904	35701	45477	48683	49150	49317	50637	51578	51748	51907	54625	56855	59345	59361	59376	59394	59960	60373	65958	67374	68423	68431	68469	68863	70575

*/

gen plastisic=0
replace plastisic=1 if disic44==	"1063"
replace plastisic=1 if disic44==	"1312"
replace plastisic=1 if disic44==	"1313"
replace plastisic=1 if disic44==	"1391"
replace plastisic=1 if disic44==	"1399"
replace plastisic=1 if disic44==	"1411"
replace plastisic=1 if disic44==	"1512"
replace plastisic=1 if disic44==	"1520"
replace plastisic=1 if disic44==	"1701"
replace plastisic=1 if disic44==	"2022"
replace plastisic=1 if disic44==	"2030"
replace plastisic=1 if disic44==	"2220"
replace plastisic=1 if disic44==	"2222"
replace plastisic=1 if disic44==	"2223"
replace plastisic=1 if disic44==	"2229"
replace plastisic=1 if disic44==	"2593"
replace plastisic=1 if disic44==	"2599"
replace plastisic=1 if disic44==	"2930"
replace plastisic=1 if disic44==	"3220"

keep if plastisic==1

gen psidp=0
replace psidp=1 if psid==	13908
replace psidp=1 if psid==	13997
replace psidp=1 if psid==	14329
replace psidp=1 if psid==	17992
replace psidp=1 if psid==	22825
replace psidp=1 if psid==	22904
replace psidp=1 if psid==	22907
replace psidp=1 if psid==	28582
replace psidp=1 if psid==	29904
replace psidp=1 if psid==	35701
replace psidp=1 if psid==	45477
replace psidp=1 if psid==	48683
replace psidp=1 if psid==	49150
replace psidp=1 if psid==	49317
replace psidp=1 if psid==	50637
replace psidp=1 if psid==	51578
replace psidp=1 if psid==	51748
replace psidp=1 if psid==	51907
replace psidp=1 if psid==	54625
replace psidp=1 if psid==	56855
replace psidp=1 if psid==	59345
replace psidp=1 if psid==	59361
replace psidp=1 if psid==	59376
replace psidp=1 if psid==	59394
replace psidp=1 if psid==	59960
replace psidp=1 if psid==	60373
replace psidp=1 if psid==	65958
replace psidp=1 if psid==	67374
replace psidp=1 if psid==	68423
replace psidp=1 if psid==	68431
replace psidp=1 if psid==	68469
replace psidp=1 if psid==	68863
replace psidp=1 if psid==	70575

sum dasing ltlnou rimvcu v1115 output vtlvcu prprca if psidp==0
sum dasing ltlnou rimvcu v1115 output vtlvcu prprca if psidp==1
drop _merge
merge m:1 year using "deflator.dta"
gen netiv=ctttcu-ctsacu-ctdacu
gen lo=log(output/defoutput)
gen lva=log(vtlvcu/defoutput)
gen lk=log(v1115/defkap)
gen ln=log(ltlnou)
gen lm=log(rtlvcu/definput)
gen linv=log(netiv/defkap)
replace implas=0 if implas==.
gen limplas=log(1+implas/definput)

la var netiv "net investment"
la var lo "Log output"
la var lva "Log value added"
la var lk "Log capital"
la var ln "Log #workers"
la var plastic "plastic waste import dummy"
la var limplas "log plastic waste import"


gen regg=0
replace regg=1 if lk>5 & lk<.

save datause2, replace

xtset psid year
prodest lva if regg==1, free(ln) state(lk) proxy(lm) method(lp) fsresidual(om) va
outreg2 using "tfp1.xls",excel replace

predict mu,markups inputvar(ln)

predict tfp,omega

la var mu "Markups"
la var tfp "TFP"

outreg2 using stat1.doc, replace sum(log) keep(output vtlvcu ltlnou v1115 rimvcu prprex dasing mu tfp)

outreg2 using stat2.doc if psidp==0, replace sum(log) keep(output vtlvcu ltlnou v1115 rimvcu prprex dasing mu tfp)

outreg2 using stat3.doc if psidp==1, replace sum(log) keep(output vtlvcu ltlnou v1115 rimvcu prprex dasing mu tfp)

xtreg lva tfp ln lk plastic if regg==1
outreg2 using "reg.doc", replace ctitle(RE) label
xtreg lva tfp ln lk plastic if regg==1,fe
outreg2 using "reg.doc", append ctitle(FE) label
xtreg lva tfp ln lk limplas if regg==1
outreg2 using "reg.doc", append ctitle(RE) label
xtreg lva tfp ln lk limplas if regg==1, fe
outreg2 using "reg.doc", append ctitle(FE) label

