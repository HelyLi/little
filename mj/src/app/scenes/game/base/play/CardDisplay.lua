CardDisplay = CardDisplay or {}

--获取大号牌图片
function CardDisplay.getCardBigImgByData(cardData)
    local imgFile = ""
    if cardData >= 0x01 and cardData <= 0x09 then
        --1-9万
        imgFile = string.format("#game_mjd__%02d.png", 1 + (cardData - 0x01))
    elseif cardData >= 0x11 and cardData <= 0x19 then
        --1-9条
        imgFile = string.format("#four_mj_b%02d.png", 11 + (cardData - 0x11))
    elseif cardData >= 0x21 and cardData <= 0x29 then
        --1-9筒
        imgFile = string.format("#four_mj_b%02d.png", 21 + (cardData - 0x21))
    elseif cardData >= 0x31 and cardData <= 0x37 then
        --东南西北中发白
        imgFile = string.format("#game_mjd__%02d.png", 10 + (cardData - 0x31))
    elseif cardData >= 0x41 and cardData <= 0x48 then
        --春夏秋冬梅兰竹菊
        imgFile = string.format("#game_mjd__%02d.png", 17 + (cardData - 0x41))
    end
end

--正常大小
function CardDisplay.getCardNormal(cardData)
    local pCardBack = display.newSprite("#four_mj_my_hand.png")

    local imgFile = CardDisplay.getCardBi
    
end

return CardDisplay