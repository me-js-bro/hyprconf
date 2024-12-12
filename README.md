<h1 align="center">Minimal Hyprland Configuration</h1>
<h3 align="center">By</h3>
<h2 align="center">Js Bro ( Md. Mahin Islam Mahi )</h2>
<br>

<h3>This Hyprland configuration is kind of minila looking, but also little bit gorgeous I guess. Why don't you check it out? </h3>

## Screenshots

<details close>
<summary>Themes</summary>
<p align="center">
   <img aligh="center" width="49%" src="https://github.com/me-js-bro/Screen-Shots/blob/main/hyprconf/theme/1.png?raw=true" />
   <img aligh="center" width="49%" src="https://github.com/me-js-bro/Screen-Shots/blob/main/hyprconf/theme/2.png?raw=true" /> <br>

   <img aligh="center" width="49%" src="https://github.com/me-js-bro/Screen-Shots/blob/main/hyprconf/theme/3.png?raw=true" />
   <img aligh="center" width="49%" src="https://github.com/me-js-bro/Screen-Shots/blob/main/hyprconf/theme/4.png?raw=true" />
</p> <br>
</details>

<details close>
<summary>Menu</summary>
<p align="center">
   <img aligh="center" width="49%" src="https://github.com/me-js-bro/Screen-Shots/blob/main/hyprconf/menu/1.png?raw=true" />
   <img aligh="center" width="49%" src="https://github.com/me-js-bro/Screen-Shots/blob/main/hyprconf/menu/2.png?raw=true" /> <br>

   <img aligh="center" width="49%" src="https://github.com/me-js-bro/Screen-Shots/blob/main/hyprconf/menu/4.png?raw=true" />
   <img aligh="center" width="49%" src="https://github.com/me-js-bro/Screen-Shots/blob/main/hyprconf/menu/3.png?raw=true" />
</p> <br>
</details>

<details close>
<summary>Power Menu</summary>
<p align="center">
   <img aligh="center" width="49%" src="https://github.com/me-js-bro/Screen-Shots/blob/main/hyprconf/power/1.png?raw=true" />
   <img aligh="center" width="49%" src="https://github.com/me-js-bro/Screen-Shots/blob/main/hyprconf/power/2.png?raw=true" /> <br>

   <img aligh="center" width="99%" src="https://github.com/me-js-bro/Screen-Shots/blob/main/hyprconf/power/3.png?raw=true" />
</p> <br>
</details>

<details close>
<summary>Wallpaper</summary>
<p align="center">
   <img aligh="center" width="49%" src="https://github.com/me-js-bro/Screen-Shots/blob/main/hyprconf/wallpaper/1.png?raw=true" />
   <img aligh="center" width="49%" src="https://github.com/me-js-bro/Screen-Shots/blob/main/hyprconf/wallpaper/2.png?raw=true" /> <br>

   <img aligh="center" width="99%" src="https://github.com/me-js-bro/Screen-Shots/blob/main/hyprconf/wallpaper/3.png?raw=true" />
</p> <br>
</details>

<details close>
<summary>Lock Screen</summary>
<p align="center">
   <img aligh="center" width="99%" src="https://github.com/me-js-bro/Screen-Shots/blob/main/hyprconf/lock.png?raw=true" />
</p>
</details>

<br>

## Features

- <h4>Dynamic Wallpaper changing script</h4>
- <h4>Change colors according to the changed wallpaper (pywal)</h4>
- <h4>Light and Dark Mode</h4>
- <h4>Select and Open apps using Rofi app launcher</h4>
- <h4>Gorgeous looking Waybar styles</h4>
- <h4>Rofi app launcher styles</h4>
- <h4>Rofi power menu</h4>
- <h4>Opening some web pages as single tab (chatGPT, Gemini, Facebook, YouTube, WhatsApp, Photopea)</h4>
- <h4>Locking with Hyprlock</h4>
- <h4>Set your user image in Hyprlock ( a script to set your user image )</h4>
- <h4>Hypridle to handle auto lock and suspend when no action is running </h4>
- <h4>Hyprsunset to use nightlight, `SUPER` + F1 to increase, `SUPER` + F2 to decrease and `SUPER` + F3 to set to default </h4>
  <br>

## Configure for OpenBangla-Keyboard ( to write in bangla )

<details close>
<summary>Setup OpenBangla-Keyboard</summary>
<h4>
If you have OpenBangla-Keyboard installed, then you need to follow some steps to add the keyboard in fcitx5. Just follow the instructions bellow.
</h4>
<h4>1) Right click on this keyboard icon in you waybar.</h4>

