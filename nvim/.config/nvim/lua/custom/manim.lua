local function manimr()
    local file = vim.cmd.f()

    local command = "manimr"

    local a = vim.fn.expand("%")
    command = command .. " " .. a

    print("\n")
    print(command)
    os.execute(command)
end

local function manim(flags)
    local file = vim.fn.expand("%:p")
    local path = vim.fn.expand("%:h")
    local command = '"manimr'
    local section = false
    local quality = 0
    for i = 1, #flags do
        command = command .. " " .. flags[i]
    end

    command = command .. " " .. file .. '"'

    -- local scene = vim.fn.input("Select your scene > ")
    --command = command .. " " .. scene .. '"'
    path = '"' .. path .. '"'

    local conf = "size=40, dir=" .. path .. ", " .. "cmd=" .. command
    --    local conf = "cmd=" .. command
    print(conf)
    vim.cmd.TermExec(conf)
end

vim.keymap.set("n", "<leader>mrl", function()
    manim({ "-l" })
end)

vim.keymap.set("n", "<leader>mrh", function()
    manim({ "-h" })
end)

vim.keymap.set("n", "<leader>mrs", function()
    manim({ "-s", "-l" })
end)
