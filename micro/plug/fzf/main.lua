VERSION = "1.1.1"

local micro = import("micro")
local shell = import("micro/shell")
local config = import("micro/config")
local buffer = import("micro/buffer")

function fzf(bp)
    if shell.TermEmuSupported then
        local err = shell.RunTermEmulator(bp, "fzf", false, true, fzfOutput, {bp})
        if err ~= nil then
            micro.InfoBar():Error(err)
        end
    else
        local output, err = shell.RunInteractiveShell("fzf", false, true)
        if err ~= nil then
            micro.InfoBar():Error(err)
        else
            fzfOutput(output, {bp})
        end
    end
end

function fzfOutput(output, args)
    local bp = args[1]
    local strings = import("strings")
    output = strings.TrimSpace(output)
    if output ~= "" then
        local buf, err = buffer.NewBufferFromFile(output)
        if err == nil then
            bp:OpenBuffer(buf)
        end
    end
end

function init()
    config.MakeCommand("fzf", fzf, config.NoComplete)
end
