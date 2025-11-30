-- =============================================================================
-- DRIFT COLORSCHEME
-- Load this file with :colorscheme drift
-- =============================================================================

-- Clear module cache for hot-reload during development
for k in pairs(package.loaded) do
  if k:match(".*drift.*") then
    package.loaded[k] = nil
  end
end

-- Load drift module
local drift = require("drift")

-- Initialize with existing config or defaults
if not vim.g.drift_config then
  drift.setup()
end

-- Apply the colorscheme
drift.colorscheme()
