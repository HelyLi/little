--[[
    添加，创建新的活动
]]

-- 本地活动类别  start ---------------------------------------------------------------------------------
local LocalType = {
    SUB_RED_ENVELOPES           = "local_red_envelopes",        --红包专属
    SUB_FJ_PDK                  = "local_fj_pdk",               --伏击
    SUB_INVATE_CHAI_HONEBAO     = "local_invate_chai_hongbao",  --邀请好友拆红包
    SUB_INVATE_HUIGUI           = "local_invate_huigui",        --邀请回归
    SUB_JAY_CHOU_TICKET         = "local_jay_chou_ticket",      --周杰伦门票
    SUB_PAIXING_SHARE_PRAISE    = "local_paixing_share_praise", --牌型分享点赞
    SUB_RECALL_FRIEND           = "local_recall_friend",        --好友召回
    SUB_NEW_YEAR_RED_PACKET     = "local_new_year_red_packet",   --新年红包
    -- SUB_NEW_YEAR_RED_PACKET     = "local_new_year_red_packet"--新年红包
    SUB_NEW_APP                 = "local_new_app"
}

local SubActAppleSharePop = import(".SubActAppleSharePop")
local SubActInvitationBack = import(".SubActInvitationBack")
local SubActDDZPop = import(".SubActDDZPop")
local SubActChaiRedEnvelopes = import(".SubActChaiRedEnvelopes")
local SubActJayChouTicket = import(".SubActJayChouTicket")
local SubActLocalAgent = import(".SubActLocalAgent")
local SubActPxSharePraise = import(".SubActPxSharePraise")
local SubActRedEnvelopes = import(".SubActRedEnvelopes")
local SubActRecallFriend = import(".SubActRecallFriend")
local SubActNewYearHongBao = import(".SubActNewYearHongBao")
local SubActLocalNewApp = import(".SubActLocalNewApp")
-- 本地活动 end ----------------------------------------------------------------------------------------

local ActivityContentFactory = class("ActivityContentFactory", BaseView)

function ActivityContentFactory:ctor(params)
    self._container = params.container
end

function ActivityContentFactory:getActivityLayer()
    return self._container or self
end

function ActivityContentFactory:createActivity(params)
    local contentData = params.contentData
    local subActivity = nil
    
    if contentData.subtype == LocalType.SUB_FJ_PDK then
        -- 免费开房
        subActivity = SubActDDZPop.new({container = self:getActivityLayer(), contentData = contentData })
    elseif contentData.subtype == LocalType.SUB_INVATE_CHAI_HONEBAO then
        --邀请好友拆红包
        subActivity = SubActChaiRedEnvelopes.new({container = self:getActivityLayer(), contentData = contentData })
    elseif contentData.subtype == LocalType.SUB_INVATE_HUIGUI then
        --邀请回归
        subActivity = SubActInvitationBack.new({container = self:getActivityLayer(), contentData = contentData })
    elseif contentData.subtype == LocalType.SUB_JAY_CHOU_TICKET then
        --周杰伦门票
        subActivity = SubActJayChouTicket.new({container = self:getActivityLayer(), contentData = contentData })
    elseif contentData.subtype == LocalType.SUB_PAIXING_SHARE_PRAISE then
        --牌型分享点赞
        subActivity = SubActPxSharePraise.new({container = self:getActivityLayer(), contentData = contentData })
    elseif contentData.subtype == LocalType.SUB_RED_ENVELOPES then
        --红包专属
        subActivity = SubActRedEnvelopes.new({container = self:getActivityLayer(), contentData = contentData })
    elseif contentData.subtype == LocalType.SUB_RECALL_FRIEND then
        --好友召回
        subActivity = SubActRecallFriend.new({container = self:getActivityLayer(), contentData = contentData })
    elseif contentData.subtype == LocalType.SUB_NEW_YEAR_RED_PACKET then
        --新年红包
        subActivity = SubActNewYearHongBao.new({container = self:getActivityLayer(), contentData = contentData })
    elseif contentData.subtype == LocalType.SUB_NEW_APP then
        --TestFlight
        subActivity = SubActLocalNewApp.new({container = self:getActivityLayer(), contentData = contentData })
    else
        -- --新年红包
        -- subActivity = SubActNewYearHongBao.new({container = self:getActivityLayer(), contentData = contentData })
        dump(contentData, "ActivityContentFactory:createActivity undefine activity")
    end

    return subActivity 
end

return ActivityContentFactory