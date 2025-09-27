# AI Agents Configuration

This document explains the AI agents configuration in the dotfiles repository, including the symlink structure and setup for different AI tools.

## Directory Structure

The agents configuration follows a dual-level approach:

### Global Agent Configuration (Shared)
```
agents/
├── dot-agents/          # Main shared agent resources (commands, tools, contexts, workflows, config)
│   ├── commands/        # AI agent commands (markdown files)
│   ├── tools/           # AI agent tools and guides
│   ├── contexts/        # Project context for AI agents
│   ├── workflows/       # Detailed workflow guides
│   └── config/          # Agent configuration files
├── dot-claude/          # Claude-specific global configuration with symlinks to dot-agents
│   ├── commands -> ../dot-agents/commands
│   ├── config -> ../dot-agents/config
│   ├── contexts -> ../dot-agents/contexts
│   ├── tools -> ../dot-agents/tools
│   ├── workflows -> ../dot-agents/workflows
│   └── (other Claude-specific files)
├── dot-cursor/          # Cursor-specific global configuration with symlinks to dot-agents
│   ├── commands -> ../dot-agents/commands
│   ├── config -> ../dot-agents/config
│   ├── contexts -> ../dot-agents/contexts
│   ├── tools -> ../dot-agents/tools
│   ├── workflows -> ../dot-agents/workflows
│   └── (other Cursor-specific files)
└── dot-crush/           # Crush-specific global configuration with symlinks to dot-agents
    ├── commands -> ../dot-agents/commands
    ├── config -> ../dot-agents/config
    ├── contexts -> ../dot-agents/contexts
    ├── tools -> ../dot-agents/tools
    ├── workflows -> ../dot-agents/workflows
    └── (other Crush-specific files)
```

### Project-Level Agent Configuration
```
.claude/                 # Project-level Claude configuration
├── commands -> ../agents/dot-agents/commands   # Symlink to shared commands
├── settings.local.json  # Claude-specific project settings
└── (other Claude-specific project files)
```

## Symlink Structure

The system uses a two-tier approach:
1. Global shared resources in `agents/dot-agents/`
2. Agent-specific global configurations in `agents/dot-{agent}/` that symlink to the shared resources
3. Project-level configurations in root `.agent/` directories that symlink to the appropriate global resources

This allows:
- Centralized management of shared commands and configurations
- Agent-specific global customizations
- Project-specific configurations
- Consistent experience across different AI tools
- Easy updates that apply broadly when needed

## Claude Integration

The Claude integration is managed through two levels:
1. Global Claude configuration in `agents/dot-claude/` with symlinks to shared resources
2. Project-level Claude configuration in the root `.claude/` directory, which includes:
   - A symlink to the shared commands: `commands -> ../agents/dot-agents/commands`
   - Project-specific settings in `settings.local.json`
   - Other Claude-specific project files

## Troubleshooting

If symlinks are not working properly:
1. Check that your system supports symlinks
2. Verify the target paths exist and are accessible
3. Ensure proper permissions on the directories
4. On Windows, consider enabling developer mode or using WSL for full symlink support