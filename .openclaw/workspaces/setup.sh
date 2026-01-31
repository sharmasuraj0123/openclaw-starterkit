#!/usr/bin/env bash
# ==============================================================
# OpenClaw Setup Script for Linux
# Installs OpenClaw CLI and starts the gateway auto-runner.
# Usage: ./setup.sh
# ==============================================================

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
GATEWAY_SCRIPT="$SCRIPT_DIR/gateway.sh"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

log() { echo -e "[$(date '+%Y-%m-%d %H:%M:%S')] $*"; }
log_success() { log "${GREEN}✓ $*${NC}"; }
log_warn() { log "${YELLOW}⚠ $*${NC}"; }
log_error() { log "${RED}✗ $*${NC}"; }

# --- Step 1: Install OpenClaw CLI ---
log "Installing OpenClaw CLI..."
if curl -fsSL https://openclaw.ai/install.sh | bash; then
    log_success "OpenClaw CLI installed successfully"
else
    log_error "Failed to install OpenClaw CLI"
    exit 1
fi

# Reload shell environment to pick up new PATH entries
export PATH="$HOME/.local/bin:$HOME/.openclaw/bin:$PATH"

# Verify installation
if command -v openclaw &> /dev/null; then
    log_success "OpenClaw CLI is available: $(which openclaw)"
else
    log_warn "OpenClaw CLI not found in PATH. You may need to restart your shell."
    log_warn "Attempting to source common profile files..."

    # Try to source common shell profiles
    [ -f "$HOME/.bashrc" ] && source "$HOME/.bashrc" 2>/dev/null || true
    [ -f "$HOME/.zshrc" ] && source "$HOME/.zshrc" 2>/dev/null || true
    [ -f "$HOME/.profile" ] && source "$HOME/.profile" 2>/dev/null || true
fi

# --- Step 2: Ensure gateway.sh has correct permissions ---
log "Setting up gateway script permissions..."

if [ -f "$GATEWAY_SCRIPT" ]; then
    # Ensure the script is executable
    chmod +x "$GATEWAY_SCRIPT"
    log_success "Set executable permission on gateway.sh"

    # Verify permissions
    if [ -x "$GATEWAY_SCRIPT" ]; then
        log_success "gateway.sh is executable"
    else
        log_error "Failed to set executable permission on gateway.sh"
        exit 1
    fi
else
    log_error "gateway.sh not found at $GATEWAY_SCRIPT"
    exit 1
fi

# --- Step 3: Run the gateway script ---
log "Starting OpenClaw Gateway..."
exec "$GATEWAY_SCRIPT" start
