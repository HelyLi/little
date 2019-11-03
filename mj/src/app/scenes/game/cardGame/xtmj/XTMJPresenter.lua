local CardPresenter = import("..base.CardPresenter")
local XTMJRoomData = import(".XTMJRoomData")
local XTMJPlayingData = import(".XTMJPlayingData")
local Subgame_Def = import("app.pb.Subgame_Def")

local XTMJPresenter = class("XTMJPresenter",CardPresenter)

function XTMJPresenter:ctor(view)
    XTMJPresenter.super.ctor(self, view)
    self:initSubGameHandlerMsg()
    self.m_roomData = XTMJRoomData.new()
    self.m_playingData = XTMJPlayingData.new()
end

function XTMJPresenter:onEnter()
    
end

function XTMJPresenter:onExit()
    
end

-- enum messageid 
-- {
--     //起始位置, 无意义
--     NULL = 0;
    
--     // M2C
--     M2C_GAME_START_NOTIFY                 = 100000;  //游戏开始
--     M2C_PLAYER_CATCH_CARD_NOTIFY          = 100001;  //抓牌
--     M2C_PLAYER_DISCARD_ACK                = 100002;  //出牌
--     M2C_MAHJONG_INTERCEPTED_EVENTS_NOTIFY = 100003;  //操作提示
--     M2C_MAHJONG_INTERCEPTED_DELETE_ACK    = 100004;  //删除操作按钮
--     M2C_MAHJONG_INTERCEPTED_EVENTS_ACK    = 100005;  //操作确认
--     M2C_PLAYER_SCORE_CHANGE               = 100006;  //玩家分数变化
--     M2C_GAME_END_NOTIFY                   = 100007; //单局结束
--     M2C_GAME_SUMMARIZATION_INFO_NOTIFY    = 100008; //总结算

--     M2C_ROOM_STATE_FREE_NOTIFY            = 100020; //重连-空闲状态
--     M2C_ROOM_STATE_PLAYING_NOTIFY         = 100021; //重连-游戏状态
    
--     // C2M
--     C2M_PLAYER_DISCARD_SYN                = 200000; //出牌
--     C2M_MAHJONG_INTERCEPTED_EVENTS_SYN    = 200001; //操作命令
-- }

function XTMJPresenter:initSubGameHandlerMsg()

    self.m_handlerTable[M2C_GAME_START_NOTIFY] = handler(self, self.M2C_GAME_START_NOTIFY)
    self.m_handlerTable[M2C_PLAYER_CATCH_CARD_NOTIFY] = handler(self, self.M2C_PLAYER_CATCH_CARD_NOTIFY)
    self.m_handlerTable[M2C_PLAYER_DISCARD_ACK] = handler(self, self.M2C_PLAYER_DISCARD_ACK)
    self.m_handlerTable[M2C_MAHJONG_INTERCEPTED_EVENTS_NOTIFY] = handler(self, self.M2C_MAHJONG_INTERCEPTED_EVENTS_NOTIFY)
    self.m_handlerTable[M2C_MAHJONG_INTERCEPTED_DELETE_ACK] = handler(self, self.M2C_MAHJONG_INTERCEPTED_DELETE_ACK)
    self.m_handlerTable[M2C_MAHJONG_INTERCEPTED_EVENTS_ACK] = handler(self, self.M2C_MAHJONG_INTERCEPTED_EVENTS_ACK)
    self.m_handlerTable[M2C_PLAYER_SCORE_CHANGE] = handler(self, self.M2C_PLAYER_SCORE_CHANGE)
    self.m_handlerTable[M2C_GAME_END_NOTIFY] = handler(self, self.M2C_GAME_END_NOTIFY)
    self.m_handlerTable[M2C_GAME_SUMMARIZATION_INFO_NOTIFY] = handler(self, self.M2C_GAME_SUMMARIZATION_INFO_NOTIFY)
    self.m_handlerTable[M2C_ROOM_STATE_FREE_NOTIFY] = handler(self, self.M2C_ROOM_STATE_FREE_NOTIFY)
    self.m_handlerTable[M2C_ROOM_STATE_PLAYING_NOTIFY] = handler(self, self.M2C_ROOM_STATE_PLAYING_NOTIFY)

