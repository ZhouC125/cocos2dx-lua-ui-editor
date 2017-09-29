--
-- Created by IntelliJ IDEA.
-- User: Kunkka
-- Date: 7/31/17
-- Time: 14:04
-- To change this template use File | Settings | File Templates.
--

local hotUpdate = {}

-- cannot be hot updated
-- must init this in main.lua before require any other modules
function hotUpdate:init(originVersion)
    local DOC_ROOT = cc.FileUtils:getInstance():getWritablePath()

    local curVersion = cc.UserDefault:getInstance():getStringForKey("gk_curVersion")
    if curVersion == "" then
        curVersion = originVersion
    end
    local ret = self:compairVersion(curVersion, originVersion)
    if ret == 1 then
        -- current is new, hot update exist
        print(string.format("curVersion = %s is big than originVersion = %s, use hot update", curVersion, originVersion))
        if not cc.FileUtils:getInstance():isDirectoryExist(DOC_ROOT .. curVersion .. "/") then
            print(string.format("hot update dir not exist = %s, need redownload hotupdate", DOC_ROOT .. curVersion .. "/"))
            cc.UserDefault:getInstance():setStringForKey("gk_curVersion", originVersion)
            cc.UserDefault:getInstance():flush()
        else
            -- hot update search path
            cc.FileUtils:getInstance():setSearchPaths({})
            cc.FileUtils:getInstance():addSearchPath(DOC_ROOT .. curVersion .. "/src/")
            cc.FileUtils:getInstance():addSearchPath(DOC_ROOT .. curVersion .. "/res/")
            cc.FileUtils:getInstance():addSearchPath("src/")
            cc.FileUtils:getInstance():addSearchPath("res/")
        end
    elseif ret == -1 then
        -- big version, remove old files
        print(string.format("big version = %s, remove old version = %s", originVersion, curVersion))
        self:removeOldVersion(curVersion)
        curVersion = originVersion
        cc.UserDefault:getInstance():setStringForKey("gk_curVersion", curVersion)
        cc.UserDefault:getInstance():flush()
    else
        -- equal, do nothing
        curVersion = originVersion
        print(string.format("same version = %s, no hotupdate", curVersion))
        cc.UserDefault:getInstance():setStringForKey("gk_curVersion", curVersion)
        cc.UserDefault:getInstance():flush()
    end

    return DOC_ROOT
end

-- return 1:version1 > version2
-- return 0:version1 == version2
-- return -1:version1 < version2
function hotUpdate:compairVersion(version1, version2)
    if version1 == version2 then
        return 0
    end
    local function split(input, delimiter)
        input = tostring(input)
        delimiter = tostring(delimiter)
        if (delimiter == '') then return false end
        local pos, arr = 0, {}
        -- for each divider found
        for st, sp in function() return string.find(input, delimiter, pos, true) end do
            table.insert(arr, string.sub(input, pos, st - 1))
            pos = sp + 1
        end
        table.insert(arr, string.sub(input, pos))
        return arr
    end

    local v1 = split(version1, ".")
    local v2 = split(version2, ".")
    local len = math.min(#v1, #v2)
    for i = 1, len do
        if tonumber(v1[i]) > tonumber(v2[i]) then
            return 1
        elseif tonumber(v1[i]) < tonumber(v2[i]) then
            return -1
        end
    end
    if #v1 == #v2 then
        return 0
    else
        return #v1 > #v2 and 1 or -1
    end
end

function hotUpdate:removeOldVersion(oldVersion)
    if oldVersion ~= "" then
        local DOC_ROOT = cc.FileUtils:getInstance():getWritablePath()
        local dir = DOC_ROOT .. oldVersion .. "/"
        print("removeOldVersion = " .. dir)
        cc.FileUtils:getInstance():removeDirectory(dir)
    end
end

function hotUpdate:updateToNewVersion(newVersion)
    print(string.format("update newVersion = %s", newVersion))
    cc.UserDefault:getInstance():setStringForKey("gk_curVersion", newVersion)
    cc.UserDefault:getInstance():flush()
    local DOC_ROOT = cc.FileUtils:getInstance():getWritablePath()
    cc.FileUtils:getInstance():setSearchPaths({})
    cc.FileUtils:getInstance():addSearchPath(DOC_ROOT .. newVersion .. "/src/")
    cc.FileUtils:getInstance():addSearchPath(DOC_ROOT .. newVersion .. "/res/")
    cc.FileUtils:getInstance():addSearchPath("src/")
    cc.FileUtils:getInstance():addSearchPath("res/")
end

function hotUpdate:reset()
    print(string.format("hotUpdate reset"))
    cc.UserDefault:getInstance():setStringForKey("gk_curVersion", "")
    cc.UserDefault:getInstance():flush()
    cc.FileUtils:getInstance():setSearchPaths({})
    cc.FileUtils:getInstance():addSearchPath("src/")
    cc.FileUtils:getInstance():addSearchPath("res/")
end

return hotUpdate