#!/bin/bash
# Setup script for AI agent compatibility
# Creates symlinks from various agent directories to .agents

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$(dirname "$SCRIPT_DIR")")"
AGENTS_DIR="$PROJECT_ROOT/.agents"

echo "🤖 Setting up AI agent compatibility for Crucible project"
echo "Project root: $PROJECT_ROOT"
echo "Agents directory: $AGENTS_DIR"

# Function to create symlink if target doesn't exist
create_symlink() {
    local target="$1"
    local link="$2"
    
    if [ -e "$link" ] && [ ! -L "$link" ]; then
        echo "⚠️  Warning: $link exists and is not a symlink. Skipping."
        return 1
    fi
    
    if [ -L "$link" ]; then
        echo "✅ $link already exists"
        return 0
    fi
    
    # Create parent directory if it doesn't exist
    mkdir -p "$(dirname "$link")"
    
    # Create relative symlink
    local rel_path="$(realpath --relative-to="$(dirname "$link")" "$target")"
    ln -sf "$rel_path" "$link"
    echo "✅ Created symlink: $link -> $rel_path"
}

# Function to create command symlinks for specific agents
create_command_symlinks() {
    local agent="$1"
    local agent_dir="$PROJECT_ROOT/.$agent"
    local commands_dir="$agent_dir/commands"
    
    if [ ! -d "$AGENTS_DIR/$agent/commands" ]; then
        echo "⚠️  No commands directory found for $agent"
        return 0
    fi
    
    # Create commands directory if it doesn't exist
    mkdir -p "$commands_dir"
    
    # Create symlinks for each command file
    for cmd_file in "$AGENTS_DIR/$agent/commands"/*.md; do
        if [ -f "$cmd_file" ]; then
            local cmd_name="$(basename "$cmd_file")"
            create_symlink "$cmd_file" "$commands_dir/$cmd_name"
        fi
    done
}

# Common AI agent directories (main agents directory)
AGENTS=(
    ".cursor/agents"
    ".claude/agents" 
    ".gpt/agents"
    ".copilot/agents"
    ".crush/agents"
    ".anthropic/agents"
    ".openai/agents"
    ".github/agents"
    ".vscode/agents"
    ".codeium/agents"
    ".tabnine/agents"
    ".kite/agents"
    ".sourcery/agents"
    ".deepcode/agents"
    ".intellicode/agents"
)

# Agents that support commands (for Cursor, Claude, etc.)
COMMAND_AGENTS=(
    "cursor"
    "claude"
    "gpt"
    "copilot"
    "crush"
    "anthropic"
    "openai"
    "github"
    "vscode"
    "codeium"
    "tabnine"
    "kite"
    "sourcery"
    "deepcode"
    "intellicode"
)

echo ""
echo "Creating symlinks for AI agent compatibility..."

# Create main agents directory symlinks
for agent in "${AGENTS[@]}"; do
    create_symlink "$AGENTS_DIR" "$PROJECT_ROOT/$agent"
done

echo ""
echo "Creating command symlinks for supported agents..."

# Create command symlinks for agents that support them
for agent in "${COMMAND_AGENTS[@]}"; do
    create_command_symlinks "$agent"
done

echo ""
echo "🎉 AI agent setup complete!"
echo ""
echo "Available agents can now access Crucible's AI tools at:"
echo "  - .agents/ (main directory)"
echo "  - .cursor/agents/ (with commands in .cursor/commands/)"
echo "  - .claude/agents/ (with commands in .claude/commands/)"
echo "  - .gpt/agents/ (with commands in .gpt/commands/)"
echo "  - .copilot/agents/ (with commands in .copilot/commands/)"
echo "  - .crush/agents/ (with commands in .crush/commands/)"
echo "  - And more..."
echo ""
echo "Commands available:"
echo "  - review-code.md - Code review and quality analysis"
echo "  - write-tests.md - Generate comprehensive tests"
echo "  - refactor-code.md - Refactor following project patterns"
echo "  - analyze-architecture.md - Architecture analysis"
echo "  - generate-docs.md - Generate documentation"
echo ""
echo "To add a new agent, run:"
echo "  ln -sf ../.agents .your-agent/agents"
echo "  # Then create commands if supported:"
echo "  mkdir -p .your-agent/commands"
echo "  ln -sf ../../.agents/your-agent/commands/*.md .your-agent/commands/"
echo ""
echo "To remove an agent, run:"
echo "  rm .your-agent/agents"
