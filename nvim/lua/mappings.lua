require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- supprime l'ancien mapping nvim-tree
vim.keymap.del("n", "<leader>e")

-- remappe vers oil
vim.keymap.set("n", "<leader>e", "<cmd>Oil<cr>", { desc = "Open Oil" })

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
