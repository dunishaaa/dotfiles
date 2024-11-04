local function manim(flags)
	local file = vim.fn.expand("%:p")
	local path = vim.fn.expand("%:h")
	local command = '"manimr'
	for i = 1, #flags do
		command = command .. " " .. flags[i]
	end

	command = command .. " " .. file .. '"'

	path = '"' .. path .. '"'

	local conf = "go_back=0 size=40 dir=" .. path .. " " .. "cmd=" .. command
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