end
--游戏开始
-- message MSG_M2C_GAME_START_NOTIFY
-- {
--     optional   uint32 messageid = 1;
    
--     /* 游戏开始基本信息 */
--     optional   GAME_START_INFO gamestartinfo = 2;
-- }
function XTMJPresenter:M2C_GAME_START_NOTIFY(msgData)
    local data = Subgame_Def:M2C_GAME_START_NOTIFY(msgData) 
    dump(data, "--->>> 游戏开始")
end

-- message MSG_M2C_PLAYER_CATCH_CARD_NOTIFY
-- {
--     optional   uint32 messageid = 1;
--     /* 可操作标识位 */
--     repeated uint32 actiontypevalue = 2;
--     /* 位数量 */
--     /*uint32 bitnums = 3;*/
--     /* 抓牌玩家 */
--     optional   int32 playerstation = 3;
--     /* 抓牌牌值 */
--     optional   int32 cardvalue = 4;
--     /* 手牌张数 */
--     optional   int32 handcardnums = 5;
--     /* 手牌数据-只会接收自己的数据 其他玩家数据是默认值 */
--     repeated int32 handcards = 6;
--     /* 牌堆剩余牌数 */
--     optional   int32 restcardnums = 7;
--     /* 抓牌方向： 1-牌前 0-牌尾 */
--     optional    int32 catchdirection = 8;
--     /* 能杠的牌数据 */
--     repeated int32 gangcardvalue = 9;
-- }
function XTMJPresenter:M2C_PLAYER_CATCH_CARD_NOTIFY(msgData)
    local data = Subgame_Def:M2C_PLAYER_CATCH_CARD_NOTIFY(msgData) 
    dump(data, "--->>> 抓牌") 
end

-- message MSG_M2C_PLAYER_DISCARD_ACK
-- {
--     optional   uint32 messageid = 1;
--     optional   int32 errorcode = 2;
--     /* 出牌玩家 */
--     optional   int32 playerstation = 3;
--     /* 出牌牌值 */
--     optional  int32 cardvalue = 4;
--     /* 手牌张数 */
--     optional   int32 handcardnums = 5;
--     /* 出牌索引 */
--     optional   int32 cardindex = 6;
--     /* 手牌数据-只会接收自己的数据 其他玩家数据是默认值 */
--     repeated int32 handcards = 7;
--     /* 出牌玩家已出牌数据 */
--     repeated int32 playerdiscards = 8;
-- }
function XTMJPresenter:M2C_PLAYER_DISCARD_ACK(msgData)
    local data = Subgame_Def:M2C_PLAYER_DISCARD_ACK(msgData) 
    dump(data, "--->>> 出牌") 
end

-- message MSG_M2C_MAHJONG_INTERCEPTED_EVENTS_NOTIFY
-- {
--     optional    uint32 messageid = 1;
--     /* 可是否可吃碰杠听胡过 */
--     repeated uint32 actiontypevalue = 2;
--     /* 操作玩家 */
--     optional    int32 playerstation = 3;
--     /* 能碰和胡的牌 默认255 */
--     optional   int32 pengorhucardvalue = 4;
--     /* 能杠的牌 */
--     repeated int32 gangcardvalue = 5;
-- }
function XTMJPresenter:M2C_MAHJONG_INTERCEPTED_EVENTS_NOTIFY(msgData)
    local data = Subgame_Def:M2C_MAHJONG_INTERCEPTED_EVENTS_NOTIFY(msgData) 
    dump(data, "--->>> 操作提示") 
end

-- message MSG_M2C_MAHJONG_INTERCEPTED_DELETE_ACK
-- {
--     optional   uint32 messageid = 1;
--     optional   int32 errorcode = 2;
--     /* 能否删除拦截提示 1-true 0-false*/
--     optional   uint32 clearaction = 3;
--     /* 操作玩家 */
--     optional   int32 playerstation = 4;
-- }
function XTMJPresenter:M2C_MAHJONG_INTERCEPTED_DELETE_ACK(msgData)
    local data = Subgame_Def:M2C_MAHJONG_INTERCEPTED_DELETE_ACK(msgData) 
    dump(data, "--->>> 删除操作按钮") 
end

