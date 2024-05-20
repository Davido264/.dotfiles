local M = {}

function M.check_required(notifyfn)
  -- local installed =  require("mason-registry").get_package("java-debug-adapter"):is_installed()
  -- if not installed then
  --   notifyfn "java-debug-adapter"
  -- end
  -- return installed
  return true
end

function M.setup()
  require("jdtls").setup_dap()

  if vim.fn.has "win32" == 1 then
    require("dap").configurations.java = {
      javaExec = os.getenv "JAVA_HOME" .. "/bin/javaw.exe",
    }
  end
end

return M
