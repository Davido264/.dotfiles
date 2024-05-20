return {
  "williamboman/mason.nvim",
  event = { "BufReadPost", "BufNewFile", "BufWritePre" },
  cmd = { "Mason", "MasonInstall", "MasonInstallAll", "MasonUninstall", "MasonUninstallAll", "MasonLog" },
  config = true,
}
