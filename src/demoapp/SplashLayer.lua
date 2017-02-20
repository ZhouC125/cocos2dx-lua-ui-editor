--
-- Created by IntelliJ IDEA.
-- User: Kunkka
-- Date: 17/2/18
-- Time: 下午2:52
-- To change this template use File | Settings | File Templates.
--

local SplashLayer = class("SplashLayer", gk.Layer)

function SplashLayer:ctor()
    SplashLayer.super.ctor(self)

    if gk.mode ~= gk.MODE_EDIT then
        self:runAction(cc.Sequence:create(cc.DelayTime:create(1.5), cc.CallFunc:create(function()
            gk.SceneManager:replace("MainLayer")
        end)))
    end
end

return SplashLayer