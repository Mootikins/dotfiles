# Crucible AI Agents

This directory contains shared tools, contexts, workflows, and configurations for AI agents working on the Crucible project.

## Directory Structure

```
.agents/
├── commands/          # AI agent commands (markdown files)
│   ├── review-code.md
│   ├── write-tests.md
│   ├── refactor-code.md
│   ├── analyze-architecture.md
│   └── generate-docs.md
├── tools/             # AI agent tools and guides
│   ├── codebase-analysis.md
│   └── development-workflows.md
├── contexts/          # Project context for AI agents
│   └── project-context.md
├── workflows/         # Detailed workflow guides
│   └── feature-development.md
└── config/            # Agent configuration files
    ├── mcp.json
    └── agents.json
```

## Supported AI Agents

### Cursor
- **Commands**: `.cursor/commands/` (symlinked to `.agents/commands/`)
- **Configuration**: Uses `.cursor/agents/` (symlinked to `.agents/`)
- **Usage**: Type `/` in Cursor chat to see available commands

### Claude
- **Commands**: `.claude/commands/` (symlinked to `.agents/commands/`)
- **Configuration**: Uses `.claude/agents/` (symlinked to `.agents/`)
- **Usage**: Commands available in Claude's interface

### Crush
- **Commands**: `.crush/commands/` (symlinked to `.agents/commands/`)
- **Configuration**: Uses `.crush/agents/` (symlinked to `.agents/`)
- **Usage**: Commands available in Crush's interface

## Available Commands

- **review-code.md** - Code review and quality analysis
- **write-tests.md** - Generate comprehensive tests
- **refactor-code.md** - Refactor following project patterns
- **analyze-architecture.md** - Architecture analysis
- **generate-docs.md** - Generate documentation

## Windows Compatibility

If symlinks don't work on Windows, you can:

1. **Copy files manually**:
   ```bash
   # Copy commands to each agent directory
   cp .agents/commands/*.md .cursor/commands/
   cp .agents/commands/*.md .claude/commands/
   cp .agents/commands/*.md .crush/commands/
   ```

2. **Enable Git symlinks**:
   ```bash
   git config core.symlinks true
   ```

3. **Use WSL or Unix-like environment**

## Adding New Agents

To add support for a new AI agent:

1. Create the agent directory: `.your-agent/`
2. Create commands directory: `.your-agent/commands/`
3. Create symlinks:
   ```bash
   ln -sf ../.agents .your-agent/agents
   ln -sf ../../.agents/commands/*.md .your-agent/commands/
   ```

## Development

- Commands are stored in `.agents/commands/` and symlinked to agent directories
- All agents share the same command definitions for consistency
- Update commands in `.agents/commands/` to affect all agents
- Agent-specific customizations can be added to individual agent directories

## Troubleshooting

- **Symlinks not working**: Check if your system supports symlinks
- **Commands not appearing**: Restart your AI agent client
- **Permission issues**: Ensure proper file permissions on the `.agents` directory
