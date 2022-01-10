lua << EOF
lspconfig.arduino_language_server.setup({
        cmd =  {
                -- Required
                "/home/kali/go/bin/arduino-language-server",
                "-cli-config", "/home/kali/.arduino15/arduino-cli.yaml",
                -- Optional
                "-cli", "/home/kali/local/bin/arduino-cli",
                "-clangd", "/bin/clangd"
        }
})


require'lspconfig'.arduino_language_server.setup{}
  Commands:
  
    Default Values:
      cmd = { "arduino-language-server" }
      filetypes = { "arduino" }
                                root_dir = function(startpath)
          return M.search_ancestors(startpath, matcher)
        end
EOF
