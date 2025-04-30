{pkgs, ...}: {
  packages = with pkgs; [
    foot
    imv
    mpv
    zathura
    (writeShellScriptBin "imvs"
      ''
        imv $1 -W $(magick identify -format %w $1) -H$(magick identify -format %h $1)
      '')
    (writeShellScriptBin "mpa"
      ''
        foot --override=app-id=floatfoot --override=initial-window-size-chars=70x5 mpv --no-audio-display $@
      '')
  ];
  files = {
    ".config/yazi/plugins/compress.yazi".source = pkgs.fetchFromGitHub {
      owner = "KKV9";
      repo = "compress.yazi";
      rev = "60b24af";
      sha256 = "sha256-Yf5R3H8t6cJBMan8FSpK3BDSG5UnGlypKSMOi0ZFqzE=";
    };
    ".config/yazi/theme.toml".text = ''
      [mode]
      normal_main = { fg = "blue", bg = "reset", bold = true }
      normal_alt  = { fg = "blue", bg = "reset" }

      # Select mode
      select_main = { fg = "magenta", bg = "reset", bold = true }
      select_alt  = { fg = "magenta", bg = "reset" }

      # Unset mode
      unset_main = { fg = "red", bg = "reset", bold = true }
      unset_alt  = { fg = "red", bg = "reset" }

      [status]
      overall   = {}
      sep_left  = { open = " ", close = " " }
      sep_right = { open = " ", close = " " }

      [which]
      mask = { bg = "reset" }
    '';
    ".config/yazi/yazi.toml".text = ''
      [manager]
      linemode = "size"

      [opener]
      view = [
          { run = 'imvs "$@"', for = "unix" },
      ]
      listen = [
          { run = 'mpa "$@"', for = "unix" },
      ]
      viewpdf = [
          { run = 'zathura "$@"', desc = "Zathura", for = "unix" },
      ]
      term = [
          { run = 'hyprctl dispatch exec -- foot -D "$1"', desc = "Terminal", for = "unix" },
      ]
      [open]
      rules = [
        # Folder
        { name = "*/", use = [ "edit", "term", "open", "reveal" ] },
        # Text
        { mime = "text/*", use = [ "edit", "reveal" ] },
        # Image
        { mime = "image/*", use = [ "view", "open", "reveal" ] },
        # Video
        { mime = "video/*", use = [ "play", "reveal" ] },
        # Audio
        { mime = "audio/*", use = [ "listen", "reveal" ] },
        # Archive
        { name = "*.{zip,rar,7z*,tar,gzip,xz,zstd,bzip*,lzma,compress,archive,cpio,arj,xar,ms-cab*}", use = [ "extract", "reveal" ] },
        # JSON
        { mime = "application/{json,ndjson}", use = [ "edit", "reveal" ] },
        { mime = "application/pdf", use = [ "viewpdf", "open", "reveal" ] },
        { mime = "*/javascript", use = [ "edit", "reveal" ] },
        # Empty file
        { mime = "inode/empty", use = [ "edit", "reveal" ] },
        # Fallback
        { name = "*", use = [ "open", "reveal" ] },
      ]
    '';
    ".config/yazi/keymap.toml".text = ''
      [manager]
      prepend_keymap = [
        { on = "!", run = 'shell "$SHELL" --block', desc = "Open shell here" },
        { on = "z", run = "plugin compress", desc = "Archive selected files" },
        { on = "o", run = "create", desc = "create new file or dir/" },
        { on = "O", run = "create", desc = "create new file or dir/" },
        { on = "e", run = "rename --empty=ext --cursor=end", desc = "Rename at End" },
        { on = "i", run = "rename --cursor=before_ext", desc = "Rename in Mid" },
        { on = "I", run = "rename --cursor=before_ext", desc = "Rename in Mid" },
        { on = "c", run = "rename --empty=stem --cursor=before_ext", desc = "Change Name" },
        { on = "J", run = "arrow 100%", desc = "One Page Down" },
        { on = "K", run = "arrow -100%", desc = "One Page Up" },
        { on = "a", run = "toggle_all", desc = "Toggle all files" },
      ]
    '';
  };
}
