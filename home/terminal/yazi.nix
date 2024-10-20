{
  config,
  lib,
  ...
} : {
    # not 100% happy with the config, but it mostly works for me
    # and didnt really have the motivation to deep dive into this
    programs.yazi = {
        enable = true;

        plugins = {
        # TODO: use fetchFromGitHub
            compress = ./compress.yazi;
        };

        settings = {
            manager = {
                sort_by = "alphabetical";
                sort_sensitive = false;
                sort_dir_first = true;
                linemode = "size";
                scrolloff = 10;
            };

            opener = {
                edit = [ {run = ''nvim "$@"'';block = true;desc = "Edit";}];
                play-once = [{run = ''vlc --play-and-exit "$@"'';}];
                play = [ {run = ''vlc --play-and-pause "$@"''; desc = "Play";}];
                view = [ {run = ''imvs "$@"''; desc = "view";}];
                open = [ { run = ''xdg-open "$@"''; desc = "Open";}];
                unzip = [ { run = ''unar "$@"''; desc = "Unzip";}];
                opendoc = [ { run = ''DesktopEditors $(realpath "$@")''; desc = "Unzip";}];
            };

            open = {
                rules = [
                    { mime = "text/*"; use = ["edit"]; }
                    { name = "*/"; use = ["edit"]; }
                    { name = "*.zip"; use = ["unzip"]; }
                    { mime = "video/*"; use = ["play"]; }
                    { mime = "audio/*"; use = ["play-once"]; }
                    { mime = "image/*"; use = ["view"]; }
                    { mime = "application/vnd.ms-*"; use = ["opendoc"]; }
                    { mime = "application/vnd.openxmlformats-officedocument*"; use = ["opendoc"]; }
                    { name = "*.json"; use = ["edit"]; }
                    { name = "*"; use = ["open edit"]; }
                ];
            };

        };

        keymap = {

            manager.keymap = [
                { on = [ "<Esc>" ]; run = "escape";             desc = "Exit visual mode, clear selected, or cancel search"; }
                { on = [ "<C-[>" ]; run = "escape";             desc = "Exit visual mode, clear selected, or cancel search"; }
                { on = [ "q" ];     run = "quit";               desc = "Exit the process"; }
                { on = [ "Q" ];     run = "quit --no-cwd-file"; desc = "Exit the process without writing cwd-file"; }

                # Navigation
                { on = [ "k" ]; run = "arrow -1"; desc = "Move cursor up"; }
                { on = [ "j" ]; run = "arrow 1";  desc = "Move cursor down"; }

                { on = [ "K" ]; run = "arrow -5"; desc = "Move cursor up 5 lines"; }
                { on = [ "J" ]; run = "arrow 5";  desc = "Move cursor down 5 lines"; }

                { on = [ "<C-u>" ]; run = "arrow -50%";  desc = "Move cursor up half page"; }
                { on = [ "<C-d>" ]; run = "arrow 50%";   desc = "Move cursor down half page"; }

                { on = [ "h" ]; run = "leave"; desc = "Go back to the parent directory"; }
                { on = [ "l" ]; run = "enter"; desc = "Enter the child directory"; }

                { on = [ "H" ]; run = "back";    desc = "Go back to the previous directory"; }
                { on = [ "L" ]; run = "forward"; desc = "Go forward to the next directory"; }

                { on = [ "<K>" ]; run = "seek -5"; desc = "Seek up 5 units in the preview"; }
                { on = [ "<J>" ]; run = "seek 5";  desc = "Seek down 5 units in the preview"; }

                { on = [ "<Up>" ];    run = "arrow -1"; desc = "Move cursor up"; }
                { on = [ "<Down>" ];  run = "arrow 1";  desc = "Move cursor down"; }
                { on = [ "<Left>" ];  run = "leave";    desc = "Go back to the parent directory"; }
                { on = [ "<Right>" ]; run = "enter";    desc = "Enter the child directory"; }

                { on = [ "g" "g" ]; run = "arrow -99999999"; desc = "Move cursor to the top"; }
                { on = [ "G" ];      run = "arrow 99999999";  desc = "Move cursor to the bottom"; }

                # Selection
                { on = [ "<Space>" ]; run = [ "select --state=none" "arrow 1" ]; desc = "Toggle the current selection state"; }
                { on = [ "v" ];       run = "visual_mode";                        desc = "Enter visual mode (selection mode)"; }
                { on = [ "V" ];       run = "visual_mode --unset";                desc = "Enter visual mode (unset mode)"; }
                { on = [ "<C-a>" ];   run = "select_all --state=true";            desc = "Select all files"; }
                { on = [ "<C-r>" ];   run = "select_all --state=none";            desc = "Inverse selection of all files"; }

                # Operation
                { on = [ "<Enter>" ];   run = "open";                       desc = "Open the selected files"; }
                { on = [ "<C-Enter>" ]; run = "open --interactive";         desc = "Open the selected files interactively"; }
                { on = [ "y" ];         run = "yank";                       desc = "Copy the selected files"; }
                { on = [ "Y" ];         run = "unyank";                     desc = "Cancel the yank status of files"; }
                { on = [ "x" ];         run = "yank --cut";                 desc = "Cut the selected files"; }
                { on = [ "X" ];         run = "unyank";                     desc = "Cancel the yank status of files"; }
                { on = [ "p" ];         run = "paste";                      desc = "Paste the files"; }
                { on = [ "P" ];         run = "paste --force";              desc = "Paste the files (overwrite if the destination exists)"; }
                { on = [ "-" ];         run = "link";                       desc = "Symlink the absolute path of files"; }
                { on = [ "_" ];         run = "link --relative";            desc = "Symlink the relative path of files"; }
                { on = [ "d" ];         run = "remove";                     desc = "Move the files to the trash"; }
                { on = [ "D" ];         run = "remove --permanently";       desc = "Permanently delete the files"; }
                { on = [ "o" ];         run = "create";                     desc = "Create a file or directory (ends with / for directories)"; }
                { on = [ "r" ];         run = "rename --cursor=before_ext"; desc = "Adjust a file or directory name"; }
                { on = [ "c" ];         run = "rename --empty=stem --cursor=before_ext"; desc = "Rename a file or directory"; }
                { on = [ "." ];         run = "hidden toggle";              desc = "Toggle the visibility of hidden files"; }
                { on = [ "s" ];         run = "search fd";                  desc = "Search files by name using fd"; }
                { on = [ "S" ];         run = "search rg";                  desc = "Search files by content using ripgrep"; }
                { on = [ "<C-s>" ];     run = "search none";                desc = "Cancel the ongoing search"; }
                { on = [ "z" ];         run = "plugin compress";            desc = "Archive selected files"; }

                # Linemode
                { on = [ "m" "s" ]; run = "linemode size";        desc = "Set linemode to size"; }
                { on = [ "m" "p" ]; run = "linemode permissions"; desc = "Set linemode to permissions"; }
                { on = [ "m" "m" ]; run = "linemode mtime";       desc = "Set linemode to mtime"; }
                { on = [ "m" "n" ]; run = "linemode none";        desc = "Set linemode to none"; }

                # Copy
                { on = [ "C" "c" ]; run = "copy path";             desc = "Copy the absolute path"; }
                { on = [ "C" "d" ]; run = "copy dirname";          desc = "Copy the path of the parent directory"; }
                { on = [ "C" "f" ]; run = "copy filename";         desc = "Copy the name of the file"; }
                { on = [ "C" "n" ]; run = "copy name_without_ext"; desc = "Copy the name of the file without the extension"; }

                # Find
                { on = [ "/" ]; run = "find --smart";            desc = "Find next file"; }
                { on = [ "?" ]; run = "find --previous --smart"; desc = "Find previous file"; }
                { on = [ "n" ]; run = "find_arrow";              desc = "Go to next found file"; }
                { on = [ "N" ]; run = "find_arrow --previous";   desc = "Go to previous found file"; }

                # Sorting
                { on = [ ";" "m" ]; run = "sort modified --dir-first";               desc = "Sort by modified time"; }
                { on = [ ";" "e" ]; run = "sort extension --dir-first";         	    desc = "Sort by extension"; }
                { on = [ ";" "a" ]; run = "sort alphabetical --dir-first";           desc = "Sort alphabetically"; }
                { on = [ ";" "n" ]; run = "sort natural --dir-first";                desc = "Sort naturally"; }
                { on = [ ";" "s" ]; run = "sort size --dir-first";                   desc = "Sort by size"; }

                # Tasks
                { on = [ "w" ]; run = "tasks_show"; desc = "Show the tasks manager"; }

                # Goto
                { on = [ "g" "h" ];       run = "cd ~";             desc = "Go to the home directory"; }
                { on = [ "g" "c" ];       run = "cd ~/.config";     desc = "Go to the config directory"; }
                { on = [ "g" "d" ];       run = "cd ~/Downloads";   desc = "Go to the downloads directory"; }
                { on = [ "g" "p" ];       run = "cd ~/dev";         desc = "Go to dev"; }
                { on = [ "g" "t" ];       run = "cd /tmp";          desc = "Go to the temporary directory"; }
                { on = [ "g" "<Space>" ]; run = "cd --interactive"; desc = "Go to a directory interactively"; }

                # Help
                { on = [ "~" ]; run = "help"; desc = "Open help"; }
            ];

            tasks.keymap = [
                { on = [ "<Esc>" ]; run = "close"; desc = "Hide the task manager"; }
                { on = [ "<C-[>" ]; run = "close"; desc = "Hide the task manager"; }
                { on = [ "<C-q>" ]; run = "close"; desc = "Hide the task manager"; }
                { on = [ "w" ];     run = "close"; desc = "Hide the task manager"; }

                { on = [ "k" ]; run = "arrow -1"; desc = "Move cursor up"; }
                { on = [ "j" ]; run = "arrow 1";  desc = "Move cursor down"; }

                { on = [ "<Up>" ];   run = "arrow -1"; desc = "Move cursor up"; }
                { on = [ "<Down>" ]; run = "arrow 1";  desc = "Move cursor down"; }

                { on = [ "<Enter>" ]; run = "inspect"; desc = "Inspect the task"; }
                { on = [ "x" ];       run = "cancel";  desc = "Cancel the task"; }

                { on = [ "~" ]; run = "help"; desc = "Open help"; }
            ];

            select.keymap = [
                { on = [ "<Esc>" ];   run = "close";          desc = "Cancel selection"; }
                { on = [ "<Enter>" ]; run = "close --submit"; desc = "Submit the selection"; }

                { on = [ "k" ]; run = "arrow -1"; desc = "Move cursor up"; }
                { on = [ "j" ]; run = "arrow 1";  desc = "Move cursor down"; }

                { on = [ "K" ]; run = "arrow -5"; desc = "Move cursor up 5 lines"; }
                { on = [ "J" ]; run = "arrow 5";  desc = "Move cursor down 5 lines"; }

                { on = [ "<Up>" ];   run = "arrow -1"; desc = "Move cursor up"; }
                { on = [ "<Down>" ]; run = "arrow 1";  desc = "Move cursor down"; }

                { on = [ "<S-Up>" ];   run = "arrow -5"; desc = "Move cursor up 5 lines"; }
                { on = [ "<S-Down>" ]; run = "arrow 5";  desc = "Move cursor down 5 lines"; }

                { on = [ "~" ]; run = "help"; desc = "Open help"; }
            ];


            input.keymap = [
                { on = [ "<C-q>" ];   run = "close";          desc = "Cancel input"; }
                { on = [ "<Enter>" ]; run = "close --submit"; desc = "Submit the input"; }
                { on = [ "<Esc>" ];   run = "escape";         desc = "Go back the normal mode, or cancel input"; }

                # Mode
                { on = [ "i" ]; run = "insert";                              desc = "Enter insert mode"; }
                { on = [ "a" ]; run = "insert --append";                     desc = "Enter append mode"; }
                { on = [ "I" ]; run = [ "move -999" "insert" ];             desc = "Move to the BOL, and enter insert mode"; }
                { on = [ "A" ]; run = [ "move 999" "insert --append" ];     desc = "Move to the EOL, and enter append mode"; }
                { on = [ "v" ]; run = "visual";                              desc = "Enter visual mode"; }
                { on = [ "V" ]; run = [ "move -999" "visual" "move 999" ]; desc = "Enter visual mode and select all"; }

                # Character-wise movement
                { on = [ "h" ];       run = "move -1"; desc = "Move back a character"; }
                { on = [ "l" ];       run = "move 1";  desc = "Move forward a character"; }
                { on = [ "<Left>" ];  run = "move -1"; desc = "Move back a character"; }
                { on = [ "<Right>" ]; run = "move 1";  desc = "Move forward a character"; }
                { on = [ "<C-b>" ];   run = "move -1"; desc = "Move back a character"; }
                { on = [ "<C-f>" ];   run = "move 1";  desc = "Move forward a character"; }

                # Word-wise movement
                { on = [ "b" ];     run = "backward";              desc = "Move back to the start of the current or previous word"; }
                { on = [ "w" ];     run = "forward";               desc = "Move forward to the start of the next word"; }
                { on = [ "e" ];     run = "forward --end-of-word"; desc = "Move forward to the end of the current or next word"; }
                { on = [ "<A-b>" ]; run = "backward";              desc = "Move back to the start of the current or previous word"; }
                { on = [ "<A-f>" ]; run = "forward --end-of-word"; desc = "Move forward to the end of the current or next word"; }

                # Line-wise movement
                { on = [ "0" ];      run = "move -999"; desc = "Move to the BOL"; }
                { on = [ "$" ];      run = "move 999";  desc = "Move to the EOL"; }
                { on = [ "<C-a>" ];  run = "move -999"; desc = "Move to the BOL"; }
                { on = [ "<C-e>" ];  run = "move 999";  desc = "Move to the EOL"; }
                { on = [ "<Home>" ]; run = "move -999"; desc = "Move to the BOL"; }
                { on = [ "<End>" ];  run = "move 999";  desc = "Move to the EOL"; }

                # Delete
                { on = [ "<Backspace>" ]; run = "backspace";	        desc = "Delete the character before the cursor"; }
                { on = [ "<Delete>" ];    run = "backspace --under"; desc = "Delete the character under the cursor"; }
                { on = [ "<C-h>" ];       run = "backspace";         desc = "Delete the character before the cursor"; }
                { on = [ "<C-d>" ];       run = "backspace --under"; desc = "Delete the character under the cursor"; }

                # Kill
                { on = [ "<C-u>" ]; run = "kill bol";      desc = "Kill backwards to the BOL"; }
                { on = [ "<C-k>" ]; run = "kill eol";      desc = "Kill forwards to the EOL"; }
                { on = [ "<C-w>" ]; run = "kill backward"; desc = "Kill backwards to the start of the current word"; }
                { on = [ "<A-d>" ]; run = "kill forward";  desc = "Kill forwards to the end of the current word"; }

                # Cut/Yank/Paste
                { on = [ "d" ]; run = "delete --cut";                              desc = "Cut the selected characters"; }
                { on = [ "D" ]; run = [ "delete --cut" "move 999" ];              desc = "Cut until the EOL"; }
                { on = [ "c" ]; run = "delete --cut --insert";                     desc = "Cut the selected characters, and enter insert mode"; }
                { on = [ "C" ]; run = [ "delete --cut --insert" "move 999" ];     desc = "Cut until the EOL, and enter insert mode"; }
                { on = [ "x" ]; run = [ "delete --cut" "move 1 --in-operating" ]; desc = "Cut the current character"; }
                { on = [ "y" ]; run = "yank";           desc = "Copy the selected characters"; }
                { on = [ "p" ]; run = "paste";          desc = "Paste the copied characters after the cursor"; }
                { on = [ "P" ]; run = "paste --before"; desc = "Paste the copied characters before the cursor"; }

                # Undo/Redo
                { on = [ "u" ];     run = "undo"; desc = "Undo the last operation"; }
                { on = [ "<C-r>" ]; run = "redo"; desc = "Redo the last operation"; }

                # Help
                { on = [ "~" ]; run = "help"; desc = "Open help"; }
                ];

            completion.keymap = [
                { on = [ "<C-q>" ];   run = "close";                                      desc = "Cancel completion"; }
                { on = [ "<Tab>" ];   run = "close --submit";                             desc = "Submit the completion"; }
                { on = [ "<Enter>" ]; run = [ "close --submit" "close_input --submit" ]; desc = "Submit the completion and input"; }

                { on = [ "<A-k>" ]; run = "arrow -1"; desc = "Move cursor up"; }
                { on = [ "<A-j>" ]; run = "arrow 1";  desc = "Move cursor down"; }

                { on = [ "<Up>" ];   run = "arrow -1"; desc = "Move cursor up"; }
                { on = [ "<Down>" ]; run = "arrow 1";  desc = "Move cursor down"; }

                { on = [ "<C-p>" ]; run = "arrow -1"; desc = "Move cursor up"; }
                { on = [ "<C-n>" ]; run = "arrow 1";  desc = "Move cursor down"; }

                { on = [ "~" ]; run = "help"; desc = "Open help"; }
                ];

            help.keymap = [
                { on = [ "<Esc>" ]; run = "escape"; desc = "Clear the filter, or hide the help"; }
                { on = [ "<C-[>" ]; run = "escape"; desc = "Clear the filter, or hide the help"; }
                { on = [ "q" ];     run = "close";  desc = "Exit the process"; }
                { on = [ "<C-q>" ]; run = "close";  desc = "Hide the help"; }

                # Navigation
                { on = [ "k" ]; run = "arrow -1"; desc = "Move cursor up"; }
                { on = [ "j" ]; run = "arrow 1";  desc = "Move cursor down"; }

                { on = [ "K" ]; run = "arrow -5"; desc = "Move cursor up 5 lines"; }
                { on = [ "J" ]; run = "arrow 5";  desc = "Move cursor down 5 lines"; }

                { on = [ "<Up>" ];   run = "arrow -1"; desc = "Move cursor up"; }
                { on = [ "<Down>" ]; run = "arrow 1";  desc = "Move cursor down"; }

                { on = [ "<S-Up>" ];   run = "arrow -5"; desc = "Move cursor up 5 lines"; }
                { on = [ "<S-Down>" ]; run = "arrow 5";  desc = "Move cursor down 5 lines"; }

                # Filtering
                { on = [ "/" ]; run = "filter"; desc = "Apply a filter for the help items"; }
            ];
        };

        theme.manager.hovered = lib.mkForce {
            bg = "#" + config.stylix.base16Scheme.base02;
            bold = true;
            fg = "#" + config.stylix.base16Scheme.base0E;
        };
    };
}
