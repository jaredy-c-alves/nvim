local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
		vim.cmd [[packadd packer.nvim]]
		return true
	end
	return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
	use 'wbthomason/packer.nvim'

	use '42Paris/42header'

	use {
		"windwp/nvim-autopairs",
		config = function() require("nvim-autopairs").setup { map_cr = true } end
	}
	use {
		'nvim-treesitter/nvim-treesitter',
		run = function() require('nvim-treesitter.install').update({ with_sync = true }) end,
	}

	use 'neovim/nvim-lspconfig'
	use 'ms-jpq/coq_nvim'
	use 'ms-jpq/coq.artifacts'
	use 'ms-jpq/coq.thirdparty'

	use 'doums/darcula'

	if packer_bootstrap then
		require('packer').sync()
	end
end)
