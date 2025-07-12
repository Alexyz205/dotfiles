# Gemini Interaction Guidelines

This document outlines the conventions and architectural principles to follow for this project.

## Commit Message Generation

Generate commit messages following the Conventional Commits specification: `<type>[optional scope]: <description>`

- **type**: Must be one of: `feat`, `fix`, `docs`, `style`, `refactor`, `perf`, `test`, `build`, `ci`, `chore`, `revert`.
- **scope** (optional): A noun in parentheses indicating the section of the codebase affected (e.g., `(api)`, `(parser)`).
- **description**: A concise explanation of the change in the present tense.

A more detailed explanation can be provided in the body, separated by a blank line. A footer can be used for breaking changes or issue references.

## Code Generation Guidelines

As a DevOps engineer working with Python, Bash, containers, and infrastructure automation, please adhere to the following Clean Architecture principles when generating code.

### Clean Architecture Summary

Organize code into concentric layers with dependencies pointing inward:
- **Domain (Core)**: Business entities and logic, independent of frameworks.
- **Application**: Orchestrates domain objects to execute use cases.
- **Interface Adapters**: Converts between domain and external formats.
- **Infrastructure**: Implements technical details and frameworks.

### Detailed Implementation Guidance

#### 1. Domain Layer
- Create domain entities representing infrastructure resources, configurations, and operational concepts.
- Define value objects with proper validation and factory methods.
- Keep domain logic independent of specific cloud providers or tools.
- Design domain services for infrastructure validation and policy checks.

#### 2. Application Layer
- Implement use cases as workflow orchestrators that coordinate infrastructure operations.
- Design input/output ports with clear interfaces for infrastructure operations.
- Implement proper error handling with meaningful exceptions and recovery strategies.
- Follow the dependency inversion principle, especially for cloud provider interactions.

#### 3. Interface Adapters Layer
- Create DTOs for infrastructure state representation and configuration mappings.
- Implement controllers for CLI commands and API endpoints.
- Convert between domain models and tool-specific formats (e.g., Terraform, CloudFormation).
- Design presenters for reports, metrics, and monitoring dashboards.

#### 4. Infrastructure Layer
- Implement repository interfaces for different cloud providers and infrastructure tools.
- Add structured logging with proper context for observability.
- Configure dependency injection for pluggable infrastructure components.
- Implement adapters for monitoring systems, CI/CD tools, and container orchestrators.

#### 5. DevOps Specific Guidelines
- **Python Codebase**: Adhere to PEP 8, use type hints, and structure projects with clear module boundaries reflecting Clean Architecture layers. Prioritize readability and maintainability.
- **Bash Scripting**: Write idempotent, robust, and well-commented scripts. Modularize complex scripts into functions.
- **Docker**: Optimize multi-stage builds, layer caching, and security best practices. Ensure minimal images and proper handling of secrets.
- **IaC**: Apply idempotency, immutability, and state management patterns.
- **CI/CD (YAML)**: Design testable pipeline components with a clear separation of concerns. Ensure pipelines are efficient, secure, and provide clear feedback. Use reusable components where possible.
- **Observability**: Implement consistent logging, metrics collection, and health checks.

Ensure all code follows SOLID principles, prioritizes testability, maintainability, and proper error handling. Inner layers must never depend on outer layers.
At the end of a code generation task, provide a summary of the generated code, including key components and their responsibilities.

## Test Generation

Generate comprehensive tests following these principles:

### 1. Unit Tests
- Create tests for domain entities covering different scenarios.
- Test use case interactors with mocked dependencies.
- Verify proper validation and error handling.
- Use fixture patterns for common test data.
- For Python, use `unittest` and ensure good test coverage.

### 2. Integration Tests
- Test interactions between multiple components.
- Verify proper data flow through architectural boundaries.
- Test API endpoints with proper request/response validation.
- For Python backend services, ensure API tests cover common use cases and edge cases.

### 3. Mock Implementation
- Create mock implementations of repositories and interfaces.
- Implement test doubles that verify correct behavior.
- Track method calls and arguments for verification.

### 4. Test Coverage
- Ensure edge cases are covered.
- Include both success and failure scenarios.
- Test exception handling paths.
- Aim for high test coverage, especially for core business logic and critical infrastructure interactions.

All tests should be readable, maintainable, and follow the AAA (Arrange-Act-Assert) pattern.

## Code Review

Review code following these Clean Architecture principles and quality standards:

### 1. Architecture Compliance
- Verify proper separation between layers (domain, application, interface, infrastructure).
- Check that inner layers don't depend on outer layers.
- Ensure domain entities are framework-independent.
- Validate that use cases handle all and only business logic.

### 2. SOLID Principles
- **Single Responsibility**: Each class has one reason to change.
- **Open/Closed**: Classes are open for extension but closed for modification.
- **Liskov Substitution**: Derived classes are substitutable for their base classes.
- **Interface Segregation**: Interfaces are client-specific rather than general-purpose.
- **Dependency Inversion**: High-level modules do not depend on low-level modules.

### 3. Code Quality
- Check error handling and validation completeness.
- Review naming conventions and code clarity.
- Evaluate test coverage and edge cases.
- Assess docstring quality and completeness.
- For Python, ensure PEP 8 compliance and effective use of type hints.
- For Bash, check for robustness, error handling, and modularity.
- Review Dockerfiles for efficiency, security, and adherence to best practices.
- Review CI/CD YAML configurations for clarity, efficiency, and proper error handling.

### 4. Performance & Security
- Identify potential performance bottlenecks.
- Check for security vulnerabilities (e.g., secret management in Docker/CI/CD).
- Review resource management.

Provide constructive feedback and specific improvement suggestions.

## Documentation Generation

When generating documentation (e.g., READMEs, API docs, design documents):
- **Clarity and Conciseness**: Ensure information is easy to understand and to the point.
- **Completeness**: Cover all necessary aspects for a user or developer to understand and use the project.
- **Structure**: Use clear headings, bullet points, and code examples for readability.
- **Audience**: Tailor the level of detail to the intended audience (e.g., end-user vs. developer).
- **Maintainability**: Suggest documentation that is easy to update and keep current.

## Debugging and Refactoring Assistance

When assisting with debugging or refactoring tasks:
- **Debugging**:
    - Help identify the root cause of issues by analyzing code, logs, and error messages.
    - Suggest potential fixes or areas for further investigation.
    - Provide strategies for effective debugging (e.g., print statements, using a debugger).
- **Refactoring to Clean Architecture**:
    - Guide the transformation of existing codebases to align with Clean Architecture principles.
    - Suggest step-by-step refactoring plans, focusing on incremental improvements.
    - Identify areas where dependencies are inverted or where layers are not properly separated.
    - Provide code examples for refactored components.
- **General Improvement Guidance**:
    - Offer suggestions for improving code quality, performance, and maintainability based on best practices and the project's context.
    - Highlight opportunities for applying design patterns or architectural principles.
