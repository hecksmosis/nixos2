{
  programs.nixvim.plugins.telescope = {
    enable = true;

    keymaps = {
      "<leader>ff" = "find_files";
      "<leader>fa" = "find_files follow=true no_ignore=true hidden=true";
      "<leader>b" = "buffers";
      "<leader>fh" = "help_tags";
      "<leader>gf" = "git_files";
      "<leader>of" = "oldfiles";
      "<leader>fg" = "live_grep";
      "<leader>fd" = "diagnostics";
      "<leader>fz" = "current_buffer_fuzzy_find";
      "<leader>cm" = "git_commits";
      "<leader>gt" = "git_status";
      "<leader>pt" = "terms";
      "<leader>ma" = "marks";
    };

    settings.defaults = {
      file_ignore_patterns = [
        "^.git/"
        "^.mypy_cache/"
        "^__pycache__/"
        "^output/"
        "^data/"
        "%.ipynb"
      ];
      set_env.COLORTERM = "truecolor";
    };
  };
}
