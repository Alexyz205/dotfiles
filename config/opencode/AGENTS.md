
## Clarification Process

BEFORE starting any significant task, ask clarifying questions in order of relevance:

1. **Scope & Requirements**: What exactly needs to be implemented/changed? Any constraints or preferences?
2. **Architecture Context**: What framework/libraries are already in use? Existing patterns to follow?
3. **Testing Strategy**: What testing approach is expected? Existing test structure?
4. **Dependencies**: Are there specific tools/versions that must be used?
5. **Acceptance Criteria**: How will success be measured? Any specific outcomes expected?

## Commit Messages

Use Conventional Commits: `<type>[scope]: <description>`

**Types**: `feat`, `fix`, `docs`, `style`, `refactor`, `perf`, `test`, `build`, `ci`, `chore`, `revert`

## Code Generation - Clean Architecture

### Layer Structure (dependencies point inward)

- **Domain**: Business entities, independent of frameworks
- **Application**: Use case orchestration
- **Interface Adapters**: Format conversion (DTOs, controllers, presenters)
- **Infrastructure**: Technical implementation (repositories, external services)

### Technology Guidelines

- **Python**: PEP 8, type hints, clear module boundaries
- **Bash**: Idempotent, modular functions, robust error handling
- **Docker**: Multi-stage builds, security best practices, minimal images
- **IaC**: Idempotency, immutability, state management
- **CI/CD**: Testable components, separation of concerns, reusable elements
- **Observability**: Structured logging, metrics, health checks

**Key Principles**: SOLID, testability, proper error handling. Provide component summary after generation.

## Testing

- **Unit**: Domain entities, use cases with mocks, validation scenarios
- **Integration**: Component interactions, API endpoints, data flow
- **Coverage**: Edge cases, success/failure paths, exception handling
- **Structure**: AAA pattern (Arrange-Act-Assert), Python unittest

## Code Review Focus

1. **Architecture**: Layer separation, dependency direction, framework independence
2. **Quality**: Error handling, naming, test coverage, documentation
3. **Performance**: Bottlenecks, security vulnerabilities, resource management
4. **Standards**: SOLID principles, language-specific best practices

## Documentation Standards

- Clear structure with headings and examples
- Audience-appropriate detail level
- Complete coverage of user/developer needs
- Maintainable and current information

## Debugging & Refactoring

- **Debug**: Root cause analysis, fix suggestions, debugging strategies
- **Refactor**: Step-by-step Clean Architecture alignment, dependency inversion identification
- **Improve**: Quality enhancements, design pattern opportunities
