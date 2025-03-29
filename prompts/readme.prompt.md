# README Generator Pre-prompt

Use this prompt to create or update a comprehensive README.md that documents a project following Clean Architecture principles.

## Instructions for AI

1. Analyze the provided project structure and code
2. Extract key architectural components, patterns, and dependencies
3. Create a complete README document based on the template below
4. Ensure your documentation accurately reflects the project's implementation of Clean Architecture
5. Fill in all placeholder sections marked with [PLACEHOLDER]
6. Include relevant code snippets to illustrate key concepts

## Project Overview Template
- Project name: [PROJECT_NAME]
- Purpose: [PROJECT_PURPOSE]
- Core domain concepts: [KEY_DOMAIN_ENTITIES_AND_CONCEPTS]
- Technical stack: [LANGUAGES_FRAMEWORKS_TOOLS]

## Clean Architecture Implementation

Describe how the project implements Clean Architecture with these layers:

### 1. Domain Layer
- Location: [DOMAIN_DIRECTORY]
- Purpose: Contains enterprise business rules and entities
- Key components: [KEY_DOMAIN_COMPONENTS]
- Independence: Explain how this layer remains independent of external concerns

### 2. Application Layer (Use Cases)
- Location: [APPLICATION_DIRECTORY]
- Purpose: Application-specific business logic
- Key components: [KEY_APPLICATION_COMPONENTS]
- Ports: Describe the input/output port pattern implementation

### 3. Interface Adapters Layer
- Location: [INTERFACE_ADAPTERS_DIRECTORY]
- Purpose: Data conversion between use cases and external formats
- Key components: [KEY_INTERFACE_COMPONENTS]
- Adaptation patterns: Explain controllers, presenters, and DTOs

### 4. Infrastructure Layer
- Location: [INFRASTRUCTURE_DIRECTORY]
- Purpose: External interfaces and framework implementations
- Key components: [KEY_INFRASTRUCTURE_COMPONENTS]
- Technical implementations: Describe database, frameworks, and external services

## Project Structure

```
[PROJECT_DIRECTORY_STRUCTURE]
```

## Architecture Diagrams

Include Mermaid diagrams showing:

```mermaid
flowchart TD
    A[Component A] --> B[Component B]
    B --> C[Component C]
    C --> D[External System]

    subgraph Domain Layer
        [DOMAIN_COMPONENTS]
    end

    subgraph Application Layer
        [APPLICATION_COMPONENTS]
    end

    subgraph Interface Adapters Layer
        [INTERFACE_COMPONENTS]
    end

    subgraph Infrastructure Layer
        [INFRASTRUCTURE_COMPONENTS]
    end
```

## Code Examples

Include example code snippets that illustrate:
1. Domain entity creation and validation
2. Use case implementation with input/output ports
3. Controller/presenter patterns
4. Repository implementation
5. Dependency injection configuration

## Features

### Core Features
- [CORE_FEATURE_1]: [DESCRIPTION]
- [CORE_FEATURE_2]: [DESCRIPTION]

### Technical Features
- [TECHNICAL_FEATURE_1]: [DESCRIPTION]
- [TECHNICAL_FEATURE_2]: [DESCRIPTION]

## Development

### Setup Instructions
```bash
[SETUP_COMMANDS]
```

### Testing
```bash
[TESTING_COMMANDS]
```

### Configuration
- Environment variables: [LIST_OF_ENV_VARS_AND_PURPOSES]
- Configuration files: [LIST_OF_CONFIG_FILES_AND_PURPOSES]

## API Endpoints (if applicable)

### [ENDPOINT_GROUP_1]
- `[HTTP_METHOD] [ENDPOINT_PATH]`: [ENDPOINT_PURPOSE]
- `[HTTP_METHOD] [ENDPOINT_PATH]`: [ENDPOINT_PURPOSE]

## Running the Application

```bash
[RUN_COMMANDS]
```
