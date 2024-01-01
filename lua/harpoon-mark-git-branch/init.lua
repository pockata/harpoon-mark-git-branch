local harpoon = require("harpoon")
local Job = require("plenary.job")

local M = {}

local function get_os_command_output(cmd, cwd)
	if type(cmd) ~= "table" then
		print("Harpoon: [get_os_command_output]: cmd has to be a table")
		return {}
	end
	local command = table.remove(cmd, 1)
	local stderr = {}
	local stdout, ret = Job
		:new({
			command = command,
			args = cmd,
			cwd = cwd,
			on_stderr = function(_, data)
				table.insert(stderr, data)
			end,
		})
		:sync()
	return stdout, ret, stderr
end

local function get_key()
	local branch
	local proj = vim.uv.cwd()

	-- use tpope's fugitive for faster branch name resolution if available
	if vim.fn.exists("*FugitiveHead") == 1 then
		branch = vim.fn["FugitiveHead"]()
		-- return "HEAD" for parity with `git rev-parse` in detached head state
		if #branch == 0 then
			branch = "HEAD"
		end
	else
		-- `git branch --show-current` requires Git v2.22.0+ so going with more
		-- widely available command
		branch = get_os_command_output({
			"git",
			"rev-parse",
			"--abbrev-ref",
			"HEAD",
		})[1]
	end

	if branch then
		return proj .. "-" .. branch
	else
		return proj
	end
end

function M.setup()
	-- SETUP_CALLED already fired so we have to edit settings directly
	harpoon.config.settings.key = get_key
end

return M
