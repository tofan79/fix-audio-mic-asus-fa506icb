# ASUS TUF A15 FA506ICB Audio/Mic Fix

Audio and microphone fix for ASUS TUF Gaming A15 FA506ICB with Realtek ALC256 codec on Linux.

## Problem

On Arch Linux / CachyOS with PipeWire, the audio and microphone on ASUS TUF A15 FA506ICB have issues:
- Microphone levels too low or fluctuating
- Auto-mute not working properly
- No auto-switch between speaker/headphone and mic when plugging/unplugging headset

## Solution

This fix provides:
- Stable mic capture levels (45/63)
- Internal Mic Boost set to level 1 (10dB)
- Headset Mic Boost set to level 1 (10dB)
- Master volume at 87/87 (100%)
- Auto-mute enabled for headphone jack detection
- Auto-switch speaker/headphone based on headphone jack
- Auto-switch internal mic/headset mic based on headphone jack

## Installation

```bash
git clone https://github.com/tofan79/fix-audio-mic-asus-fa506icb.git
cd fix-audio-mic-asus-fa506icb
./install.sh
```

## What's Installed

| File | Location | Purpose |
|------|----------|---------|
| `alsa-soft-mixer.conf` | `~/.config/wireplumber/wireplumber.conf.d/` | WirePlumber soft-mixer rule for ALC256 |
| `fix-asus-audio.sh` | `~/.local/bin/` | Main audio fix script |
| `fix-asus-audio.service` | `~/.config/systemd/user/` | Systemd service to apply fix on boot |
| `fix-audio-watcher.service` | `~/.config/systemd/user/` | Watcher for headphone jack changes |

## How It Works

1. **WirePlumber soft-mixer** - Enables ALSA soft-mixer for the audio card
2. **Boot service** - Applies audio levels on startup (with 2s delay for PipeWire)
3. **Watcher service** - Monitors `pactl subscribe` for card changes and re-applies fix when headphone jack is plugged/unplugged

## Manual Usage

```bash
# Apply fix manually
~/.local/bin/fix-asus-audio.sh

# Check service status
systemctl --user status fix-asus-audio.service
systemctl --user status fix-audio-watcher.service

# Restart services
systemctl --user restart fix-asus-audio.service
systemctl --user restart fix-audio-watcher.service
```

## Tested On

- **Hardware**: ASUS TUF Gaming A15 FA506ICB
- **Audio Codec**: Realtek ALC256
- **Distro**: CachyOS (Arch-based)
- **Audio Stack**: PipeWire + WirePlumber

## Uninstall

```bash
systemctl --user disable --now fix-asus-audio.service
systemctl --user disable --now fix-audio-watcher.service
rm ~/.config/systemd/user/fix-asus-audio.service
rm ~/.config/systemd/user/fix-audio-watcher.service
rm ~/.local/bin/fix-asus-audio.sh
rm ~/.config/wireplumber/wireplumber.conf.d/alsa-soft-mixer.conf
systemctl --user daemon-reload
```

## License

MIT
