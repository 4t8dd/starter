-- since this is just an example spec, don't actually load anything here and return an empty spec
-- stylua: ignore
-- every spec file under the "plugins" directory will be loaded automatically by lazy.nvim
--
-- In your plugin files, you can:
-- * add extra plugins
-- * disable/enabled LazyVim plugins
-- * override the configuration of LazyVim plugins
return {
    {
        "4t8dd/neoai.nvim",
        dependencies = {
            "MunifTanjim/nui.nvim",
        },
        cmd = {
            "NeoAI",
            "NeoAIOpen",
            "NeoAIClose",
            "NeoAIToggle",
            "NeoAIContext",
            "NeoAIContextOpen",
            "NeoAIContextClose",
            "NeoAIInject",
            "NeoAIInjectCode",
            "NeoAIInjectContext",
            "NeoAIInjectContextCode",
        },
        keys = {
            { "<leader>as", desc = "summarize text" },
            { "<leader>ag", desc = "generate git message" },
        },
        config = function()
            require("neoai").setup({
                ui = {
                    output_popup_text = "NeoAI",
                    input_popup_text = "Prompt",
                    width = 30, -- As percentage eg. 30%
                    output_popup_height = 80, -- As percentage eg. 80%
                    submit = "<Enter>", -- Key binding to submit the prompt
                },
                models = {
                    {
                        name = "openai",
                        model = "gpt-3.5-turbo",
                        params = nil,
                    },
                },
                register_output = {
                    ["g"] = function(output)
                        return output
                    end,
                    ["c"] = require("neoai.utils").extract_code_snippets,
                },
                inject = {
                    cutoff_width = 75,
                },
                prompts = {
                    default_prompt = function()
                        return "Please only follow instructions or answer to questions. Be concise."
                    end,
                    context_prompt = function(context)
                        return "Please only follow instructions or answer to questions. Be concise. "
                            .. "I'd like to provide some context for future "
                            .. "messages. Here is the code/text that I want to refer "
                            .. "to in our upcoming conversations:\n\n"
                            .. context
                    end,
                },
                mappings = {
                    ["select_up"] = "<C-k>",
                    ["select_down"] = "<C-j>",
                },
                open_ai = {
                    api_key = {
                        env = "OPENAI_API_KEY",
                        value = "sk-mtAJgsFDvpsfpmst8f742bF1669746Bb845278C8Dc5b6fB2",
                    },
                    base_url = {
                        env = "OPENAI_BASE_URL",
                        value = "https://burn.hair/v1",
                    },
                },
                shortcuts = {
                    {
                        name = "textify",
                        key = "<leader>as",
                        desc = "fix text with AI",
                        use_context = true,
                        prompt = [[
                            Please rewrite the text to make it more readable, clear,
                            concise, and fix any grammatical, punctuation, or spelling
                            errors
                        ]],
                        modes = { "v" },
                        strip_function = nil,
                    },
                    {
                        name = "gitcommit",
                        key = "<leader>ag",
                        desc = "generate git commit message",
                        use_context = false,
                        prompt = function()
                            return [[
                                Using the following git diff generate a consise and
                                clear git commit message, with a short title summary
                                that is 75 characters or less:
                            ]] .. vim.fn.system("git diff --cached")
                        end,
                        modes = { "n" },
                        strip_function = nil,
                    },
                },
                })
        end
    },
    {
        '4t8dd/lsp-ai.nvim',
        opts = {
        autostart = true,
        server = {
            memory = {
            file_store = {},
            },
            models = {
            model1 =  {
                type="openai",
                chat_endpoint="https://burn.hair/v1/chat/completions",
                model = "gpt-4o",
                auth_token_env_var_name = "OPENAI_API_KEY",
            }
            }
        },
        generation = {
            model = "model1",
            parameters = {
            max_tokens=256,
            max_context=1024,
            messages = {
                {
                role="system",
                content="You are a programming completion tool. Replace <CURSOR> with the correct code."
                },
                {
                role = "user",
                content = "{CODE}"
                }
            }
            }
        }
        },
        dependencies = { 'neovim/nvim-lspconfig' },
    }
}
