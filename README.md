# OpenClaw Starter Kit

A starter template for setting up OpenClaw, an AI agent platform with gateway auto-runner functionality.

[![Open in XO Workspaces](https://img.shields.io/badge/Open%20in-XO%20Workspaces-blue?style=for-the-badge&logo=data:image/x-icon;base64,AAABAAEAEBAAAAEAIABoBAAAFgAAACgAAAAQAAAAIAAAAAEAIAAAAAAAAAQAABILAAASCwAAAAAAAAAAAAD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A)](https://beta.xo.builders)

### Watch the Demo

<a href="https://www.loom.com/share/225bde59342c4efcb8526e644cc129bd" target="_blank">
  <img src="https://cdn.loom.com/sessions/thumbnails/225bde59342c4efcb8526e644cc129bd-438076eb7ea3e272-full-play.gif" alt="Watch the demo" width="100%">
</a>

### Getting Started in XO Workspaces

1. **Visit XO** - Go to <a href="https://beta.xo.builders" target="_blank">https://beta.xo.builders</a>
2. **Open Board** - Navigate to your XO Board
3. **Code Tab** - Click on the Code tab
4. **Open in IDE** - Click to open in **VS Code** or **Cursor**, depending on your preference
5. **Run Setup** - In your terminal:
   ```bash
   cd ~/.openclaw
   ./setup.sh
   ```
6. Follow the prompts and setup is complete!

> ⚠️ **IMPORTANT NOTE**
>
> These Sandboxes are designed for **experimentation only** and are set for **automatic shutdown in 24 hours**.
>
> If you need your sandbox to keep running beyond this period, please reach out to the <a href="https://xo.builders" target="_blank">XO team</a>.

---

## Quick Start (Local Installation)

### Option 1: Clone as `.openclaw` folder (Recommended)

Clone this repository directly into a `.openclaw` folder in your project:

```bash
# Navigate to your project root
cd /path/to/your/project

# Clone directly into .openclaw folder
git clone https://github.com/sharmasuraj0123/openclaw-starterkit.git .openclaw

# Run setup
cd .openclaw
chmod +x setup.sh
./setup.sh
```

### Option 2: Clone into existing `.openclaw` folder

If you already have a `.openclaw` folder (must be empty or have no conflicting files):

```bash
cd /path/to/your/project/.openclaw
git clone https://github.com/sharmasuraj0123/openclaw-starterkit.git .
chmod +x setup.sh
./setup.sh
```

## Repository Structure

```
.
├── setup.sh              # Main setup script (run this first)
├── gateway.sh            # Gateway auto-runner with crash recovery
├── openclaw.json         # Main OpenClaw configuration
├── config.json           # Agent configuration
├── agents/
│   └── default.json      # Default agent settings
├── prompts/
│   └── system.md         # System prompt template
├── tools/
│   └── example-tool.json # Example custom tool definition
├── canvas/
│   └── index.html        # Interactive canvas test page
├── cron/
│   └── jobs.json         # Scheduled jobs configuration
├── devices/
│   ├── paired.json       # Paired devices registry
│   └── pending.json      # Pending device pairings
├── identity/
│   └── device.json       # Device identity (generated)
├── workspace/
│   ├── AGENTS.md         # Agent workspace guidelines
│   ├── BOOTSTRAP.md      # First-run setup guide
│   ├── HEARTBEAT.md      # Periodic task configuration
│   ├── IDENTITY.md       # Agent identity template
│   ├── SOUL.md           # Agent personality/behavior
│   ├── TOOLS.md          # Local tool notes
│   └── USER.md           # User information template
├── CLAUDE.md             # Instructions for Claude Code
├── AGENTS.md             # Documentation for AI agents
└── README.md             # This file
```

## Setup Script

The `setup.sh` script automates the installation process:

1. Installs the OpenClaw CLI via `curl -fsSL https://openclaw.ai/install.sh | bash`
2. Sets correct permissions on `gateway.sh`
3. Starts the gateway auto-runner

```bash
chmod +x setup.sh
./setup.sh
```

## Gateway Management

The `gateway.sh` script manages the OpenClaw gateway with automatic restart on crashes:

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

### Gateway Configuration

Edit these variables at the top of `gateway.sh`:

| Variable | Default | Description |
|----------|---------|-------------|
| `OPENCLAW_GATEWAY_PORT` | `18789` | Gateway listen port (env var) |
| `RESTART_DELAY` | `5` | Seconds before restart attempt |
| `MAX_RESTARTS` | `10` | Max consecutive restarts |
| `RESTART_WINDOW` | `300` | Seconds of uptime to reset counter |

### Log Files

- Gateway logs: `/tmp/openclaw-gateway.log`
- PID file: `/tmp/openclaw-gateway.pid`

## Configuration

### openclaw.json

The main OpenClaw configuration file controls:
- Gateway settings (port, auth, mode)
- Agent defaults (concurrency, workspace path)
- Message handling preferences
- Skills installation settings

### config.json

Agent-specific configuration for:
- Model selection and parameters
- Enabled tools and permissions
- Custom tool paths

### Workspace

The `workspace/` folder contains agent personality and memory files:
- **SOUL.md** - Core agent personality and behavior guidelines
- **IDENTITY.md** - Agent name, vibe, and avatar
- **USER.md** - Information about the human user
- **BOOTSTRAP.md** - First-run onboarding guide
- **HEARTBEAT.md** - Periodic task checklist
- **TOOLS.md** - Local tool configurations

### Agents

Define different agent configurations in `agents/` for various use cases. Each agent can have:
- Custom model settings
- Specific system prompts
- Enabled tool sets
- Context preferences

### Prompts

Store reusable system prompts in `prompts/`. Reference them from agent configurations.

### Tools

Add custom tool definitions in `tools/` to extend agent functionality. Follow the JSON schema in `example-tool.json`.

## Manual CLI Installation

If you need to install the OpenClaw CLI separately:

```bash
curl -fsSL https://openclaw.ai/install.sh | bash
```

## Troubleshooting

### Permission Denied
```bash
chmod +x setup.sh gateway.sh
```

### Gateway Won't Start
1. Check if port is in use: `lsof -i :18789`
2. View logs: `./gateway.sh logs`
3. Kill orphaned processes: `pkill -f "openclaw gateway"`

### CLI Not Found After Install
```bash
export PATH="$HOME/.local/bin:$HOME/.openclaw/bin:$PATH"
# Or restart your shell
exec $SHELL
```

## License

MIT
