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

let &cpo = s:save_cpo
unlet s:save_cpo

let g:loaded_i18nvim = 1

