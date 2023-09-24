return {
  "alexghergh/nvim-tmux-navigation",
  event = "VeryLazy",
  config = function()
    local nvim_tmux = require("nvim-tmux-navigation")
    nvim_tmux.setup({
      disable_when_zoomed = true,
      keybindings = {
        left = "<C-Left>",
        down = "<C-Down>",
        up = "<C-Up>",
        right = "<C-Right>",
      },
    })
  end,
}