<img src="https://github.com/me-js-bro/Screen-Shots/blob/main/openbangla/step-1.jpg?raw=true" /> <br>

<h4>2) Search for "openbangla" and select the keyboard</h4>
<img src="https://github.com/me-js-bro/Screen-Shots/blob/main/openbangla/step-2.jpg?raw=true" /> <br>
<h4>3) Now add the keyboard by clicking the 'right aero' icon and click on apply.</h4>
<img src="https://github.com/me-js-bro/Screen-Shots/blob/main/openbangla/step-3.jpg?raw=true" /> <br>

<h4>Now you can switch keyboard using "CTRL + Space"</h4> <br>
</details>

## Installation

<h4>To install and setup this hyprland configuration automaticly, just follow these stpes...</h4>

- Clone this repository:

```
   git clone --depth=1 https://github.com/me-js-bro/hyprconf.git
```

- Now cd into hyprconf directory and run this command.:
  ```
  cd ~/hyprconf
  chmod +x setup.sh
  ./setup.sh
  ```

## Update

<h4>To Update into the latest commit. jusr run this command in your tarminal..</h4>

```shell
bash -c "$(wget -q  https://raw.githubusercontent.com/me-js-bro/hyprconf/main/update.sh -O -)"
```

- Hurrah! Now reboot your system, select Hyprland from your login manager, log into your Hyprland and enjoy it.
<hr> <br>

## -----------(O_O)-----------

#### Well if you want to automate the required packages installation process and setup this config automaticly. then you should visit [This Repository](https://github.com/me-js-bro/hyprconf-install.git). I will automate the process for you.

<br>

## Keyboard Shortcuts

### Hyprland Keybinds

