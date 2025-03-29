# Clean Architecture Component Placement Guide

Review my code and help me understand where each component belongs in Clean Architecture layers. I work primarily with Python in DevOps/automation contexts.

## Clean Architecture Principles

### Layer Overview
- **Domain Layer**: Core business entities, value objects, business rules
- **Application Layer**: Use cases, orchestration of domain objects
- **Interface Adapters Layer**: Controllers, presenters, gateways
- **Infrastructure Layer**: Frameworks, database implementations, external services

### Key Guidelines
1. Dependencies always point inward
2. Inner layers have no knowledge of outer layers
3. Domain layer has no external dependencies
4. Use interfaces for dependency inversion
5. Cross boundary communication uses DTOs/simple data structures

## Analysis Requested

1. Identify the Clean Architecture layer for each component
2. Evaluate dependency flow (ensure inward direction)
3. Highlight any architecture violations
4. Suggest refactoring to improve architectural alignment
5. Explain reasoning behind recommendations

## Common Layer Components

### Domain Layer
- Entities representing business concepts
- Value objects for immutable values
- Domain events signaling state changes
- Repository interfaces defining data access
- Domain services for operations on multiple entities
- Domain exceptions specific to business rules

### Application Layer
- Use case interactors implementing business flows
- Input/output ports (interfaces for interactors)
- DTOs for use case inputs and outputs
- Application services orchestrating complex flows
- Application exceptions for use case failures

### Interface Adapters Layer
- Controllers handling external requests
- Presenters formatting data for display
- Gateways adapting external services
- View models for presentation logic
- API models for external interfaces

### Infrastructure Layer
- Repository implementations
- Database configurations
- Framework integrations
- External service implementations
- Logging implementations
- Authentication mechanisms
- Configuration management

## Code to Analyze
```python
[PASTE CODE HERE]
