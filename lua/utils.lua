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
  vim.api.nvim_eval('execute(":silent normal! vi\'")')
  return get_visual_selection()
end

return {
  convert_file_path_to_name = convert_file_path_to_name,
  get_visual_selection = get_visual_selection,
  get_key_name = get_key_name,
}
