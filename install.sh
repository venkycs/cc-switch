#!/usr/bin/env bash
set -euo pipefail

# Installer for Claude Code Switch (cc-switch)
# - Writes a cc-switch() function into your shell rc

# GitHub repository info
GITHUB_REPO="venkycs/cc-switch"
GITHUB_BRANCH="main"
GITHUB_RAW="https://raw.githubusercontent.com/${GITHUB_REPO}/${GITHUB_BRANCH}"

# Detect if running from local directory
if [[ -n "${BASH_SOURCE[0]:-}" ]] && [[ -f "${BASH_SOURCE[0]}" ]]; then
  SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
  LOCAL_MODE=true
else
  SCRIPT_DIR=""
  LOCAL_MODE=false
fi

# Install destination
INSTALL_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/cc-switch"
DEST_SCRIPT_PATH="$INSTALL_DIR/ccs"
BEGIN_MARK="# >>> ccs function begin >>>"
END_MARK="# <<< ccs function end <<<"

detect_rc_file() {
  local shell_name="${SHELL##*/}"
  case "$shell_name" in
    zsh) echo "$HOME/.zshrc" ;;
    bash) echo "$HOME/.bashrc" ;;
    *) echo "$HOME/.zshrc" ;;
  esac
}

remove_existing_block() {
  local rc="$1"
  [[ -f "$rc" ]] || return 0
  if grep -qF "$BEGIN_MARK" "$rc"; then
    local tmp
    tmp="$(mktemp)"
    awk -v b="$BEGIN_MARK" -v e="$END_MARK" '
      $0==b {inblock=1; next}
      $0==e {inblock=0; next}
      !inblock {print}
    ' "$rc" > "$tmp" && mv "$tmp" "$rc"
  fi
}

append_function_block() {
  local rc="$1"
  mkdir -p "$(dirname "$rc")"
  [[ -f "$rc" ]] || touch "$rc"
  cat >> "$rc" <<EOF 2>/dev/null
$BEGIN_MARK
# CCS: define a shell function that applies exports to current shell
unalias ccs 2>/dev/null || true
unset -f ccs 2>/dev/null || true
ccs() {
  local script="$DEST_SCRIPT_PATH"
  if [[ ! -f "\$script" ]]; then
    if [[ -f "\$HOME/.local/share/cc-switch/ccs" ]]; then
       script="\$HOME/.local/share/cc-switch/ccs"
    fi
  fi
  
  if [[ ! -f "\$script" ]]; then
    echo "ccs error: script not found at \$script" >&2
    return 1
  fi

  case "\$1" in
    "use"|"switch"|"openrouter"|"or")
       # Simplify: Always source if we are switching environment
       source "\$script" "\$@"
       ;;
    *)
       "\$script" "\$@"
       ;;
  esac
}

$END_MARK
EOF
}

download_from_github() {
  local url="$1"
  local dest="$2"
  echo "Downloading from $url..."
  if command -v curl >/dev/null 2>&1; then
    curl -fsSL "$url" -o "$dest"
  elif command -v wget >/dev/null 2>&1; then
    wget -qO "$dest" "$url"
  else
    echo "Error: neither curl nor wget found" >&2
    return 1
  fi
}

main() {
  mkdir -p "$INSTALL_DIR"

  if $LOCAL_MODE && [[ -f "$SCRIPT_DIR/bin/ccs" ]]; then
    echo "Installing from local directory..."
    cp -f "$SCRIPT_DIR/bin/ccs" "$DEST_SCRIPT_PATH"
  else
    echo "Installing from GitHub..."
    download_from_github "${GITHUB_RAW}/bin/ccs" "$DEST_SCRIPT_PATH" || {
      echo "Error: failed to download ccs" >&2
      exit 1
    }
  fi

  chmod +x "$DEST_SCRIPT_PATH"

  local rc
  rc="$(detect_rc_file)"
  remove_existing_block "$rc"
  append_function_block "$rc"

  echo "✅ Installed ccs function into: $rc"
  echo "   Script installed to: $DEST_SCRIPT_PATH"
  echo "   Reload your shell or run: source $rc"
  echo ""
  echo "   Then use:"
  echo "     ccs list"
  echo "     ccs list
     ccs openrouter
     c                  # Runs 'claude --dangerously-skip-permissions'"
}

main "$@"
