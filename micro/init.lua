local micro = import("micro")
local config = import("micro/config")
local shell = import("micro/shell")

-- Run the current Python file interactively in the terminal
function runpython(bp)
    local buf = bp.Buf
    if buf.Path == "" then
        micro.InfoBar():Error("Please save the file before running")
        return
    end

    if buf.Modified then
        buf:Save()
    end

    -- Run with python3 interactively so input() and stdout display properly
    shell.RunInteractiveShell("python3 " .. buf.Path, true, false)
end

-- Run pytest on the current file or directory
function runpytest(bp)
    local buf = bp.Buf
    if buf.Path == "" then
        micro.InfoBar():Error("Please save the file before running pytest")
        return
    end

    if buf.Modified then
        buf:Save()
    end

    shell.RunInteractiveShell("pytest " .. buf.Path, true, false)
end

function init()
    config.MakeCommand("run", runpython, config.NoComplete)
    config.MakeCommand("python", runpython, config.NoComplete)
    config.MakeCommand("test", runpytest, config.NoComplete)
    config.MakeCommand("pytest", runpytest, config.NoComplete)
end
