#!/usr/bin/env python3
"""
Quick setup for immediate AI agent compatibility
Run this after cloning or when setting up a new environment
"""

import os
import sys
import subprocess
from pathlib import Path

def main():
    print("🚀 Quick AI Agent Setup for Crucible")
    print("=====================================")

    script_dir = Path(__file__).parent
    project_root = script_dir.parent.parent

    # Run the main setup script
    setup_script = script_dir / "setup-agents.py"

    if setup_script.exists():
        try:
            result = subprocess.run([sys.executable, str(setup_script)],
                                 capture_output=True, text=True, cwd=project_root)
            print(result.stdout)
            if result.stderr:
                print("STDERR:", result.stderr)
        except Exception as e:
            print(f"Error running setup script: {e}")
    else:
        print("❌ Setup script not found")
        return 1

    print("")
    print("📋 Next Steps:")
    print("1. Restart your AI agent client (Cursor, Claude, etc.)")
    print("2. The agent should now have access to Crucible's tools and context")
    print("3. Try asking the agent about the project structure or to help with development")
    print("")
    print("🔧 Manual Setup (if needed):")
    print("  For Cursor: Restart Cursor completely")
    print("  For Claude: Refresh the conversation or restart the app")
    print("  For other agents: Check their documentation for config reload instructions")
    print("")
    print("📚 Available Tools:")
    print("  - .agents/tools/ - Code analysis and development workflows")
    print("  - .agents/contexts/ - Project context and guidelines")
    print("  - .agents/workflows/ - Feature development processes")
    print("  - .agents/config/ - Agent configurations and MCP settings")

    return 0

if __name__ == "__main__":
    sys.exit(main())