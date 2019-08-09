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

    return imgFile
end

function CardDisplay.getCardMinImgByData(cardData)
    local imgFile = ""
    if cardData >= 0x01 and cardData <= 0x09 then
        --1-9万子
        imgFile = string.format("#game_mjz__%02d.png", 1 + (cardData - 0x01))
    elseif cardData >= 0x11 and cardData <= 0x19 then
        --1-9条
        imgFile = string.format("#four_mj_m%02d.png", 11 + (cardData - 0x11))
    elseif cardData >= 0x21 and cardData <= 0x29 then
        --1-9筒
        imgFile = string.format("#four_mj_m%02d.png", 21 + (cardData - 0x21))
    elseif cardData >= 0x31 and cardData <= 0x37 then
        --东南西北中发白
        imgFile = string.format("#game_mjz__%02d.png", 10 + (cardData - 0x31))
    elseif cardData >= 0x41 and cardData <= 0x48 then
        --春夏秋冬梅兰竹菊
        imgFile = string.format("#game_mjz__%02d.png", 17 + (cardData - 0x41))
    elseif cardData == 0x60 then
        --任意牌
        imgFile = "#".."game_mjz__25.png"
    end

    return imgFile
end

--是否指定牌型
function CardDisplay.isCardType(cardType, cardData)
    if cardType == GameConstants.CARD_TYPE.WAN and cardData >= 0x01 and cardData <= 0x09 then
        return true
    elseif cardType == GameConstants.CARD_TYPE.TIAO and cardData >= 0x11 and cardData <= 0x19 then
        return true
    elseif cardType == GameConstants.CARD_TYPE.TONG and cardData >= 0x21 and cardData <= 0x29 then
        return true
    elseif cardType == GameConstants.CARD_TYPE_FENG and cardData >= 0x31 and cardData <= 0x37 then
        --东南西北中发白
        return true
    elseif cardType == GameConstants.CARD_TYPE_HUA and (0x40 == bit._and(cardData, 0xF0)  or 0x30 == bit._and(cardData, 0xF0)) then
        --春夏秋冬梅兰竹菊
        return true
    end
    return false
end

--正常大小
function CardDisplay.getCardNormal(cardData)
    local pCardBack = display.newSprite("#four_mj_my_hand.png")

    local imgFile = CardDisplay.getCardBi
    
end

--增加金牌标志
function CardDisplay.addToldFlag(pCard)
    local pGoldCardFlag = nil

    local pCardTxt = pCard:getChildByTag(GameConstants.CARD_TAG.TXT_B) or pCard:getChildByTag(GameConstants.CARD_TAG.TXT_M)
    if pCardTxt ~= nil then
        if pCardTxt:getTag() == GameConstants.CARD_TAG.TXT_B then
            pGoldCardFlag = cc.ui.UIImage.new("#".."QZMJ_card_gold_b.png")
        else
            pGoldCardFlag = cc.ui.UIImage.new("#".."QZMJ_card_gold_m.png")
        end
    end

    if pGoldCardFlag ~= nil then
        pGoldCardFlag:align(display.BOTTOM_LEFT, 0, 0):addTo(pCardTxt)
    end
end

return CardDisplay