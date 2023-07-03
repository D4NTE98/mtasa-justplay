--[[
	Model buffalo dla frakcji SAFD
	Autorem modelu jest arbuzeq20

	Prawa do używania modelu posiada jedynie serwer Just Play (c)
]]

txd = engineLoadTXD("assets/towtruck.txd") 
dff = engineLoadDFF("assets/towtruck.dff") 

engineImportTXD(txd, 502) 
engineReplaceModel(dff, 502, true) 