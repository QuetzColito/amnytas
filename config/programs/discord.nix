{
  theme,
  pkgs,
  ...
}: {
  packages = [pkgs.vesktop];
  files = {
    ".config/vesktop/themes/amnytas.theme.css".text = ''
      /**
       * @name midnight (base16)
       * @description a dark, customizable discord theme. based on tokyo night theme (https://github.com/tokyo-night/tokyo-night-vscode-theme).
       * @author refact0r
       * @version 2.0.1
       * @invite nz87hXyvcy
       * @website https://github.com/refact0r/midnight-discord
       * @source https://github.com/refact0r/midnight-discord/blob/master/themes/flavors/midnight-tokyo-night.theme.css
       * @authorId 508863359777505290
       * @authorLink https://www.refact0r.dev
      */

      /* import theme modules */
      @import url('https://refact0r.github.io/midnight-discord/build/midnight.css');

      body {
          /* font, change to "" for default discord font */
          --font: "";
          --font-primary: ${theme.sansSerif.name};
          --font-display: ${theme.sansSerif.name};
          --font-code: ${theme.monospace.name};

          /* sizes */
          --gap: 5px; /* spacing between panels */
          --divider-thickness: 2px; /* thickness of unread messages divider and highlighted message borders */

          /* animation/transition options */
          --animations: on; /* turn off to disable all midnight animations/transitions */
          --list-item-transition: 0.2s ease; /* transition for list items */
          --dms-icon-svg-transition: 0.4s ease; /* transition for the dms icon */

          /* top bar options */
          --move-top-bar-buttons: off; /* turn on to move inbox button to the server list (recommend setting top bar height to 24px) */
          --custom-app-top-bar-height: 36px; /* height of the titlebar/top bar (default is 36px)*/

          /* window controls */
          --custom-window-controls: on; /* turn off to use discord default window controls */
          --window-control-size: 14px; /* size of custom window controls */

          /* dms button icon options */
          --dms-icon: default; /* set to default to use discord icon, on to use custom icon, off to disable completely */
          --dms-icon-svg-url: url('https://upload.wikimedia.org/wikipedia/commons/c/c4/Font_Awesome_5_solid_moon.svg'); /* icon svg url. MUST BE A SVG. */
          --dms-icon-svg-size: 90%; /* size of the svg (css mask-size) */
          --dms-icon-color-before: var(--icon-secondary); /* normal icon color */
          --dms-icon-color-after: var(--white); /* icon color when button is hovered/selected */

          /* dms button background options */
          --dms-background: off; /* off to disable, image to use a background image, color to use a custom color/gradient */
          --dms-background-image-url: url(""); /* url of the background image */
          --dms-background-image-size: cover; /* size of the background image (css background-size) */
          --dms-background-color: linear-gradient(70deg, var(--blue-2), var(--purple-2), var(--red-2)); /* fixed color/gradient (css background) */

          /* background image options */
          --background-image: off; /* turn on to use a background image */
          --background-image-url: url(""); /* url of the background image */

          /* transparency/blur options */
          /* NOTE: TO USE TRANSPARENCY/BLUR, YOU MUST HAVE TRANSPARENT BG COLORS. FOR EXAMPLE: --bg-4: hsla(220, 15%, 10%, 0.7); */
          --transparency-tweaks: off; /* turn on to remove some elements for better transparency */
          --remove-bg-layer: off; /* turn on to remove the base --bg-3 layer for use with window transparency (WILL OVERRIDE BACKGROUND IMAGE) */
          --panel-blur: off; /* turn on to blur the background of panels */
          --blur-amount: 12px; /* amount of blur */
          --bg-floating: var(--bg-3); /* you can set this to a more opaque color if floating panels look too transparent */

          /* chatbar options */
          --flipped-chatbar: on; /* turn on to move the typing indicator above the chatbar */
          --chatbar-height: 47px; /* height of the chatbar (52px by default, 47px to align it with the user panel) */
          --chatbar-padding: 8px; /* padding of the chatbar */

          /* other options */
          --small-user-panel: off; /* turn on to make the user panel smaller like in old discord */
      }

      /* color options */
      :root {
          --colors: on; /* turn off to use discord default colors */

          /* text colors */
          --text-0: var(--bg-3); /* text on colored elements */
          --text-1: #${theme.base05}; /* other normally white text */
          --text-2: #${theme.base06}; /* headings and important text */
          --text-3: #${theme.base05}; /* normal text */
          --text-4: #${theme.base04}; /* icon buttons and channels */
          --text-5: #${theme.base03}; /* muted channels/chats and timestamps */

          /* background and dark colors */
          --bg-1: #${theme.base02}; /* dark buttons when clicked */
          --bg-2: #${theme.base00}; /* dark buttons */
          --bg-3: #${theme.base00}; /* spacing, secondary elements */
          --bg-4: #${theme.base01}; /* main background color */
          --hover: #${theme.base04}20; /* channels and buttons when hovered */
          --active: #${theme.base04}40; /* channels and buttons when clicked or selected */
          --active-2: #${theme.base04}30; /* extra state for transparent buttons */
          --message-hover: #${theme.base00}A0; /* messages when hovered */

          /* accent colors */
          --accent-1: var(--blue-1); /* links and other accent text */
          --accent-2: var(--blue-2); /* small accent elements */
          --accent-3: var(--blue-3); /* accent buttons */
          --accent-4: var(--blue-4); /* accent buttons when hovered */
          --accent-5: var(--blue-5); /* accent buttons when clicked */
          --accent-new: var(--accent-2); /* stuff that's normally red like mute/deafen buttons */
          --mention: linear-gradient(to right, color-mix(in hsl, var(--accent-2), transparent 90%) 40%, transparent); /* background of messages that mention you */
          --mention-hover: linear-gradient(to right, color-mix(in hsl, var(--accent-2), transparent 95%) 40%, transparent); /* background of messages that mention you when hovered */
          --reply: linear-gradient(to right, color-mix(in hsl, var(--text-3), transparent 90%) 40%, transparent); /* background of messages that reply to you */
          --reply-hover: linear-gradient(to right, color-mix(in hsl, var(--text-3), transparent 95%) 40%, transparent); /* background of messages that reply to you when hovered */

          /* status indicator colors */
          --online: var(--green-2); /* change to #43a25a for default */
          --dnd: var(--red-2); /* change to #d83a42 for default */
          --idle: var(--yellow-2); /* change to #ca9654 for default */
          --streaming: var(--purple-2); /* change to #593695 for default */
          --offline: var(--text-4); /* change to #83838b for default offline color */

          /* border colors */
          --border-light: #${theme.base00}; /* light border color */
          --border: #${theme.base00}; /* normal border color */
          --button-border: #${theme.base00}; /* neutral border color of buttons */

          /* base colors */
          --red-1: #${theme.base08};
          --red-2: #${theme.base08};
          --red-3: #${theme.base08};
          --red-4: #${theme.base08};
          --red-5: #${theme.base08};

          --green-1: #${theme.base0B};
          --green-2: #${theme.base0B};
          --green-3: #${theme.base0B};
          --green-4: #${theme.base0B};
          --green-5: #${theme.base0B};

          --blue-1: #${theme.base0D};
          --blue-2: #${theme.base0D};
          --blue-3: #${theme.base0D};
          --blue-4: #${theme.base0C};
          --blue-5: #${theme.base0C};

          --yellow-1: #${theme.base0A};
          --yellow-2: #${theme.base0A};
          --yellow-3: #${theme.base0A};
          --yellow-4: #${theme.base0A};
          --yellow-5: #${theme.base0A};

          --purple-1: #${theme.base0E};
          --purple-2: #${theme.base0E};
          --purple-3: #${theme.base0E};
          --purple-4: #${theme.base0E};
          --purple-5: #${theme.base0E};
      }
    '';
  };
}
