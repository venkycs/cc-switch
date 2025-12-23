# Claude Code Switch (cc-switch) 🔧

> Switch between multiple Claude Pro accounts and OpenRouter instantly.

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

## ✨ Features

If you use [Claude Code](https://docs.anthropic.com/en/docs/agents-and-tools/claude-code/overview), you might need to:
1.  **Switch Accounts**: Toggle between Personal and Work Claude Pro subscriptions.
2.  **Use API Providers**: Switch to OpenRouter for access to other models or billing.
3.  **Bypass Permissions**: Quickly run safe commands without constant approval checks.

**cc-switch** solves this with a simple `ccs` command.

## 📦 Installation

```bash
```bash
# One-line install
curl -fsSL https://raw.githubusercontent.com/venkycs/cc-switch/main/install.sh | bash

# Reload Shell
source ~/.zshrc  # or ~/.bashrc
```
```

## 🎮 Usage

### 1. Manage Profiles (Claude Pro)

Easily save and switch between different Claude accounts stored in your Keychain.

```bash
# Login and save a new profile (Interactive)
ccs login work

# Switch to 'work' profile
ccs use work

# List saved profiles
ccs list
```

### 2. Use OpenRouter

Switch to OpenRouter API backend.

```bash
# Set your key once
ccs set-key sk-or-your-key-here

# Switch to OpenRouter
ccs openrouter
```

### 3. Shortcut for Claude (`c`)

We added a super-short command `c` to run Claude Code faster (skipping permission checks).

Instead of typing:
```bash
claude --dangerously-skip-permissions
```

Just type:
```bash
c
```
(You can also pass arguments, e.g., `c "fix this bug"`)

### 4. Updates & Status

```bash
# Update to latest version
ccs update

# Check status
ccs status
```

## 📚 Documentation
For detailed architecture and how it works under the hood, check out [docs/ARCHITECTURE.md](docs/ARCHITECTURE.md).

## 📄 License
[MIT](LICENSE)

## ⚠️ Disclaimer
**Use `ccs run` (or the `--dangerously-skip-permissions` flag) at your own risk.**
This tool switches authentication contexts and environment variables. While it aims to be safe, modifying your shell environment and running AI agents with permission overrides can have unintended consequences. The authors are not responsible for any data loss or issues arising from the use of this tool. Always review what the AI is doing.
