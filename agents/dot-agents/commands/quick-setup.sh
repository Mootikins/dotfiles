#!/bin/bash
# Quick setup for immediate AI agent compatibility
# Run this after cloning or when setting up a new environment

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$(dirname "$SCRIPT_DIR")")"

echo "🚀 Quick AI Agent Setup for Crucible"
echo "====================================="

# Run the main setup script
"$SCRIPT_DIR/setup-agents.sh"

echo ""
echo "📋 Next Steps:"
echo "1. Restart your AI agent client (Cursor, Claude, etc.)"
echo "2. The agent should now have access to Crucible's tools and context"
echo "3. Try asking the agent about the project structure or to help with development"
echo ""
echo "🔧 Manual Setup (if needed):"
echo "  For Cursor: Restart Cursor completely"
echo "  For Claude: Refresh the conversation or restart the app"
echo "  For other agents: Check their documentation for config reload instructions"
echo ""
echo "📚 Available Tools:"
echo "  - .agents/tools/ - Code analysis and development workflows"
echo "  - .agents/contexts/ - Project context and guidelines"
echo "  - .agents/workflows/ - Feature development processes"
echo "  - .agents/config/ - Agent configurations and MCP settings"
