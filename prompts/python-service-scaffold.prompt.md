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
```

Alexyz205: perfect now update this prompt to create python project exactly same as this codebase as template, devcontainer clean architecture structure test etc

GitHub Copilot: # Python Clean Architecture Project Template

Create a complete Python service following Clean Architecture principles as demonstrated in the provided codebase.

## Project Requirements
- Name: [SERVICE NAME]
- Purpose: [BRIEF DESCRIPTION]
- Domain Entities: [LIST PRIMARY ENTITIES]
- External Integrations: [LIST EXTERNAL SYSTEMS TO INTERACT WITH]

## Technical Stack
- Python version: [VERSION]
- Framework: FastAPI
- Deployment: Docker containers
- Testing: pytest with fixtures and mocks
- Metrics: Prometheus
- Logging: Structured JSON logging with context
- Development: VS Code devcontainer

## Project Structure

Create a project with the following Clean Architecture layers:

### 1. Domain Layer (domain)
- Core business entities with proper validation
- Value objects with immutability and value equality
- Repository interfaces (ports)
- Domain exceptions
- Port interfaces for external services
- No dependencies on other layers

### 2. Application Layer (application)
- Use case interactors implementing business logic
- Input/output ports using protocols/interfaces
- Pure orchestration of domain entities
- Dependencies only on domain layer
- Proper error handling and logging

### 3. Interface Adapters Layer (interface_adapters)
- Controllers for handling external requests
- Presenters implementing output ports
- DTOs for boundary crossing
- Conversion between domain and external formats
- No business logic in this layer

### 4. Infrastructure Layer (infrastructure)
- Repository implementations
- Framework configurations (FastAPI)
- External service adapters
- Dependency injection container
- Logging context management
- Metrics collection
- Middleware implementations

## Development Environment

### Docker Setup
- Multi-stage Dockerfile with dev, test, and prod targets
- Docker Compose for local development
- VS Code devcontainer configuration

### Configuration Management
- YAML config files
- Environment variable support
- Settings class with validation

## Testing Framework
- Unit tests for each component
- Integration tests for endpoints
- Mock implementations for repositories and external services
- Fixtures for common test objects
- Test coverage reporting

## CI/CD Pipeline
- GitHub Actions workflow
- Running tests
- Building Docker images
- Optional deployment steps

## Required Files

Create the following key files:

### Project Structure
```
src/
├── domain/
│   ├── entities/
│   ├── exceptions.py
│   └── ports/
├── application/
│   ├── interactors/
│   ├── repositories/
│   └── ports/
├── interface_adapters/
│   ├── controllers/
│   ├── presenters/
│   └── dtos/
├── infrastructure/
│   ├── adapters/
│   ├── container.py
│   ├── logging_context.py
│   ├── metrics.py
│   └── repositories/
├── config/
│   ├── logging_config.py
│   ├── service_config.yaml
│   └── settings.py
└── main.py

tests/
├── unit/
│   ├── domain/
│   ├── application/
│   ├── interface_adapters/
│   └── infrastructure/
└── integration/

.devcontainer/
├── devcontainer.json
└── docker-compose.dev.yaml
```

### Core Implementation
1. Domain entities with validation and factory methods
2. Use case interactors with input/output ports
3. Controllers that handle external requests
4. DTOs for data transfer across boundaries
5. Repository implementations
6. Dependency injection container
7. Logging with context tracking
8. Prometheus metrics collection

### Development Tools
1. Makefile with common commands
2. Docker and docker-compose files
3. pytest configuration
4. GitHub Actions workflow

## Implementation Guidelines

1. Follow SOLID principles throughout
2. Ensure proper dependency direction (dependencies point inward)
3. Use dependency injection for all external dependencies
4. Implement proper error handling with domain-specific exceptions
5. Add comprehensive docstrings to all classes and methods
6. Include contextual logging for operations
7. Track metrics for key operations
8. Implement health check endpoints
9. Set up proper CI/CD pipeline with GitHub Actions

Provide a complete project scaffold with stub implementations showing how data flows through all layers for at least one use case.
