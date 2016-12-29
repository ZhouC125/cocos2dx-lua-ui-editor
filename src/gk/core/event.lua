local event = {}

function event:init()
    self._listeners = {}
end

function event:subscribe(target, eventName, callback)
    local listeners = self._listeners[eventName]
    if not listeners then
        listeners = { { tg = target, cb = callback, valid = true } }
        self._listeners[eventName] = listeners
    else
        table.insert(listeners, { tg = target, cb = callback, valid = true })
    end
end

function event:unsubscribe(target, eventName)
    local listeners = self._listeners[eventName]
    if listeners and #listeners > 0 then
        for _, l in ipairs(listeners) do
            if l.tg == target then
                l.valid = false
            end
        end
    end
end

function event:post(eventName, args)
    local listeners = self._listeners[eventName]
    if listeners and #listeners > 0 then
        for _, l in ipairs(listeners) do
            if l.valid and l.cb then
                l.cb(args)
            end
        end
    else
        gk.log("event:post(%s), no target to receive event!", eventName)
    end
end

return event