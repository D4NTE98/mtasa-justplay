txd = engineLoadTXD("towtruck.txd") 
dff = engineLoadDFF("towtruck.dff") 

engineImportTXD(txd, 443) 
engineReplaceModel(dff, 443, true) 


