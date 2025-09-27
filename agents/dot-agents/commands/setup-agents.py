#!/usr/bin/env python3
"""
Setup script for AI agent compatibility
Creates symlinks from various agent directories to .agents
"""

import os
import sys
import platform
from pathlib import Path
from typing import List, Optional

class AgentSetup:
    def __init__(self, project_root: Optional[Path] = None):
        self.project_root = project_root or Path(__file__).parent.parent.parent
        self.agents_dir = self.project_root / ".agents"
        self.is_windows = platform.system() == "Windows"

    def create_symlink(self, target: Path, link: Path) -> bool:
        """Create a symlink if target doesn't exist, with cross-platform fallbacks"""
        try:
            if link.exists() and not link.is_symlink():
                print(f"⚠️  Warning: {link} exists and is not a symlink. Skipping.")
                return False

            if link.is_symlink():
                print(f"✅ {link} already exists")
                return True

            # Create parent directory if it doesn't exist
            link.parent.mkdir(parents=True, exist_ok=True)

            if self.is_windows:
                # Windows: try to create symlink, fallback to copy if fails
                try:
                    # Calculate relative path
                    rel_path = os.path.relpath(target, link.parent)
                    os.symlink(rel_path, link, target_is_directory=target.is_dir())
                    print(f"✅ Created symlink: {link} -> {rel_path}")
                    return True
                except OSError:
                    # Fallback: copy files/directories
                    print(f"📋 Windows fallback: copying {target} to {link}")
                    if target.is_dir():
                        import shutil
                        shutil.copytree(target, link, dirs_exist_ok=True)
                    else:
                        shutil.copy2(target, link)
                    return True
            else:
                # Unix systems: create relative symlink
                rel_path = os.path.relpath(target, link.parent)
                os.symlink(rel_path, link)
                print(f"✅ Created symlink: {link} -> {rel_path}")
                return True

        except Exception as e:
            print(f"❌ Error creating symlink {link}: {e}")
            return False

    def create_command_symlinks(self, agent: str) -> bool:
        """Create command symlinks for specific agents"""
        agent_dir = self.project_root / f".{agent}"
        commands_dir = agent_dir / "commands"
        agent_commands_dir = self.agents_dir / agent / "commands"

        if not agent_commands_dir.exists():
            print(f"⚠️  No commands directory found for {agent}")
            return True

        # Create commands directory if it doesn't exist
        commands_dir.mkdir(parents=True, exist_ok=True)

        # Create symlinks for each command file
        success_count = 0
        for cmd_file in agent_commands_dir.glob("*.md"):
            if cmd_file.is_file():
                if self.create_symlink(cmd_file, commands_dir / cmd_file.name):
                    success_count += 1

        print(f"✅ Created {success_count} command symlinks for {agent}")
        return True

    def get_agents_list(self) -> List[str]:
        """Get list of common AI agent directories"""
        return [
            ".cursor/agents",
            ".claude/agents",
            ".gpt/agents",
            ".copilot/agents",
            ".crush/agents",
            ".anthropic/agents",
            ".openai/agents",
            ".github/agents",
            ".vscode/agents",
            ".codeium/agents",
            ".tabnine/agents",
            ".kite/agents",
            ".sourcery/agents",
            ".deepcode/agents",
            ".intellicode/agents",
        ]

    def get_command_agents_list(self) -> List[str]:
        """Get list of agents that support commands"""
        return [
            "cursor",
            "claude",
            "gpt",
            "copilot",
            "crush",
            "anthropic",
            "openai",
            "github",
            "vscode",
            "codeium",
            "tabnine",
            "kite",
            "sourcery",
            "deepcode",
            "intellicode",
        ]

    def setup_agents(self) -> bool:
        """Main setup function"""
        print(f"🤖 Setting up AI agent compatibility for Crucible project")
        print(f"Project root: {self.project_root}")
        print(f"Agents directory: {self.agents_dir}")
        print(f"Platform: {platform.system()}")

        if not self.agents_dir.exists():
            print(f"❌ Agents directory not found: {self.agents_dir}")
            return False

        agents = self.get_agents_list()
        command_agents = self.get_command_agents_list()

        print("")
        print("Creating symlinks for AI agent compatibility...")

        # Create main agents directory symlinks
        success_count = 0
        for agent in agents:
            target = self.agents_dir
            link = self.project_root / agent
            if self.create_symlink(target, link):
                success_count += 1

        print("")
        print("Creating command symlinks for supported agents...")

        # Create command symlinks for agents that support them
        for agent in command_agents:
            self.create_command_symlinks(agent)

        print("")
        print("🎉 AI agent setup complete!")
        print("")
        print("Available agents can now access Crucible's AI tools at:")
        for agent in ["cursor", "claude", "crush"]:
            print(f"  - .{agent}/agents/ (with commands in .{agent}/commands/)")
        print("  - And more...")
        print("")
        print("Commands available:")
        print("  - review-code.md - Code review and quality analysis")
        print("  - write-tests.md - Generate comprehensive tests")
        print("  - refactor-code.md - Refactor following project patterns")
        print("  - analyze-architecture.md - Architecture analysis")
        print("  - generate-docs.md - Generate documentation")
        print("")
        print("To add a new agent, run:")
        print("  ln -sf ../.agents .your-agent/agents")
        print("  # Then create commands if supported:")
        print("  mkdir -p .your-agent/commands")
        print("  ln -sf ../../.agents/your-agent/commands/*.md .your-agent/commands/")
        print("")
        print("To remove an agent, run:")
        print("  rm .your-agent/agents")

        return True

def main():
    """Main entry point"""
    setup = AgentSetup()
    try:
        success = setup.setup_agents()
        return 0 if success else 1
    except KeyboardInterrupt:
        print("\n❌ Setup cancelled by user")
        return 1
    except Exception as e:
        print(f"❌ Unexpected error: {e}")
        return 1

if __name__ == "__main__":
    sys.exit(main())