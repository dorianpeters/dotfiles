local micro = import("micro")
local config = import("micro/config")
local shell = import("micro/shell")

local is_formatting = false

-- Format the current Python file using ruff
function formatPython(bp)
    local buf = bp.Buf
    if buf:FileType() ~= "python" then
        micro.InfoBar():Message("Not a Python file")
        return
    end

    if buf.Path == "" then
        micro.InfoBar():Error("Please save the file before formatting")
        return
    end

    if is_formatting then
        return
    end

    is_formatting = true

    if buf.Modified then
        buf:Save()
    end

    local handle = io.popen("ruff format -s " .. buf.Path .. " 2>&1")
    if handle then
        handle:close()
    end

    buf:ReOpen()
    is_formatting = false
    micro.InfoBar():Message("Formatted with ruff")
end

-- Automatically auto-format with ruff on save
function onSave(bp)
    local buf = bp.Buf
    if buf:FileType() == "python" and buf.Path ~= "" and not is_formatting then
        is_formatting = true
        local handle = io.popen("ruff format -s " .. buf.Path .. " 2>&1")
        if handle then
            handle:close()
        end
        buf:ReOpen()
        is_formatting = false
    end
    return true
end

-- Run current Python file interactively in terminal
function runpython(bp)
    local buf = bp.Buf
    if buf.Path == "" then
        micro.InfoBar():Error("Please save the file before running")
        return
    end

    if buf.Modified then
        buf:Save()
    end

    shell.RunInteractiveShell("python3 " .. buf.Path, true, false)
end

-- Run pytest on current file or directory
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

-- Run ty typechecker interactively
function runty(bp)
    local buf = bp.Buf
    if buf.Path == "" then
        micro.InfoBar():Error("Please save the file before checking")
        return
    end

    if buf.Modified then
        buf:Save()
    end

    shell.RunInteractiveShell("ty check " .. buf.Path, true, false)
end

function init()
    -- Register ty as the Python typechecker & linter in micro's built-in linter
    if _G.linter ~= nil and _G.linter.makeLinter ~= nil then
        _G.linter.removeLinter("pyflakes")
        _G.linter.removeLinter("mypy")
        _G.linter.removeLinter("pylint")
        _G.linter.removeLinter("flake8")
        _G.linter.makeLinter("ty", "python", "ty", {"check", "--output-format", "concise", "%f"}, "%f:%l:%c: %m")
    end

    -- Register editor commands
    config.MakeCommand("format", formatPython, config.NoComplete)
    config.MakeCommand("fmt", formatPython, config.NoComplete)
    config.MakeCommand("run", runpython, config.NoComplete)
    config.MakeCommand("python", runpython, config.NoComplete)
    config.MakeCommand("test", runpytest, config.NoComplete)
    config.MakeCommand("pytest", runpytest, config.NoComplete)
    config.MakeCommand("check", runty, config.NoComplete)
    config.MakeCommand("ty", runty, config.NoComplete)
end
