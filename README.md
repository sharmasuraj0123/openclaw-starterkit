# Openclaw Starter Kit

A starter template for setting up Openclaw configuration in your projects.

## Structure

```
.openclaw/
├── config.json          # Main configuration file
├── agents/
│   └── default.json     # Default agent configuration
├── prompts/
│   └── system.md        # System prompt template
└── tools/
    └── example-tool.json # Example custom tool definition
```

## Getting Started

1. Clone this repository
2. Customize `.openclaw/config.json` with your settings
3. Modify the system prompt in `.openclaw/prompts/system.md`
4. Add custom tools in `.openclaw/tools/`

## Configuration

### config.json

The main configuration file controls:
- Model selection and parameters
- Enabled tools and permissions
- Hooks for pre/post commit actions

### Agents

Define different agent configurations in `.openclaw/agents/` for various use cases.

### Tools

Add custom tool definitions in `.openclaw/tools/` to extend functionality.

## License

MIT
