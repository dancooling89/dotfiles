local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
		vim.cmd([[packadd packer.nvim]])
		return true
	end
	return false
end

local packer_boostrap = ensure_packer()

vim.cmd([[
	augroup packer_user_config
		autocmd!
		autocmd BufWritePost plugins.lua source <afile> | PackerSync
	augroup end
]])

require("packer").startup({
	function(use)
		use("wbthomason/packer.nvim")

		use({
			"rmagatti/auto-session",
			config = function()
				require("auto-session").setup({
					auto_save_enabled = true,
					auto_restore_enabled = true,
					auto_session_use_git_branch = true,
				})
			end,
		})

		use({
			"nvim-lualine/lualine.nvim",
			requires = { "nvim-tree/nvim-web-devicons", opt = true },
			config = function()
				local lualine = require("lualine")
				lualine.setup({
					sections = {
						lualine_c = { require("auto-session-library").current_session_name },
					},
				})
			end,
		})

		use({
			"alexghergh/nvim-tmux-navigation",
			config = function()
				local nvim_tmux_nav = require("nvim-tmux-navigation")

				nvim_tmux_nav.setup({
					disable_when_zoomed = true,
				})

				vim.keymap.set("n", "<C-Left>", nvim_tmux_nav.NvimTmuxNavigateLeft)
				vim.keymap.set("n", "<C-Right>", nvim_tmux_nav.NvimTmuxNavigateRight)
				vim.keymap.set("n", "<C-Up>", nvim_tmux_nav.NvimTmuxNavigateUp)
				vim.keymap.set("n", "<C-Down>", nvim_tmux_nav.NvimTmuxNavigateDown)
				vim.keymap.set("n", "<C-\\>", nvim_tmux_nav.NvimTmuxNavigateLastActive)
				vim.keymap.set("n", "<C-Space>", nvim_tmux_nav.NvimTmuxNavigateNext)
			end,
		})

		use({
			"kevinhwang91/rnvimr",
			config = function()
				vim.g.rnvimr_ex_enable = 1
				vim.g.rnvimr_enable_picker = 1
			end,
		})

		use({
			"ellisonleao/gruvbox.nvim",
			config = function()
				vim.o.background = "dark"
				vim.cmd([[colorscheme gruvbox]])
			end,
		})

		use({
			"ggandor/leap.nvim",
			config = function()
				require("leap").add_default_mappings()
			end,
		})

		use({
			"nvim-treesitter/nvim-treesitter",
			run = function()
				local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
				ts_update()
			end,
			config = function()
				require("nvim-treesitter.configs").setup({
					ensure_installed = "all",
					auto_install = true,
					highlight = {
						enable = true,
					},
					incremental_selection = {
						enable = true,
					},
					indent = {
						enable = true,
					},
				})
			end,
		})

		use({
			"VonHeikemen/lsp-zero.nvim",
			requires = {
				-- LSP Support
				{ "neovim/nvim-lspconfig" },
				{ "williamboman/mason.nvim" },
				{ "williamboman/mason-lspconfig.nvim" },

				-- Autocompletion
				{ "hrsh7th/nvim-cmp" },
				{ "hrsh7th/cmp-buffer" },
				{ "hrsh7th/cmp-path" },
				{ "saadparwaiz1/cmp_luasnip" },
				{ "hrsh7th/cmp-nvim-lsp" },
				{ "hrsh7th/cmp-nvim-lua" },

				-- Snippets
				{ "L3MON4D3/LuaSnip" },
				{ "rafamadriz/friendly-snippets" },
			},
			config = function()
				require("mason").setup()
			end,
		})

		use({
			"puremourning/vimspector",
			config = function()
				vim.g.vimspector_enable_mappings = "VISUAL_STUDIO"
			end,
		})

		use({
			"jayp0521/mason-null-ls.nvim",
			requires = {
				{ "williamboman/mason.nvim" },
				{ "jose-elias-alvarez/null-ls.nvim" },
				{ "nvim-lua/plenary.nvim" },
			},
			config = function()
				local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

				require("null-ls").setup({
					on_attach = function(client, bufnr)
						if client.supports_method("textDocument/formatting") then
							vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
							vim.api.nvim_create_autocmd("BufWritePost", {
								group = augroup,
								buffer = bufnr,
								callback = function()
									vim.lsp.buf.format({ bufnr = bufnr })
								end,
							})
						end
					end,
				})

				require("mason-null-ls").setup({
					automatic_installation = true,
					automatic_setup = true,
				})

				require("mason-null-ls").setup_handlers()
			end,
		})

		use({
			"nvim-telescope/telescope.nvim",
			tag = "0.1.0",
			requires = { { "nvim-lua/plenary.nvim" } },
		})

		use({
			"folke/which-key.nvim",
			config = function()
				local wk = require("which-key")
				wk.setup({})

				local mappings = {
					f = {
						name = "file",
						f = { "<cmd>Telescope find_files<cr>", "Find file" },
						r = { "<cmd>Telescope oldfiles<cr>", "Recent file" },
						s = { "<cmd>Telescope live_grep<cr>", "Search" },
						b = { "<cmd>Telescope buffers<cr>", "Buffers" },
						e = { "<cmd>RnvimrToggle<cr>", "Explorer" },
						h = { "<cmd>Telescope help_tags<cr>", "Help tags" },
					},
					d = {
						name = "diagnostics",
						e = { "<cmd>TroubleToggle<cr>", "Errors/warnings toggle" },
						o = { "<cmd>AerialToggle right<cr>", "Outline" },
					},
				}

				wk.register(mappings, { prefix = "<leader>" })
			end,
		})

		use({
			"folke/trouble.nvim",
			requires = "nvim-tree/nvim-web-devicons",
			config = function()
				require("trouble").setup({
					icons = false,
				})
			end,
		})

		use({
			"ray-x/lsp_signature.nvim",
			config = function()
				require("lsp_signature").setup({})
			end,
		})

		use({
			"stevearc/aerial.nvim",
			config = function()
				require('aerial').setup()
			end,
		})

		if packer_bootstrap then
			require("packer").sync()
		end
	end,
	config = {
		display = {
			open_fn = require("packer.util").float,
		},
	},
})

local lsp = require("lsp-zero")
lsp.preset("recommended")
lsp.ensure_installed({
	"sumneko_lua",
	"omnisharp",
	"eslint",
})
lsp.set_preferences({
	suggest_lsp_servers = true,
	setup_servers_on_start = true,
	set_lsp_keymaps = true,
})
lsp.nvim_workspace()
lsp.setup()
