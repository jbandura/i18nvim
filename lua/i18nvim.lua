local json = require("json")
local popup = require("plenary.popup")
local utils = require("utils")

local cacheDir = os.getenv("HOME") .. "/.cache/i18nvim/"
local tmpPath = cacheDir .. "tmp/"
local api = vim.api
local localeFileName = "en-us.yaml"
local translationTableFilePath = cacheDir .. "table.json"

local function convert_to_json_store_in_tmp(pathToFile)
  os.execute("mkdir -p " .. tmpPath)
  local tmpFilePath = tmpPath .. utils.convert_file_path_to_name(pathToFile)
  os.execute("yq -o=json " .. pathToFile .. " > " .. tmpFilePath)
end

local function clear_tmp_folder()
  os.execute("rm -rf " .. tmpPath)
end

local function build_cache()
  print("Building translation cache...")

  local result = vim.fn.systemlist("ack -f | ack /" .. localeFileName)
  local lookup_table = {}
  for _, filePath in ipairs(result) do
    -- convert file to json, store in tmp
    convert_to_json_store_in_tmp(filePath)
    local translationFile = io.open(tmpPath .. utils.convert_file_path_to_name(filePath), "r")
    io.input(translationFile)
    local translations = translationFile:read("*all")
    io.close(translationFile)
    local decoded_json = json.decode(translations)

    if type(decoded_json) == "table" then
      for translationKey, translationText in pairs(decoded_json) do
        lookup_table[translationKey] = { text = translationText, file = filePath }
      end
    end
  end

  local file = io.open(translationTableFilePath, "w")
  local encodedTable = json.encode(lookup_table)
  file:write(encodedTable)
  io.close(file)

  clear_tmp_folder()
  print("Translation cache built successfully!")
  return lookup_table
end

local function load_translation_files()
  local readFile = io.open(translationTableFilePath, "r")

  if readFile then
    io.input(readFile)
    local cache = readFile:read("*all")
    io.close(readFile)

    if cache then
      return json.decode(cache)
    end
  end

  return build_cache()
end

local function go_to_definition()
  local lookup_table = load_translation_files()
  local key_name = utils.get_key_name()
  local translation = lookup_table[key_name]
  vim.cmd("e " .. translation.file)
  vim.cmd("ij " .. key_name)
end

local function find_usages()
end

local function show()
  local lookup_table = load_translation_files()
  local translation = lookup_table[utils.get_key_name()]
  local currentWindow = api.nvim_get_current_win()

  if translation then
    local win_id = popup.create({ translation.text }, {})
    api.nvim_set_current_win(currentWindow)
    api.nvim_create_augroup("TranslationPopup", {})
    api.nvim_create_autocmd("CursorMoved", {
      group = "TranslationPopup",
      nested = true,
      once = true,
      callback = function()
        api.nvim_win_close(win_id, false)
      end,
    })
    return
  end
  print("Translation for " .. currentWord .. " does not exist!")
end

return {
  show = show,
  build_cache = build_cache,
  go_to_definition = go_to_definition,
  find_usages = find_usages,
}
