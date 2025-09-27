# Prime Command

Current project/workspace overview and context for efficient development.

## Usage
`/prime [focus] [--dir path]`

## Actions

### Overview (default)
- **Core architecture**: Main components, systems, and tools
- **Key directories**: Project structure and organization
- **Development workflow**: Git flow, testing, deployment
- **Current status**: Branches, recent changes, blocking issues

### Debug
- **Error patterns**: Common issues and solutions
- **Debug workflow**: Logs, breakpoints, testing
- **Component dependencies**: What affects what
- **Test coverage**: Gaps and priorities

### Feature Integration
- **Integration points**: Where new features connect
- **Architecture constraints**: What works/doesn't work
- **Performance considerations**: Bottlenecks and optimizations
- **Testing requirements**: What needs coverage

### Code Quality
- **Style guide**: Project conventions and patterns
- **Type safety**: Language-specific type patterns
- **Error handling**: Project error patterns and practices
- **Performance**: Hotspots and monitoring

## Context Priority
1. **Current working directory** (default)
2. Additional workspace directories (only if explicitly requested with --dir)
3. Parent git repository if cwd is a subdirectory

## Examples
```
/prime            # Analyze current directory
/prime debug      # Debug workflow for current project
/prime feature    # Feature integration guide
/prime quality    # Code quality standards
/prime --dir /path/to/other  # Analyze specific directory
```

Analyzes the current workspace to provide project-specific context and guidance.