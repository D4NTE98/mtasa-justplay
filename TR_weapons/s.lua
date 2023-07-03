function checkDamage(att, weap, body, loss)
    setCustomDamage(source, att, weap, body, loss)
    local armorID = getElementData(source, "armorID")
    if not armorID then return end

    local armor = getPedArmor(source)
    exports.TR_mysql:querry("UPDATE tr_items SET value = ? WHERE ID = ? LIMIT 1", armor, armorID)
end
addEventHandler("onPlayerDamage", root, checkDamage)

function setCustomDamage(plr, att, weapon, body, loss)
    if body == 9 then
        if getElementData(plr, 'characterUID') == 2 then return end
        killPed(plr)
        cancelEvent()
    end
    if weapon == 8 then
        if getElementData(plr, 'characterUID') == 2 then return end
        setElementHealth(plr, getElementHealth(plr) - 20)
        damagePlayer(plr, 15, att, weapon)
        cancelEvent()
    else
        damagePlayer(plr, math.random(3, 7), att, weapon)
    end
end

function damagePlayer(player,amount,damager,weapon)
    local amount=amount
    if(isElement(player))then
        local armor=getPedArmor(player)
        local health=getElementHealth(player)
        local died=false
        if(armor>0)then
            if(armor>=amount)then
                setPedArmor(player,armor-amount)
            else
                setPedArmor(player,0)
                local newamount=amount-armor
                if(health-newamount<=0)then
                    killPed(player,damager,weapon,3,false)
                    amount=armor+health
                    died=true
                else
                    setElementHealth(player,health-newamount)
                end
            end
        else
            if(health-amount<=0)then
                amount=health
                killPed(player,damager,weapon,3,false)
                died=true
            else
                setElementHealth(player,health-amount)
            end
        end
    end
end