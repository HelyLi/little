local Presenter = class("Presenter")

function Presenter:ctor()
    
end

function Presenter:init(view)
    self.m_view = view
end

function Presenter:onConnected()
    print("onConnected")
end

function Presenter:onClosed()
    print("onClosed")
end

function Presenter:onReveived(data)
    print("onReveived")
end

return Presenter