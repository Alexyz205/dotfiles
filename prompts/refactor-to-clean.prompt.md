# Clean Architecture Refactoring Guide

## Target Architecture

Refactor code using these Clean Architecture layers:

### 1. Domain Layer (Innermost)
- Core business entities with validation
- Value objects (immutable with equality by value)
- Repository interfaces (ports)
- Domain exceptions and services
- No external dependencies

### 2. Application Layer
- Use case interactors implementing business logic
- Input/output ports (interfaces)
- Pure domain orchestration
- Depends only on domain layer

### 3. Interface Adapters Layer
- Controllers handling external requests
- Presenters formatting output data
- DTOs for boundary crossing
- Converts between domain and external formats
- No business logic

### 4. Infrastructure Layer (Outermost)
- Repository implementations
- Framework configurations
- External service adapters
- Dependency injection setup
- Logging, metrics, cross-cutting concerns

## Principles to Apply
- Dependency Rule: dependencies point inward only
- Entities contain business rules and critical data
- Use interfaces at boundaries between layers
- Inversion of Control for external dependencies
- Each component should be testable in isolation

## Implementation Steps
1. Identify domain entities and business rules
2. Create domain interfaces for required services
3. Implement use cases with ports for input/output
4. Build interface adapters for external communication
5. Create infrastructure implementations
6. Ensure dependency injection for proper wiring

## Code Structure
- `/src/domain/` - Entities, value objects, interfaces
- `/src/application/` - Use cases, ports, DTOs
- `/src/interface_adapters/` - Controllers, presenters, views
- `/src/infrastructure/` - Repositories, services, configuration

Always maintain proper dependency direction: Domain ← Application ← Interface ← Infrastructure
