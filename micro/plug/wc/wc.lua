VERSION = "1.1.0"

local micro = import("micro")
local config = import("micro/config")
local util = import("micro/util")

function init()
    config.MakeCommand("wc", wordCount, config.NoComplete)
    config.AddRuntimeFile("wc", config.RTHelp, "help/wc.md")
    config.TryBindKey("F5", "lua:wc.wordCount", false)
end

function wordCount(bp)
    local buffer = util.String(bp.Buf:Bytes())
	charCount = buffer:len()
	local _ , wordCount = buffer:gsub("%S+","")
	micro.InfoBar():Message("Words:"..wordCount.."  Characters:"..charCount)
end
