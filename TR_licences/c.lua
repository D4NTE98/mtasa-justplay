local sx, sy = guiGetScreenSize()
zoom = 1
local baseX = 1920
local minZoom = 2
if sx < baseX then
  zoom = math.min(minZoom, baseX/sx)
end

boughtExams = {
  theory = {},
  practise = {},
}

exports.TR_dx:setResponseEnabled(false)
function buyLicenceExam(data)
  if boughtExams[data[2]][data[1]] then
    exports.TR_dx:setResponseEnabled(false)
    exports.TR_noti:create("Nie możesz opłacić tego egzaminu, ponieważ jest on już opłacony.", "error")
    return
  end

  if data[2] == "theory" then
    triggerServerEvent("createPayment", resourceRoot, licences[data[1]].priceTheory, "payLicenceExam", data)

  elseif data[2] == "practise" then
    triggerServerEvent("createPayment", resourceRoot, licences[data[1]].pricePractise, "payLicenceExam", data)
  end
end
addEvent("buyLicenceExam", true)
addEventHandler("buyLicenceExam", root, buyLicenceExam)


function payLicenceExam(state, data)
  exports.TR_dx:setResponseEnabled(false)

  if state then
    boughtExams[data[2]][data[1]] = true
    exports.TR_noti:create("Egzamin został pomyślnie opłacony. Udaj się do odpowiedniego stanowiska aby go rozpocząć.", "success")
  end
end
addEvent("payLicenceExam", true)
addEventHandler("payLicenceExam", root, payLicenceExam)
