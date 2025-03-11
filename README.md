# Alacritty deb package

## Install

```bash
sudo apt install alacritty_<x.xx.x>_amd64.deb
```

## Uninstall

```bash
sudo apt remove alacritty
```

## Configuration

[Install Fonts](https://docs.atticux.me/OS/Ubuntu/Terminal/#install-fonts)

```bash
mkdir -p ~/.config/alacritty
cp ./alacritty.toml ~/.config/alacritty/alacritty.toml
```

## Emoji

```bash
sudo apt install fonts-noto-color-emoji
mkdir -p ~/.config/fontconfig
cp ./fonts.conf ~/.config/fontconfig/fonts.conf
fc-cache -f -v
```

Restart Alacritty

> Ref: https://github.com/alacritty/alacritty/issues/4692#issuecomment-855363642
