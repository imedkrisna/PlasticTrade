import excel "D:\BEE\CIPS Werk\Ecopp\Paper Trade\Mas Imed\data\data01.xlsx", sheet("Sheet1") firstrow
gen id = _n
reshape long ivalue_ ivolume_, i(id) j(year)

