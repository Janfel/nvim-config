-- Encryption Module (Test)
-- See: https://www.adrian.idv.hk/2022-05-07-nvim-lua/

local mod = {}

function mod.BufReadPre()
	vim.bo.binary = true
	vim.bo.swapfile = false
end

function mod.BufReadPost()
	vim.b.encrypt_mod_password = vim.fn.inputsecret("Password: ")
	-- Decrypt
	if "error" then
		-- bdelete/bwipeout/bunload
		-- throw something
	end
	vim.bo.binary = false
end

function mod.BufWritePre()
	vim.bo.binary = true
	-- Encrypt
end

function mod.BufWritePost()
	vim.cmd [[ silent! undo ]]
	vim.bo.binary = false
end

return mod
