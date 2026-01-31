# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is the **OpenClaw Starter Kit** - a template repository for setting up and running OpenClaw, an AI agent platform with gateway auto-runner functionality.

## Repository Structure

```
.
├── setup.sh                        # Main setup script (run this first)
├── gateway.sh                      # Gateway auto-runner script
├── CLAUDE.md                       # Instructions for Claude/LLMs
├── AGENTS.md                       # Agent configuration documentation
├── README.md                       # Project documentation
├── config.json                     # Main OpenClaw configuration
├── agents/
│   └── default.json                # Default agent settings
├── prompts/
│   └── system.md                   # System prompt template
└── tools/
    └── example-tool.json           # Custom tool definitions
```

## Commands

### Initial Setup (Linux)
```bash
# Run the setup script - installs OpenClaw CLI and starts gateway
./setup.sh
```

### Gateway Management
```bash
# Start the gateway (auto-restarts on crash)
./gateway.sh start

# Stop the gateway
./gateway.sh stop

# Restart the gateway
./gateway.sh restart

# Check gateway status
./gateway.sh status

# View gateway logs
./gateway.sh logs
```

### Manual OpenClaw CLI Installation
```bash
curl -fsSL https://openclaw.ai/install.sh | bash
```

## Configuration

### Environment Variables
- `OPENCLAW_GATEWAY_PORT` - Gateway port (default: 18789)

### Key Configuration Files
- `config.json` - Main settings (model, tools, permissions)
- `agents/default.json` - Default agent configuration
- `prompts/system.md` - System prompt template

## Architecture

1. **setup.sh** - Entry point that installs the CLI and starts the gateway
2. **gateway.sh** - Daemon script that keeps the gateway running with auto-restart
3. **config.json** - Defines model settings, available tools, and permissions
4. **agents/** - Agent persona configurations
5. **prompts/** - Reusable prompt templates
6. **tools/** - Custom tool definitions

## Common Tasks

### Adding a New Agent
1. Create a new JSON file in `agents/`
2. Define name, description, model, and systemPrompt path
3. Reference it in your OpenClaw configuration

### Adding a Custom Tool
1. Create a new JSON file in `tools/`
2. Define the tool schema following the example in `example-tool.json`
3. Add the tool to the agent's tools array

### Modifying Gateway Settings
Edit the variables at the top of `gateway.sh`:
- `RESTART_DELAY` - Seconds between restart attempts
- `MAX_RESTARTS` - Maximum consecutive restarts before giving up
- `RESTART_WINDOW` - Seconds of uptime to reset restart counter
