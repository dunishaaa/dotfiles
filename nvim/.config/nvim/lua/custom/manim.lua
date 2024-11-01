local function manimr()
	local file = vim.cmd.f()

	local command = "manimr"

	command = command .. " -l"

	local a = vim.fn.expand("%")
	command = command .. " " .. a

	local scene = vim.fn.input("Select your scene > ")
	command = command .. " " .. scene

	print("\n")
	print(command)
	os.execute(command)
end

vim.keymap.set("n", "<leader>mr", manimr)
