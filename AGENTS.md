# AGENTS.md

Documentation for AI agents and LLMs working with this OpenClaw Starter Kit repository.

## Quick Start for Agents

### 1. Setup the Environment
```bash
# Make setup script executable and run it
chmod +x setup.sh
./setup.sh
```

This will:
- Install the OpenClaw CLI from `https://openclaw.ai/install.sh`
- Set executable permissions on all scripts
- Start the gateway auto-runner

### 2. Verify Installation
```bash
# Check if OpenClaw CLI is installed
openclaw --version

# Check gateway status
./gateway.sh status
```

## File Descriptions

| File | Purpose |
|------|---------|
| `setup.sh` | Main entry point - installs CLI and starts gateway |
| `gateway.sh` | Gateway daemon with auto-restart |
| `config.json` | Core configuration (model, tools, permissions) |
| `agents/default.json` | Default agent persona and settings |
| `prompts/system.md` | System prompt template for agents |
| `tools/example-tool.json` | Example custom tool definition |

## Gateway Operations

The gateway is managed via `gateway.sh`:

| Command | Description |
|---------|-------------|
| `start` | Start gateway (default if no argument) |
| `stop` | Stop gateway and all child processes |
| `restart` | Stop then start gateway |
| `status` | Show running status and PID |
| `logs` | Tail the gateway log file |

### Gateway Configuration

Located at the top of `gateway.sh`:

```bash
GATEWAY_PORT="${OPENCLAW_GATEWAY_PORT:-18789}"  # Default port
RESTART_DELAY=5        # Seconds before restart attempt
MAX_RESTARTS=10        # Max consecutive restarts
RESTART_WINDOW=300     # Seconds of uptime to reset counter
```

### Log Files
- Gateway logs: `/tmp/openclaw-gateway.log`
- PID file: `/tmp/openclaw-gateway.pid`

## Agent Configuration Schema

### `config.json`
```json
{
  "version": "1.0",
  "model": "claude-sonnet-4-20250514",
  "maxTokens": 8192,
  "tools": {
    "enabled": ["filesystem", "web", "code"],
    "custom": ["./tools/example-tool.json"]
  },
  "permissions": {
    "allowFileWrite": true,
    "allowNetworkAccess": true,
    "allowCommandExecution": true
  }
}
```

### `agents/default.json`
```json
{
  "name": "default",
  "description": "Default agent configuration",
  "model": "claude-sonnet-4-20250514",
  "systemPrompt": "../prompts/system.md",
  "tools": [],
  "context": {
    "maxContextLength": 100000,
    "includeFileTree": true,
    "includeGitStatus": true
  }
}
```

## Creating Custom Agents

1. Create a new file in `agents/`:
```json
{
  "name": "my-agent",
  "description": "Custom agent for specific tasks",
  "model": "claude-sonnet-4-20250514",
  "systemPrompt": "../prompts/my-prompt.md",
  "tools": ["filesystem", "web"],
  "context": {
    "maxContextLength": 50000,
    "includeFileTree": true,
    "includeGitStatus": false
  }
}
```

2. Create the corresponding prompt in `prompts/my-prompt.md`

3. Reference the agent in your OpenClaw commands

## Creating Custom Tools

1. Create a new file in `tools/`:
```json
{
  "name": "my-tool",
  "description": "Description of what this tool does",
  "parameters": {
    "type": "object",
    "properties": {
      "input": {
        "type": "string",
        "description": "Input parameter"
      }
    },
    "required": ["input"]
  }
}
```

2. Add the tool path to your agent's `tools` array or `config.json`

## Troubleshooting

### Permission Denied on Scripts
```bash
chmod +x setup.sh
chmod +x gateway.sh
```

### Gateway Won't Start
1. Check if port is in use: `lsof -i :18789`
2. Check logs: `./gateway.sh logs`
3. Kill orphaned processes: `pkill -f "openclaw gateway"`

### CLI Not Found After Install
```bash
# Add to PATH manually
export PATH="$HOME/.local/bin:$HOME/.openclaw/bin:$PATH"

# Or restart your shell
exec $SHELL
```

## Environment Variables

| Variable | Default | Description |
|----------|---------|-------------|
| `OPENCLAW_GATEWAY_PORT` | `18789` | Gateway listen port |

## Best Practices for Agents

1. **Always check gateway status** before running operations
2. **Use the provided scripts** rather than running CLI commands directly
3. **Check logs** when debugging issues
4. **Don't modify** `/tmp/openclaw-gateway.pid` directly
5. **Restart gateway** after configuration changes
