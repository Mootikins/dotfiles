# Codebase Analysis Tools

> AI agent tools for analyzing the Crucible codebase

This document provides patterns and workflows for AI agents to effectively analyze the Crucible codebase.

## Search Patterns

### Rust Code Analysis
- **Functions**: `fn\s+\w+\(` - Find function definitions
- **Structs**: `struct\s+\w+` - Find struct definitions
- **Enums**: `enum\s+\w+` - Find enum definitions
- **Traits**: `trait\s+\w+` - Find trait definitions
- **Modules**: `mod\s+\w+` - Find module declarations

### TypeScript/JavaScript Analysis
- **Functions**: `function\s+\w+|const\s+\w+\s*=\s*\(` - Find function definitions
- **Classes**: `class\s+\w+` - Find class definitions
- **Interfaces**: `interface\s+\w+` - Find interface definitions
- **Types**: `type\s+\w+` - Find type definitions

### Svelte Component Analysis
- **Components**: `\.svelte$` - Find Svelte component files
- **Stores**: `writable|readable|derived` - Find Svelte stores
- **Reactive statements**: `\$:` - Find reactive statements

## Common Analysis Tasks

### Understanding Project Structure
1. **Core Business Logic**: Look in `crates/crucible-core/`
2. **Desktop Backend**: Check `crates/crucible-tauri/`
3. **Frontend Components**: Examine `packages/*/src/`
4. **Plugin System**: Review `crates/crucible-plugins/`
5. **MCP Integration**: Check `crates/crucible-mcp/`

### File Type Patterns
- **Rust**: `*.rs` - Core business logic and backend
- **TypeScript**: `*.ts` - Type definitions and utilities
- **Svelte**: `*.svelte` - UI components
- **JSON**: `*.json` - Configuration and schemas
- **Markdown**: `*.md` - Documentation and specifications

### Code Quality Patterns
- **Error Handling**: Look for `Result<T, E>` and `Option<T>` usage
- **Documentation**: Check for `///` doc comments
- **Tests**: Find `#[cfg(test)]` modules and `test_` functions
- **Async Code**: Look for `async`/`await` patterns

## Workflow Examples

### Analyzing a New Feature
1. Search for related keywords across the codebase
2. Identify entry points (commands, components, APIs)
3. Trace data flow through the system
4. Check for existing tests and documentation
5. Identify integration points and dependencies

### Understanding Dependencies
1. Check `Cargo.toml` files for Rust dependencies
2. Review `package.json` files for Node.js dependencies
3. Look for import/use statements in source files
4. Check workspace configuration in root `Cargo.toml`

### Code Generation Context
1. Find similar existing implementations
2. Check naming conventions and patterns
3. Review error handling approaches
4. Look for test patterns to follow
5. Identify documentation requirements