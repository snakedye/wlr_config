VERSION = "1.0.0"

local config = import("micro/config")

-- TODO: auto-indent when {} are used?

local quotePairs = {{"\"", "\""}, {"'","'"}, {"`","`"}, {"(",")"}, {"{","}"}, {"[","]"}}

function init()
	config.RegisterCommonOption("quoter", "enable", true)
	config.AddRuntimeFile("quoter", config.RTHelp, "help/quoter.md")
end

function preRune(bp, r)
	if bp.Buf.Settings["quoter.enable"] == false  then
		return true
	end
	if bp.Cursor:HasSelection() == false then		
		return true
	end
	for i = 1, #quotePairs do
		if r == quotePairs[i][1] or r == quotePairs[i][2] then
			quote(bp, quotePairs[i][1], quotePairs[i][2])
			return false
		end
	end
end

function quote(bp, open, close)
	bp.Buf:Insert(-bp.Cursor.CurSelection[1], open)
	bp.Buf:Insert(-bp.Cursor.CurSelection[2], close)
	bp.Cursor.CurSelection[2].X = bp.Cursor.CurSelection[2].X -1
end