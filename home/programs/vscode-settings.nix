{
  # currently not in use
  # my work laptop has a better config, but is Windows, so id have to convert it back from json :/
  "boot-java.rewrite.reconcile" = true;
  "git.enableSmartCommit" = true;
  "terminal.integrated.defaultProfile.windows" = "Git Bash";
  "editor.insertSpaces" = false;
  "editor.comments.insertSpace" = false;
  "explorer.confirmDelete" = false;
  "editor.minimap.enabled" = false;
  "java.debug.settings.showStaticVariables" = false;
  "editor.codeActionsOnSave" = {
    "source.organizeImports" = "explicit";
  };
  "workbench.iconTheme" = "material-icon-theme";
  "git.openRepositoryInParentFolders" = "always";
  "editor.linkedEditing" = true;
  "javascript.updateImportsOnFileMove.enabled" = "always";
  "update.showReleaseNotes" = false;
  "zenMode.hideLineNumbers" = false;
  "editor.lineNumbers" = "relative";
  "vim.leader" = "<Space>";
  "vim.hlsearch" = true;
  "vim.normalModeKeyBindingsNonRecursive" = [
    # // NAVIGATION
    # // switch b/w buffers
    {
      "before" = [
        "<S-h>"
      ];
      "commands" = [
        ":bprevious"
      ];
    }
    {
      "before" = [
        "<S-l>"
      ];
      "commands" = [
        ":bnext"
      ];
    }
    # // splits
    {
      "before" = [
        "leader"
        "v"
      ];
      "commands" = [
        ":vsplit"
      ];
    }
    {
      "before" = [
        "leader"
        "s"
      ];
      "commands" = [
        ":split"
      ];
    }
    # // panes
    {
      "before" = [
        "leader"
        "h"
      ];
      "commands" = [
        "workbench.action.focusLeftGroup"
      ];
    }
    {
      "before" = [
        "leader"
        "j"
      ];
      "commands" = [
        "workbench.action.focusBelowGroup"
      ];
    }
    {
      "before" = [
        "leader"
        "k"
      ];
      "commands" = [
        "workbench.action.focusAboveGroup"
      ];
    }
    {
      "before" = [
        "leader"
        "l"
      ];
      "commands" = [
        "workbench.action.focusRightGroup"
      ];
    }
    # // NICE TO HAVE
    {
      "before" = [
        "leader"
        "w"
      ];
      "commands" = [
        ":w!"
      ];
    }
    {
      "before" = [
        "leader"
        "q"
      ];
      "commands" = [
        ":q!"
      ];
    }
    {
      "before" = [
        "leader"
        "x"
      ];
      "commands" = [
        ":x!"
      ];
    }
    {
      "before" = [
        "["
        "d"
      ];
      "commands" = [
        "editor.action.marker.prev"
      ];
    }
    {
      "before" = [
        "]"
        "d"
      ];
      "commands" = [
        "editor.action.marker.next"
      ];
    }
    {
      "before" = [
        "<leader>"
        "c"
        "a"
      ];
      "commands" = [
        "editor.action.quickFix"
      ];
    }
    {
      "before" = [
        "leader"
        "f"
      ];
      "commands" = [
        "workbench.action.quickOpen"
      ];
    }
    {
      "before" = [
        "leader"
        "p"
      ];

      "commands" = [
        "editor.action.formatDocument"
      ];
    }
    {
      "before" = [
        "g"
        "h"
      ];
      "commands" = [
        "editor.action.showDefinitionPreviewHover"
      ];
    }
  ];
  "vim.visualModeKeyBindings" = [
    # // Stay in visual mode while indenting
    {
      "before" = [
        "<"
      ];
      "commands" = [
        "editor.action.outdentLines"
      ];
    }
    {
      "before" = [
        ">"
      ];
      "commands" = [
        "editor.action.indentLines"
      ];
    }
    {
      "before" = [
        "leader"
        "y"
      ];
      "commands" = [
        ":\"+y"
      ];
    }
    {
      "before" = [
        "leader"
        "p"
      ];
      "commands" = [
        ":\"+p"
      ];
    }
    # // Move selected lines while staying in visual mode
    {
      "before" = [
        "J"
      ];
      "commands" = [
        "editor.action.moveLinesDownAction"
      ];
    }
    {
      "before" = [
        "K"
      ];
      "commands" = [
        "editor.action.moveLinesUpAction"
      ];
    }
    # // toggle comment selection
    {
      "before" = [
        "leader"
        "c"
      ];
      "commands" = [
        "editor.action.commentLine"
      ];
    }
    {
      "before" = [
        "leader"
        "o"
      ];
      "commands" = [
        "editor.action.changeAll"
      ];
    }
  ];
  "explorer.confirmDragAndDrop" = false;
  "window.menuBarVisibility" = "toggle";
  "git.autofetch" = true;
  "terminal.integrated.defaultProfile.linux" = "nu";
  "git.confirmSync" = false;
  "editor.fontFamily" = "'FiraCode Nerd Font'";
  "redhat.telemetry.enabled" = false;
  "terminal.integrated.enablePersistentSessions" = false;
  "terminal.integrated.fontFamily" = "'FiraCode Nerd Font'";
  "workbench.colorTheme" = "Tokyo Night";
  "workbench.activityBar.location" = "hidden";
  "editor.unicodeHighlight.nonBasicASCII" = false;
}
