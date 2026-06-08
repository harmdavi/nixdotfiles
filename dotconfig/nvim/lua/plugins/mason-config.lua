return{
{
    "mason-org/mason.nvim",
    config = function()
	    require("mason").setup({
--ensure_installed = {"texlab"}
	    })
    end
},


{
{
    "mason-org/mason-lspconfig.nvim",
    opts = {
ensure_installed = {
--	"lua_ls",
--	"texlab",
}
    },
    dependencies = {
        { "mason-org/mason.nvim", opts = {} },
        "neovim/nvim-lspconfig",
	config = function()
		require("mason-lspconfig").setup({
--ensure_installed = {"texlab"}
		})
	end
    },
},

}

}
