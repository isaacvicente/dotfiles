return {
  "stevearc/conform.nvim",
  opts = function()
    return {
      format_on_save = function(bufnr)
        -- Get the diff hunks from gitsigns
        local gs = package.loaded.gitsigns
        if not gs then
          return { timeout_ms = 500, lsp_fallback = true }
        end

        local hunks = gs.get_hunks()
        if not hunks or vim.tbl_isempty(hunks) then
          return
        end

        -- Standard formatting for files with no hunks or errors
        local format_opts = { timeout_ms = 500, lsp_fallback = true }

        -- Build the range to format based on changed lines
        for _, hunk in ipairs(hunks) do
          format_opts.range = {
            ["start"] = { hunk.added.start, 0 },
            ["end"] = { hunk.added.start + hunk.added.count, 0 },
          }
          require("conform").format(format_opts)
        end
      end,
    }
  end,
}
