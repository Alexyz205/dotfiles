---
name: python-clean-arch
description: Python Clean Architecture patterns - project structure, layers, DI, FastAPI/Flask integration, testing
license: MIT
compatibility: opencode
metadata:
  audience: developers
  workflow: python
---

## Purpose

Guide Python application design following strict Clean Architecture principles with practical framework integration.

## Project Structure

```
src/
├── domain/              # Entities, value objects, domain exceptions
│   ├── entities/
│   ├── value_objects/
│   ├── exceptions.py
│   └── interfaces/      # Abstract base classes (ports)
├── use_cases/           # Application business rules
│   ├── interfaces/      # Port definitions (ABC)
│   └── <feature>/
├── adapters/            # Interface adapters
│   ├── api/             # FastAPI routers / Flask blueprints
│   ├── persistence/     # SQLAlchemy repos, Redis cache
│   ├── external/        # HTTP clients, message queues
│   └── dto/             # Data transfer objects (Pydantic models)
├── infrastructure/      # Composition root, config, DI wiring
│   ├── di/              # Dependency injection container
│   ├── config.py        # Settings (pydantic-settings)
│   └── main.py          # App entry point
└── tests/
    ├── unit/            # Domain + use case tests (no I/O)
    ├── integration/     # Adapter tests (real DB/API)
    └── conftest.py      # Fixtures
```

## Dependency Rule

```
Domain <- Use Cases <- Adapters <- Infrastructure
```

- Domain: pure Python, no imports from outer layers, no framework deps
- Use Cases: import only from domain, define ports as ABCs
- Adapters: implement ports, framework-specific code lives here
- Infrastructure: wires everything, DI container, app startup

## Dependency Injection

```python
# domain/interfaces/user_repo.py
from abc import ABC, abstractmethod
from domain.entities.user import User

class UserRepository(ABC):
    @abstractmethod
    async def get_by_id(self, user_id: str) -> User | None: ...
    @abstractmethod
    async def save(self, user: User) -> None: ...

# use_cases/create_user.py
class CreateUserUseCase:
    def __init__(self, repo: UserRepository, hasher: PasswordHasher) -> None:
        self._repo = repo  # Port, not concrete impl

# infrastructure/di/container.py — wire concrete implementations
```

Prefer constructor injection. Use `dependency-injector` or manual wiring in composition root.

## FastAPI Integration

- Routers in `adapters/api/` — thin, delegate to use cases
- Pydantic models in `adapters/dto/` — NOT domain entities
- Map DTO <-> Domain at adapter boundary
- Use `Depends()` for DI: inject use cases into route handlers

## Testing Strategy

| Layer | What to test | Mocks? | I/O? |
|-------|-------------|--------|------|
| Domain | Business rules, validation, value objects | None | No |
| Use Cases | Workflow logic, edge cases | Mock ports (ABC) | No |
| Adapters | DB queries, API calls, serialization | Test doubles or real infra | Yes |
| Integration | Full request flow | Minimal | Yes |

Use `pytest` + `pytest-asyncio`. Domain tests should be fast and pure.

## Anti-patterns

- Domain importing SQLAlchemy/Pydantic/FastAPI
- Use cases calling HTTP/DB directly (bypassing ports)
- Business logic in routers or middleware
- Pydantic models used as domain entities (leaking framework)
- God use cases doing everything — split by feature

## When to Use

- Designing new Python applications with complex business logic
- Refactoring monolithic Python apps toward clean boundaries
- Code review for architectural violations
- Setting up project scaffolding
