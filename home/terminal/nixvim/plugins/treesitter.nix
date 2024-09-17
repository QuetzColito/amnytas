{
    programs.nixvim.plugins = {
        treesitter = {
            enable = true;

            nixvimInjections = true;

            settings = {
            highlight.enable = true;
            indent.enable = true;
            };
        };

        treesitter-refactor = {
            enable = true;
            highlightDefinitions = {
                enable = true;
                clearOnCursorMove = false;
            };
        };

        hmts.enable = true;
    };
}
