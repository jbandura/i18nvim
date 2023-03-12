local function convert_file_path_to_name(filePath)
  return string.gsub(string.gsub(filePath, "/", "_"), ".yaml", ".json")
end

local function get_visual_selection()
  -- Yank current visual selection into the 'v' register
  --
  -- Note that this makes no effort to preserve this register
  vim.cmd('noau normal! "vy"')

  return vim.fn.getreg("v")
end

local function get_key_name()
  if vim.bo.filetype == "handlebars" then
    -- here's a problem
    --stylua: ignore
    vim.cmd('normal! vi\"')
  else
    vim.api.nvim_eval('execute(":silent normal! vi\'")')
  end
  local selection = get_visual_selection()

  print(selection)
  return selection
end

return {
  convert_file_path_to_name = convert_file_path_to_name,
  get_visual_selection = get_visual_selection,
  get_key_name = get_key_name,
}
