# Project Context

> Essential project information for AI agents

This document provides crucial context about the Crucible project for AI agents to understand the codebase and contribute effectively.

## Project Overview

**Crucible** is a collaborative document editor with AI integration, built using modern web technologies and designed for extensibility through a plugin system.

### Core Mission
- Enable collaborative document editing with real-time synchronization
- Provide AI-powered assistance and automation
- Support extensibility through a plugin architecture
- Maintain data sovereignty and privacy

## Tech Stack

### Backend (Rust)
- **Core Business Logic**: `crucible-core` - CRDT operations, document management
- **Desktop Backend**: `crucible-tauri` - Tauri commands and IPC
- **Plugin Runtime**: `crucible-plugins` - Rune-based plugin system
- **MCP Integration**: `crucible-mcp` - Model Context Protocol for AI agents

### Frontend (TypeScript/Svelte)
- **Desktop App**: `packages/desktop` - Tauri + Svelte desktop application
- **Web App**: `packages/web` - Svelte web application
- **Shared Types**: `packages/shared` - Common TypeScript definitions

### Database & Persistence
- **PGlite**: Embedded PostgreSQL for local data storage
- **Vector Search**: Embeddings for semantic search and AI features
- **CRDT Storage**: Conflict-free replicated data structures

## Architecture Patterns

### CRDT-Based Collaboration
- **Document Structure**: Hierarchical nodes with unique IDs
- **Operational Transformation**: Real-time conflict resolution
- **Synchronization**: Peer-to-peer and server-based sync options

### Plugin Architecture
- **Rune Runtime**: WebAssembly-based plugin execution
- **Sandboxed Environment**: Secure plugin isolation
- **API Surface**: Controlled access to core functionality

### AI Integration
- **MCP Protocol**: Standardized AI agent communication
- **Embeddings**: Vector search for semantic understanding
- **Context Awareness**: Document-aware AI assistance

## Development Guidelines

### Code Organization
- **Workspace Structure**: Monorepo with Rust crates and Node.js packages
- **Separation of Concerns**: Clear boundaries between core, UI, and plugins
- **Dependency Management**: Cargo for Rust, pnpm for Node.js

### Naming Conventions
- **Rust**: snake_case for functions/variables, PascalCase for types
- **TypeScript**: camelCase for functions/variables, PascalCase for types
- **Files**: kebab-case for directories, descriptive names for files

### Error Handling
- **Rust**: Use `Result<T, E>` for fallible operations
- **TypeScript**: Use try/catch with proper error types
- **API**: Consistent error response formats

## Common Code Patterns

### Rust Patterns
```rust
// Error handling
pub fn operation() -> Result<Data, Error> {
    // Implementation
}

// Async operations
pub async fn async_operation() -> Result<Data, Error> {
    // Implementation
}

// CRDT operations
pub fn apply_operation(op: Operation) -> Result<(), CrdtError> {
    // Implementation
}
```

### TypeScript Patterns
```typescript
// Type definitions
export interface DocumentNode {
  id: string;
  type: NodeType;
  content: string;
}

// Store management
export const documentStore = writable<DocumentNode[]>([]);

// Component props
interface ComponentProps {
  node: DocumentNode;
  onUpdate: (node: DocumentNode) => void;
}
```

### Svelte Patterns
```svelte
<!-- Component structure -->
<script lang="ts">
  import { onMount } from 'svelte';
  export let prop: Type;
  
  let state = $state(initialValue);
</script>

<main>
  <!-- Template -->
</main>

<style>
  /* Scoped styles */
</style>
```

## Sprint Phases

### Sprint 1: Foundation
- CRDT implementation
- Basic document editing
- Tauri desktop app
- Core data structures

### Sprint 2: Persistence & UI Polish
- PGlite database integration
- Vector embeddings
- Enhanced UI components
- Document management

### Sprint 3: Canvas & Properties
- Spatial canvas interface
- Node properties system
- Advanced editing features
- Plugin architecture

### Sprint 4: Intelligence Layer
- AI agent integration
- MCP protocol implementation
- Advanced automation
- Semantic search

## Quality Standards

### Testing
- Unit tests for all public APIs
- Integration tests for critical paths
- End-to-end tests for user workflows
- >80% code coverage target

### Documentation
- Comprehensive API documentation
- Architecture decision records
- User guides and tutorials
- Code comments for complex logic

### Performance
- Efficient CRDT operations
- Optimized rendering
- Minimal memory footprint
- Fast startup times

## Security Considerations

### Data Privacy
- Local-first data storage
- Encrypted synchronization
- No cloud dependencies by default
- User-controlled data sharing

### Plugin Security
- Sandboxed execution environment
- Limited API surface
- Permission-based access control
- Code signing and verification

### AI Integration
- Local model options
- Privacy-preserving embeddings
- User consent for data sharing
- Transparent AI decision making