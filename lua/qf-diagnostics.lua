local M = {}

function M.setup()
    local namespace = vim.api.nvim_create_namespace('quickfix')
    local function handle_diagnostics()
        local qflist = vim.fn.getqflist()
        for _, item in ipairs(qflist) do
            -- Sometimes the type of a qflist item is in lower case,
            -- but the severity table only accepts a type in upper case
            item.type = string.upper(item.type)
        end

        local by_bufnr = {}
        local diagnostics = vim.diagnostic.fromqflist(qflist)
        for _, d in ipairs(diagnostics) do
            if d.bufnr then
                by_bufnr[d.bufnr] = by_bufnr[d.bufnr] or {}
                table.insert(by_bufnr[d.bufnr], d)
            end
        end

        local old_diagnostics = vim.diagnostic.get(nil, { namespace = namespace })
        for _, d in ipairs(old_diagnostics) do
            by_bufnr[d.bufnr] = by_bufnr[d.bufnr] or {}
        end

        for i, d in pairs(by_bufnr) do
            vim.diagnostic.set(namespace, i, d)
        end
    end

    vim.api.nvim_create_autocmd({"QuickfixCmdPost"}, {
        pattern = {"make"},
        callback = handle_diagnostics,
    })

    vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
        pattern = {"*"},
        callback = handle_diagnostics,
    })
end

return M
