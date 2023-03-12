let s:save_cpo = &cpo
set cpo&vim

fun! I18nvimShowTranslation()
  lua for k in pairs(package.loaded) do if k:match("^i18nvim") then package.loaded[k] = nil end end
  lua require('i18nvim').show()
endfun

function! I18nvimBuildCache()
  lua for k in pairs(package.loaded) do if k:match("^i18nvim") then package.loaded[k] = nil end end
  lua require('i18nvim').build_cache()
endfunction

function! I18nvimGoToDefinition()
  lua for k in pairs(package.loaded) do if k:match("^i18nvim") then package.loaded[k] = nil end end
  lua require('i18nvim').go_to_definition()
endfunction

function! I18nvimShowUsages()
  lua for k in pairs(package.loaded) do if k:match("^i18nvim") then package.loaded[k] = nil end end
  lua require('i18nvim').show_usages()
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo

let g:loaded_i18nvim = 1

