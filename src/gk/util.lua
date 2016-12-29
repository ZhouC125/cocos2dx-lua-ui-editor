--
-- Created by IntelliJ IDEA.
-- User: huangkun
-- Date: 16/12/29
-- Time: 上午10:12
-- To change this template use File | Settings | File Templates.

local util = {}

----------------------------------------- restart game  -------------------------------------------------
function util.registerRestartGameCallback(callback)
    if not util.restartLayer then
        gk.log("init.registerRestartGameCallback")
        util.restartLayer = cc.Layer:create()
        util.restartLayer:retain()

        local function onKeyReleased(keyCode, event)
            gk.log("RestartLayer: onKeypad %d", keyCode)
            if keyCode == 141 then
                util:restartGame(callback)
            end
        end

        local listener = cc.EventListenerKeyboard:create()
        listener:registerScriptHandler(onKeyReleased, cc.Handler.EVENT_KEYBOARD_RELEASED)
        cc.Director:getInstance():getEventDispatcher():addEventListenerWithSceneGraphPriority(listener, util.restartLayer)
        util.restartLayer:resume()
    end
end

function util:restartGame(callback)
    gk.log("===================================================================")
    gk.log("=====================    restart game    ==========================")
    gk.log("===================================================================")
    if util.restartLayer then
        util.restartLayer:release()
        util.restartLayer = nil
    end

    local scene = cc.Scene:create()
    cc.Director:getInstance():popToRootScene()
    cc.Director:getInstance():replaceScene(scene)
    scene:runAction(cc.CallFunc:create(function()
        if cc.Application:getInstance():getTargetPlatform() ~= cc.PLATFORM_OS_MAC then
            gk.log("removeResBeforeRestartGame")
            cc.Director:getInstance():purgeCachedData()
            gk.log("collect: lua mem -> %.2fMB", collectgarbage("count") / 1024)
            collectgarbage("collect")
            gk.log("after collect: lua mem -> %.2fMB", collectgarbage("count") / 1024)
        end
        if callback then
            callback()
        end
    end))
end

function util:drawNodeRect(node, c4f, drawNode)
    local draw
    if drawNode then
        draw = drawNode
    else
        draw = cc.DrawNode:create()
        node:add(draw, 999)
        draw:setPosition(cc.p(0, 0))
    end

    local size = node:getContentSize()
    -- bounds
    draw:drawRect(cc.p(0, 0),
        cc.p(0, size.height),
        cc.p(size.width, size.height),
        cc.p(size.width, 0), c4f and c4f or cc.c4f(1, 1, 0, 0.5))

    -- anchor point
    local p = node:getAnchorPoint()
    p.x = p.x * size.width
    p.y = p.y * size.height
    draw:drawDot(p, 4, cc.c4f(1, 0, 0, 1))

    -- draw text size
    if tolua.type(node) == "cc.Label" then
        local fontSize = node:getTTFConfig().fontFilePath ~= "" and node:getTTFConfig().fontSize or 0
        if fontSize <= 0 then
            -- 中文
            fontSize = node:getBMFontSize() / 0.839
        end
        if fontSize > 0 then
            local lb = cc.Label:createWithSystemFont(string.format("%d", fontSize), "Arial", 15)
            lb:enableUnderline()
            local child = node:getChildByTag(-2)
            if child then
                child:removeFromParent()
            end
            node:addChild(lb, 9999, -2)
            lb:setPosition(size.width, size.height)
        end
    end

    -- refresh draw, only in test mode
    if DEBUG then
        draw:stopAllActions()
        draw:runAction(cc.Sequence:create(cc.DelayTime:create(1), cc.CallFunc:create(function()
            draw:clear()
            debug:drawNodeRect(node, c4f, draw)
        end)))
    end
    return draw
end

return util