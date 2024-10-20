# Amnytas - My Nixos Hyprland Config

This is the nix config i use on all my systems, here is what it looks like:

https://github.com/user-attachments/assets/5c66eb6f-b504-4857-b43d-9f7cd78b732e

## Features

- Tokyo Night Color Scheme throughout the system (mostly thanks to stylix)
- Widgets made with AGS
- Wallpaper changes depending on Workspace ([see all wallpapers](https://github.com/QuetzColito/amnytas/blob/main/wallpaper/README.md))
- hyprlock config
- Nvidia driver setup
- usable across multiple systems
- arlecchino grub theme :>
- a nixvim config (prob not the best, but works for me ^^)
- pseudofullscreen (in case an application/game (*cough* gw2) doesnt behave in fullscreen)
- hotkeys for almost anything I wanna do (./home/rice/hyprland/binds.nix)
- Mozc IME for typing Japanese
- OwOpacity on everything \~||\~

![terminals](https://github.com/user-attachments/assets/8b9d94f7-7e7e-4f88-ada8-b2c8fc611fbf)
![vertical](https://github.com/user-attachments/assets/2b57bbb9-255b-442c-b996-e7422113d8c2)
![widgets](https://github.com/user-attachments/assets/9e0dfd5d-2eac-4289-b706-95ee646afab9)
![hyprlock](https://github.com/user-attachments/assets/c9a1f143-9709-49ff-934a-4d05e1c5642a)

### Wanna try it out?

Simply run

```
nix run github:QuetzColito/amnytas#install --extra-experimental-features "nix-command flakes"
```

on nixos x86_64 with a user with a preconfigured password and the script will install the whole config to ~/amnytas

If you wanna know what exactly the script does, it isnt super long and explained in the comment in flake.nix ^^

If you want to add extra config before the install abort the script once it starts nixos-rebuild and edit /hosts/\<yourhost\>/

I tried to document the important/unintuitive parts :3

## Software Used

|                   |               |
| ----------------- | ------------- |
| Distro            | NixOs         |
| WM/Compositor     | Hyprland      |
| Terminal          | foot          |
| Shell             | zsh           |
| Prompt            | ohmyposh      |
| Bar/Widgets       | AGS           |
| Browser           | Zen,Firefox   |
| Text Editor       | neovim        |
| File Manager      | yazi,Thunar   |
| Notifications     | mako          |
| image viewer      | imv           |
| screen recording  | wf-recorder   |
| music player      | ytm by th-ch  |



## Where I stole it all from c:

- https://github.com/sioodmy/dotfiles an older version of this repo was the starting point
- https://wallhaven.cc/ for most of the wallpapers
- https://github.com/lpdkt/dronevil some stuff for Hyprland, and my initial waybar setup
- https://github.com/Axarva/dotfiles-2.0 widget inspiration
- https://www.youtube.com/@vimjoyer for learning nix
