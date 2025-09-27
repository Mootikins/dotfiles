# Commit Command

Smart git commit workflow.

## Usage
`/commit [mode] [message]`

## Modes

### Smart (default)
- Analyze staged changes
- Suggest commit type and message
- Follow conventional commits
- Check for issues

### Quick
`/commit quick [message]`
- Fast commit with message
- Basic validation

### Review
`/commit review`
- Show changes summary
- Suggest message options
- Wait for confirmation

### WIP
`/commit wip`
- Create brief summary from current context
- Compact conversation history
- Commit with "wip: " prefix
- Auto-add modified files

## Examples
```
/commit                 # Smart commit
/commit quick "fix bug" # Quick commit
/commit review          # Review changes
/commit wip            # Work in progress commit
```

## Commit Types
feat, fix, docs, style, refactor, test, chore

Checks: conventional format, message clarity, no sensitive data.