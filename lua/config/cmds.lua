vim.api.nvim_create_user_command("Push", function()
  vim.fn.jobstart("git add . && git commit -m update && git push", {
    on_stdout = function(_, data)
      if data then
        print(table.concat(data, '\n'))
      end
    end,
    on_stderr = function(_, data)
      if data then
        print(table.concat(data, '\n'))
      end
    end
  })
end, {})

