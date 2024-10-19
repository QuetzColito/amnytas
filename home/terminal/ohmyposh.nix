{
    # this is basically the setup from https://www.youtube.com/watch?v=9U8LCjuQzdc
    version = 2;
    final_space = true;
    console_title_template = "{{ .Shell }} in {{ .Folder }}";

    blocks = [
    {
        type = "prompt";
        alignment = "left";
        newline = true;

        segments = [
        {
            type = "path";
            style = "plain";
            background = "transparent";
            foreground = "cyan";
            template = "{{ .Path }}";

            properties = {
                style = "full";
            };

        }
        {
            type = "git";
            style = "plain";
            foreground = "green";
            background = "transparent";
            template = " {{ .HEAD }}{{ if or (.Working.Changed) (.Staging.Changed) }}*{{ end }} <cyan>{{ if gt .Behind 0 }}⇣{{ end }}{{ if gt .Ahead 0 }}⇡{{ end }}</>";

            properties= {
                commit_icon = "@";
                fetch_status = true;
            };
        }];
    }
    {
        type = "rprompt";
        overflow = "hidden";

        segments = [{
            type = "executiontime";
            style = "plain";
            foreground = "yellow";
            background = "transparent";
            template = "{{ .FormattedMs }}";

            properties = {
                threshold = 1000;
            };
        }];
    }
    {
        type = "prompt";
        alignment = "left";
        newline = true;

        segments = [{
            type = "text";
            style = "plain";
            foreground_templates = [
                "{{if gt .Code 0}}red{{end}}"
                "{{if eq .Code 0}}magenta{{end}}"
            ];
            background = "transparent";
            template = "❯";
        }];
    }];

    transient_prompt = {
        foreground_templates = [
            "{{if gt .Code 0}}red{{end}}"
            "{{if eq .Code 0}}magenta{{end}}"
        ];

        background = "transparent";
        template = "❯ ";
    };

    secondary_prompt = {
        foreground = "magenta";
        background = "transparent";
        template = "❯❯ ";
    };
}
