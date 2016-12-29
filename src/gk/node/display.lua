local display = {}

function display.initWithDesignSize(size)
    local winSize = cc.Director:getInstance():getWinSize()
    display.winSize = cc.size(winSize.width * 3 / 4, winSize.height)
    display.width = size.width
    display.height = size.height
    display.xScale = display.winSize.width / display.width
    display.yScale = display.winSize.height / display.height
    display.minScale = math.min(display.xScale, display.yScale)
    display.maxScale = math.max(display.xScale, display.yScale)
    display.scaleMin = function(pos, posY)
        local y = posY and posY or pos.y
        local x = posY and pos or pos.x
        local p = cc.p(display.minScale * x, display.minScale * y)
        return p
    end
    display.scaleXY = function(pos, posY)
        local y = posY and posY or pos.y
        local x = posY and pos or pos.x
        local p = cc.p(display.xScale * x, display.yScale * y)
        return p
    end
    gk.log("display.init designSize(%.1f,%.1f), winSize(%.1f,%.1f), xScale(%.1f), yScale(%.1f), minScale(%.1f), maxScale(%.1f)",
        size.width, size.height, display.winSize.width, display.winSize.height,
        display.xScale, display.yScale, display.minScale, display.maxScale)
end

function display.addEditorPanel(scene)
    gk.log("display.addEditorPanel")
    local panel = require("gk.editor.panel")
    scene:addChild(panel:create(), 9999999)
end

return display