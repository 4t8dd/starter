-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local Util = require("lazyvim.util")
local map = Util.safe_keymap_set

if Util.has("bufferline.nvim") then
  map("n", "<leader>p", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev buffer" })
  map("n", "<leader>n", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer" })
  map("n", "[b", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev buffer" })
  map("n", "]b", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer" })
else
  map("n", "<leader>p", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
  map("n", "<leaer>n", "<cmd>bnext<cr>", { desc = "Next buffer" })
  map("n", "[b", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
  map("n", "]b", "<cmd>bnext<cr>", { desc = "Next buffer" })
end

if Util.has("neoai.nvim") then
  map("n", "<leader>aa", "<cmd>NeoAIToggle<cr>", { desc = "enable NeoAI" })
  map("n", "<leader>ai", "<cmd>NeoAIInject<cr>", { desc = "inject the result from AI" })
  map("n", "<leader>af", "<cmd>NeoAIContext<cr>", { desc = "ask AI with context" })
  map("n", "<leader>ad", "<cmd>NeoAIInjectCode<cr>", { desc = "inject code" })
  map("n", "<leader>ac", "<cmd>NeoAIInjectContext<cr>", { desc = "inject context" })
end