-- message MSG_M2C_MAHJONG_INTERCEPTED_EVENTS_ACK
-- {
--     optional   uint32 messageid = 1;
--     optional   int32 errorcode = 2;
--     optional   MAHJONG_INTERCEPTED_EVENTS_INFO interceptedinfo = 3;
--     /* 手牌张数 */
--     repeated int32 handcardnums = 4;
--     /* 手牌数据-只会接收自己的数据 其他玩家数据是默认值 */
--     repeated int32 handcards = 5;
-- }
function XTMJPresenter:M2C_MAHJONG_INTERCEPTED_EVENTS_ACK(msgData)
    local data = Subgame_Def:M2C_MAHJONG_INTERCEPTED_EVENTS_ACK(msgData) 
    dump(data, "--->>> 操作确") 
end

-- message MSG_M2C_PLAYER_SCORE_CHANGE
-- {
--     message item
--     {
--         optional     uint32 seat = 1;    // 座位
--         optional     int32 amount = 2;   // 数量
--     }
--     optional  uint32 messageid = 1;
--     repeated item data = 2;
-- }
function XTMJPresenter:M2C_PLAYER_SCORE_CHANGE(msgData)
    local data = Subgame_Def:M2C_PLAYER_SCORE_CHANGE(msgData) 
    dump(data, "--->>> 玩家分数变化") 
end

-- message MSG_M2C_GAME_END_NOTIFY
-- {
--     optional   uint32 messageid = 1;
--     /* 是否流局 */
--     optional   uint32 isdrawngame = 2; //0:正常结束  1：流局
--     /* 胡牌玩家数据 */
--     repeated GAME_HU_INFO gamehuinfo = 3;
--     /* 三个玩家的手牌信息 */
--     repeated GAME_END_INFO gameendinfo = 4;
--     optional   int32 hu_card = 5;  // 胡牌值
-- }
function XTMJPresenter:M2C_GAME_END_NOTIFY(msgData)
    local data = Subgame_Def:M2C_GAME_END_NOTIFY(msgData) 
    dump(data, "--->>> 单局结束") 
end

-- message MSG_M2C_GAME_SUMMARIZATION_INFO_NOTIFY
-- {
--     optional   uint32 messageid = 1;
--     /* 游戏总结算信息 */
--     repeated GAME_SUMMARIZATION_INFO gamesummarizationinfo = 2;
--     optional   int32 end_type = 3; // 结束类型（0正常结束，1投票结束)
-- }
function XTMJPresenter:M2C_GAME_SUMMARIZATION_INFO_NOTIFY(msgData)
    local data = Subgame_Def:M2C_GAME_SUMMARIZATION_INFO_NOTIFY(msgData) 
    dump(data, "--->>> 总结算") 
end

-- message MSG_M2C_ROOM_STATE_FREE_NOTIFY
-- {
--     optional   uint32 messageid = 1;
--     repeated ROOM_STATE_PLAYER_FREE_DATA playerfree = 2;
--     optional   uint32 game_time = 3;
--     optional   uint32 currjushu = 4;   //当前局数
-- }
function XTMJPresenter:M2C_ROOM_STATE_FREE_NOTIFY(msgData)
    local data = Subgame_Def:M2C_ROOM_STATE_FREE_NOTIFY(msgData) 
    dump(data, "--->>> 重连-空闲状态") 
end

-- message MSG_M2C_ROOM_STATE_PLAYING_NOTIFY
-- {
--     optional  uint32 messageid = 1;
--     /* 断线回来的游戏开始基本信息 */
--     optional GAME_START_INFO gamestartinfo = 2;
--     /* 玩家已出牌数据 */
--     repeated GAME_HAVEDISCARD_INFO havediscardsinfo = 3;
--     /* 各个玩家已吃碰杠数据 */
--     repeated GAME_HAVECPG_MAININFO havecpgmaininfo = 4;
--     repeated GAME_PLAYER_PLAYING_INFO playerinfo = 5;
-- }
function XTMJPresenter:M2C_ROOM_STATE_PLAYING_NOTIFY(msgData)
    local data = Subgame_Def:M2C_ROOM_STATE_PLAYING_NOTIFY(msgData) 
    dump(data, "--->>> 重连-游戏状态") 
end

return XTMJPresenter