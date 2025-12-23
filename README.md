# Claude Code Switch (cc-switch) 🔧

> A streamlined tool to switch between Claude Pro Profiles and Service Providers (OpenRouter) for [Claude Code](https://docs.anthropic.com/en/docs/agents-and-tools/claude-code/overview).

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

## 🌟 Features

- 👤 **Profile Management**: Manage and switch between multiple Claude Pro accounts/profiles configured in your Keychain.
- 🔌 **Service Provider Support**: configure and use **OpenRouter** as a backend provider for Claude Code.
- ⚡ **Zero Dependencies**: Pure Bash script (except for `curl` and standard system tools).

## 🛠️ Installation

### Quick Install (Local)

1. Clone the repository:
   ```bash
   git clone https://github.com/foreveryh/claude-code-switch.git cc-switch
   cd cc-switch
   ```

2. Run the installer:
   ```bash
   ./install.sh
   source ~/.zshrc  # or ~/.bashrc
   ```

### Manual Install

Copy `ccs` to your path (e.g., `~/.local/bin/`) and make it executable.

## 📖 Usage

### Profile Management (Claude Pro)

Manage multiple Claude Pro logins (stored in macOS Keychain).

```bash
# list saved profiles
ccs list

# Save current CLI login as a profile
ccs save work

# Switch to a profile
ccs use work

# Delete a profile
ccs del work
```

### Service Providers

Use OpenRouter as the API provider.

```bash
# Switch to OpenRouter
# (Requires OPENROUTER_API_KEY to be set in config or env)
ccs openrouter
```

### Checks
```bash
# Check current status/mode
ccs status
```

## ⚙️ Configuration

The tool uses `~/.cc-switch_config` for persistent configuration.

```bash
# ~/.cc-switch_config
OPENROUTER_API_KEY=sk-or-your-key
OPENROUTER_MODEL=anthropic/claude-3.5-sonnet
```

You can also set these as environment variables in your shell.

## 🤝 Contributing

Issues and Pull Requests are welcome!

## 📄 License

This project is licensed under the [MIT License](LICENSE).
