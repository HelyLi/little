UIAdapter = UIAdapter or {}

UIAdapter.padding = display.padding or 0
UIAdapter.paddingRight = UIAdapter.padding
UIAdapter.paddingBottom = display.paddingBottom or 0
UIAdapter.fitScale = display.fitScale or 1.0

-- display.cx 
function UIAdapter.adCX( _posValue )
    if _posValue then
        return display.cx - ( 1334/2 - _posValue )
    end
end

-- 按比例适配 左下角
function UIAdapter.adRatioX( _posValue )
    if _posValue then
        return display.width * (math.min( _posValue, 1334)/ 1334)
    end
end

function UIAdapter.adRatioY(_posValue)
    if _posValue then
        return display.height * (math.min(_posValue, 750) / 750)
    end
end

-- 按比例适配 左上角
function UIAdapter.adUIRatioX( _posValue )
    if _posValue then
        return display.width * (math.min( _posValue, 1334)/ 1334)
    end
end

function UIAdapter.adUIRatioY(_posValue)
    if _posValue then
        return display.height * (750 - _posValue) / 750
    end
end