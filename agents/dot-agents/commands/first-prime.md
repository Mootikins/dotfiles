# First Prime Command

Quick project discovery and structure analysis for the current workspace.

## Usage
`/first-prime [deep] [--dir path]`

## Actions

### Quick Scan (default)
- Project type identification
- Key configuration files
- Build system detection
- Test framework identification
- Documentation structure

### Deep Scan
- Dependencies overview
- Project architecture patterns
- Development tools and scripts
- Git repository status
- Security-related files

## Context Priority
1. **Current working directory** (default)
2. Specific directory (only if explicitly requested with --dir)
3. Parent git repository if cwd is a subdirectory

## Examples
```
/first-prime     # Quick scan of current directory
/first-prime deep # Deep analysis of current directory
/first-prime --dir /path/to/project # Scan specific directory
```

Read-only analysis of the current workspace, makes no changes.