| Function                          | Keybind                                          | Action                                                                 |
| --------------------------------- | ------------------------------------------------ | ---------------------------------------------------------------------- |
| Change Wallpaper                  | `SUPER` + `W`                                    | Change desktop wallpaper                                               |
|                                   | `SUPER` + `SHIFT` + `W`                          | Select wallpaper, style 1                                              |
|                                   | `SUPER` + `ALT` + `SHIFT` + `W`                  | Select wallpaper, style 2                                              |
| Screenshot                        | `PRINT`                                          | Take a screenshot                                                      |
| Key Binds Help                    | `SUPER` + `SHIFT` + `h`                          | Display keybinds help                                                  |
| Open Terminal                     | `SUPER` + `Return`                               | Open terminal (Kitty)                                                  |
| Open Terminal                     | `SUPER` + `SHIFT` + `Return`                     | Open terminal floating mode (Kitty)                                    |
| Kill Active Window                | `SUPER` + `Q`                                    | Close active window                                                    |
| Exit Window Manager               | `SUPER` + `SHIFT` + `M`                          | Exit window manager                                                    |
| Open File Manager                 | `SUPER` + `E`                                    | Open file manager                                                      |
| Toggle Floating Window            | `SUPER` + `V`                                    | Toggle floating state of active window                                 |
| Toggle Floating Window            | `SUPER` + `ALT` + `V`                            | Toggle floating all windows                                            |
| Fullscreen Toggle                 | `SUPER` + `F`                                    | Toggle fullscreen of active window                                     |
| Open Application Menu             | `SUPER` + `D`                                    | Open application menu                                                  |
|                                   | `SUPER` + `ALT` + `D`                            | Open theme selector rofi menu                                          |
| Clipboard Manager                 | `SUPER` + `ALT` + `c`                            | Manage clipboard contents (clear or view)                              |
| Clipboard Wipe                    | `SUPER` + `ALT` + `w`                            | Clear clipboard contents                                               |
| Emoji Selector                    | `SUPER` + `SHIFT` + `D`                          | Open emoji selector                                                    |
| Shutdown/Restart Menu             | `SUPER` + `x`                                    | Open power menu                                                        |
| Change Power Menu Theme           | `SUPER` + `ALT` + `x`                            | Change power menu theme                                                |
| Open Code Editor                  | `SUPER` + `C`                                    | Open code editor                                                       |
| Open Web Browsers                 | `SUPER` + `B`                                    | Open default web browsers                                              |
| Open Web Browsers                 | `ALT` + `B`                                      | Open script to set default web browser                                 |
| Switch Window                     | `SUPER` + `Tab`                                  | Open rofi to switch between windows                                    |
| Hide/Unhide Waybar                | `CONTROL` + `ESCAPE`                             | Hide and unhide status bar (waybar)                                    |
| Reload Waybar                     | `CONTROL` + `ALT` + `ESCAPE`                     | Reload status bar (waybar)                                             |
| Reload Hyprland                   | `SUPER` + `CTRL` + `R`                           | Reload Hyprland                                                        |
| Update system                     | `CONTROL` + `U`                                  | Update the system                                                      |
| Lock Screen                       | `SUPER` + `SHIFT` + `l`                          | Lock the screen (Hyprlock)                                             |
| Toggle Dark/Light Theme           | `SUPER` + `ALT` + `l`                            | Toggle between dark and light themes                                   |
| Adjust Waybar Layout              | `SUPER` + `CTRL` + `w`                           | Adjust waybar layout                                                   |
| Edit Dotfiles                     | `SUPER` + `CTRL` + `e`                           | Edit dotfiles                                                          |
| Open Shell Script                 | `SUPER` + `ALT` + `b`                            | Open theme selector for shell script (bash/zsh)                        |
| Open Apps (Custom)                | `SUPER` + `SHIFT` + `f`                          | Open Facebook                                                          |
|                                   | `SUPER` + `SHIFT` + `y`                          | Open YouTube                                                           |
|                                   | `SUPER` + `SHIFT` + `a`                          | Open WhatsApp                                                          |
|                                   | `SUPER` + `CTRL` + `a`                           | Open ChatGPT                                                           |
|                                   | `SUPER` + `SHIFT` + `g`                          | Open GitHub                                                            |
|                                   | `SUPER` + `CTRL` + `p`                           | Open Photopea                                                          |
| Move Focus (Arrow Keys)           | `SUPER` + `l`                                    | Move focus right                                                       |
|                                   | `SUPER` + `h`                                    | Move focus left                                                        |
|                                   | `SUPER` + `k`                                    | Move focus up                                                          |
|                                   | `SUPER` + `j`                                    | Move focus down                                                        |
| Move Window (Arrow Keys)          | `SUPER` + `CONTROL` + `h`                        | Move window left                                                       |
|                                   | `SUPER` + `CONTROL` + `l`                        | Move window right                                                      |
|                                   | `SUPER` + `CONTROL` + `k`                        | Move window up                                                         |
|                                   | `SUPER` + `CONTROL` + `j`                        | Move window down                                                       |
| Switch Workspaces                 | `SUPER` + `[0-9]`                                | Switch to workspace `[0-9]`                                            |
| Move Window to Workspace          | `SUPER` + `SHIFT` + `[0-9]`                      | Move active window to workspace `[0-9]`                                |
| Move Window Silently to Workspace | `SUPER` + `ALT` + `[0-9]`                        | Move window silently to workspace `[0-9]`                              |
| Scroll through Workspaces         | `SUPER` + `mouse_down`                           | Scroll to next workspace                                               |
|                                   | `SUPER` + `mouse_up`                             | Scroll to previous workspace                                           |
| Move/Resize Window                | `SUPER` + `LMB/RMB`                              | Drag to move or resize window                                          |
| Audio Control                     | `F9`                                             | Toggle audio mute                                                      |
|                                   | `F10`                                            | Decrease volume                                                        |
|                                   | `F11`                                            | Increase volume                                                        |
| Brightness                        | `F2`                                             | Decrease screen brightness.                                            |
| Brightness                        | `F3`                                             | Increase screen brightness.                                            |
| Toggle nightlight mode            | `SUPER` + `F1`, `SUPER` + `F2` && `SUPER` + `F3` | Decrease, Increase night light & set to default (6000k) using SUPER F3 |

For more, just visit the `~/.config/hypr/configs/keybinds.conf` file.

## Contribute.

<h4>
If you want to add your ideas in this project, just do some steps.
</h4>

1. Fork this repository. Make sure to uncheck the `Copy the main branch only`. This will also copy other branches ( if available ).
2. Now clone the forked repository in you machine. <br> Example command:

```
git clone --depth=1 https://github.com/your_user_name/hyprconf.git
```

3. Create a branch by your user_name. <br> Example command:

```
git checkout -b your_user_name
```

4. Now add your ideas and commit to github. <br> Make sure to commit with a detailed test message. For example:

```
git commit -m "fix: Fixed a but in the "example.sh script"
```

```
git commit -m "add: Added this feature. This will happen if the user do this."
```

```
git commit -m "delete: Deleted this. It was creating this example problem"
```

4. While pushing the new commits, make sure to push it to your branch. <br> For example:

```
git push origin your_branch_name
```

5. Now you can create a pull request in the main repository.<br> But make sure to create the pull request in the `development` branch, no the `main` branch.

### Thats all about contributing.

## Reference

#### I would like to thank [JaKooLit](https://github.com/JaKooLit). I was inspired from his Hyprland installation scripts and prepared my script. I took and modified some of his scripts and used here.
