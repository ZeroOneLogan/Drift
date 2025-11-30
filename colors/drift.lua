for k in pairs(package.loaded) do
  if k:match(".*drift.*") then
    package.loaded[k] = nil
  end
end

require("drift").setup()
require("drift").colorscheme()
