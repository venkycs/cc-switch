# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

**Claude Code Switch (cc-switch)** is a utility for developers to switch between multiple Claude Pro Profiles and Service Providers (OpenRouter) in Claude Code IDE.

**Supported Modes:**
1. **Profile**: Switch between Claude Pro accounts via Keychain.
2. **Provider**: Use OpenRouter as the API provider.

## Repository Structure

```
cc-switch/
├── ccs                 # Core script - Main implementation
├── install.sh          # Installer - Sets up shell functions
├── README.md           # Documentation
├── LICENSE             # MIT License
└── CLAUDE.md           # Development guidance
```

## Key Commands

### Development
- `install.sh`: Installs the `ccs` function to `~/.zshrc` or `~/.bashrc`.
- `ccs`: The main script handling logic.

### Usage
- `ccs list`: List saved profiles.
- `ccs save <name>`: Save current profile.
- `ccs use <name>`: Switch to a profile.
- `ccs openrouter`: Switch to OpenRouter.
- `ccs status`: Show current status.

## Design

- **Configuration**: Uses `~/.cc-switch_config` for provider API keys.
- **Credential Storage**: Uses macOS Keychain (`security` CLI) for profile credentials.
- **Environment**: Manipulates `ANTHROPIC_*` environment variables for provider switching.

## Contributing

- Keep the script zero-dependency (bash only).
- Ensure output designed for `eval` is cleanly separated from logs (stdout vs stderr).
