{
  ...
} : {
    programs.nixvim = {
        plugins.mini = {
            enable = true;
            modules = {
                ai = {};
                # animate = {
                #     cursor.enable = false;
                # };
                indentscope = {
                    draw.animation__raw = "MiniIndentscope.gen_animation.none()";
                };
                splitjoin = {};
                pairs = {};
                surround = {};
                operators = {};
            };
        };
    };
}
