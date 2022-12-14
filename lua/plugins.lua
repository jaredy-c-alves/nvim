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
	-- Packer
	use 'wbthomason/packer.nvim'

	-- 42
	use '42Paris/42header'

	-- LSP
	use 'neovim/nvim-lspconfig'
	use { 'ms-jpq/coq_nvim', run = 'python3 -m coq deps' }
	use 'ms-jpq/coq.artifacts'
	use 'ms-jpq/coq.thirdparty'

	-- Colorscheme
	use 'folke/tokyonight.nvim'

	-- Tools
	use {
		"windwp/nvim-autopairs",
		config = function() require("nvim-autopairs").setup { map_cr = true } end
	}
	use {
		'nvim-treesitter/nvim-treesitter',
		run = function() require('nvim-treesitter.install').update({ with_sync = true }) end,
	}
	use {
		'nvim-telescope/telescope.nvim',
		requires = { 'nvim-lua/plenary.nvim' }
	}

	if packer_bootstrap then
		require('packer').sync()
	end
end)
