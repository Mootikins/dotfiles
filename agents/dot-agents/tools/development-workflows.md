# Development Workflows

> AI agent workflows for Crucible development

This document outlines common development workflows and best practices for AI agents working on the Crucible project.

## Code Generation Workflows

### Rust Code Generation
1. **Analyze existing patterns** in similar modules
2. **Follow naming conventions**: snake_case for functions/variables
3. **Include comprehensive error handling** with Result<T, E>
4. **Add documentation** with `///` comments
5. **Generate tests** in `#[cfg(test)]` modules
6. **Update Cargo.toml** if adding dependencies

### TypeScript Code Generation
1. **Use strict typing** with explicit type annotations
2. **Follow naming conventions**: camelCase for functions/variables
3. **Include JSDoc comments** for complex functions
4. **Generate Zod schemas** for runtime validation
5. **Add unit tests** with descriptive names
6. **Update package.json** if adding dependencies

### Svelte Component Generation
1. **Follow component structure** with script, markup, and style
2. **Use reactive statements** appropriately
3. **Implement proper state management** with stores
4. **Include accessibility attributes**
5. **Add component documentation**
6. **Generate component tests**

## Testing Strategies

### Unit Testing
- **Rust**: Use `#[cfg(test)]` modules with `cargo test`
- **TypeScript**: Use Jest or Vitest with descriptive test names
- **Svelte**: Test component behavior and state changes

### Integration Testing
- **API endpoints**: Test command handlers and IPC
- **Database operations**: Test CRUD operations and queries
- **Component integration**: Test component interactions

### Test Coverage
- Aim for >80% code coverage
- Test edge cases and error conditions
- Include both positive and negative test cases
- Test async operations and error handling

## Documentation Processes

### Code Documentation
- **Rust**: Use `///` for public APIs and `//!` for module docs
- **TypeScript**: Use JSDoc for functions and classes
- **Svelte**: Document component props and events

### API Documentation
- Document all public functions and methods
- Include parameter descriptions and return types
- Provide usage examples
- Document error conditions

### Architecture Documentation
- Update `ARCHITECTURE.md` for structural changes
- Document new patterns and conventions
- Update sprint specifications as needed

## Refactoring Approaches

### Safe Refactoring
1. **Write tests first** to ensure behavior preservation
2. **Make small, incremental changes**
3. **Run tests after each change**
4. **Update documentation** as you go
5. **Check for breaking changes** in public APIs

### Code Organization
- **Move related functionality** to appropriate modules
- **Extract common patterns** into reusable utilities
- **Consolidate duplicate code** into shared functions
- **Update imports** and dependencies

## Debugging Techniques

### Rust Debugging
- Use `dbg!()` macro for quick debugging
- Enable debug logging with appropriate log levels
- Use `cargo test -- --nocapture` for test output
- Check compiler warnings and clippy suggestions

### Frontend Debugging
- Use browser dev tools for UI debugging
- Add console.log statements for state inspection
- Use Svelte dev tools for component debugging
- Check network requests and API responses

### Common Issues
- **Type mismatches**: Check type annotations and conversions
- **Async/await**: Ensure proper error handling
- **State management**: Verify store updates and subscriptions
- **Build errors**: Check dependencies and imports