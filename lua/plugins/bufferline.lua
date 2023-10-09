-- See current buffers at the top of the editor
return {
	{
		"akinsho/bufferline.nvim",
		version = "v3.*",
		dependencies = "nvim-tree/nvim-web-devicons",
		opts = {},
		config = function()
			---@diagnostic disable-next-line: missing-fields
			require("bufferline").setup({
				---@diagnostic disable-next-line: missing-fields
				options = {
					mode = "tabs",
					separator_style = "thick",
					always_show_bufferline = false,
					show_buffer_close_icons = false,
					show_close_icon = false,
					color_icons = true,
				},
			})
		end,
	},
}
