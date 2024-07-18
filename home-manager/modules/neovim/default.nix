{ pkgs, ... }: let tsGrammars = (pkgs.vimPlugins.nvim-treesitter.withPlugins (p: [
    p.bash
    p.c
    p.comment
    p.cpp
    p.css
    p.dockerfile
    p.gitattributes
    p.gitignore
    p.go
    p.gomod
    p.gowork
    p.hcl
    p.html
    p.javascript
    p.jq
    p.json5
    p.json
    p.lua
    p.make
    p.markdown
    p.nix
    p.python
    p.query
    p.rust
    p.toml
    p.typescript
    p.vue
    p.yaml
]));
    treesitter-parsers = pkgs.symlinkJoin {
        name = "treesitter-parsers";
        paths = tsGrammars.dependencies;
    };
in {
    home.packages = with pkgs; [
        ripgrep
        fd
        lua-language-server
        rust-analyzer-unwrapped
        black
    ];

    programs.neovim = {
        enable = true;
        package = pkgs.neovim;
        viAlias = true;
        vimAlias = true;
        vimdiffAlias = true;
        coc.enable = false;
        withNodeJs = true;

        plugins = [
            tsGrammars
        ];
    };

    home.file."./.config/nvim" = {
        source = ./nvim;
        recursive = true;
    };

    home.file."./.config/nvim/init.lua".text = ''
        require("options")
        require("plugins")
        require("mappings")
        vim.opt.runtimepath:append("${treesitter-parsers}")
    '';

    home.file."./.local/share/nvim/nix/nvim-treesitter/" = {
        recursive = true;
        source = tsGrammars;
    };
}
