---
name: python-devops
description: Python for DevOps - API clients, config parsing, CLI tools, async patterns, testing
license: MIT
compatibility: opencode
metadata:
  audience: developers
  workflow: python
---

## Purpose

Patterns and standards for Python scripts and tools in DevOps contexts.

## CLI Tools

### Structure with Typer/Click
```python
import typer
from typing import Annotated

app = typer.Typer(help="My DevOps tool")

@app.command()
def deploy(
    environment: Annotated[str, typer.Argument(help="Target environment")],
    dry_run: Annotated[bool, typer.Option("--dry-run", help="Preview only")] = False,
    verbose: Annotated[bool, typer.Option("--verbose", "-v")] = False,
):
    """Deploy application to target environment."""
    ...

if __name__ == "__main__":
    app()
```
- Use Typer for modern CLI (type hints + auto-complete)
- Click for more complex nested command groups
- Always include `--dry-run`, `--verbose`, `--help`
- Return proper exit codes via `raise typer.Exit(code=1)`

## API Clients

### httpx (preferred over requests)
```python
import httpx
from tenacity import retry, stop_after_attempt, wait_exponential

@retry(stop=stop_after_attempt(3), wait=wait_exponential(multiplier=1, max=10))
async def get_resource(client: httpx.AsyncClient, url: str) -> dict:
    response = await client.get(url, timeout=30.0)
    response.raise_for_status()
    return response.json()

async with httpx.AsyncClient(
    base_url="https://api.example.com",
    headers={"Authorization": f"Bearer {token}"},
) as client:
    data = await get_resource(client, "/resources")
```
- Use `httpx` for async support, HTTP/2, connection pooling
- Always set timeouts explicitly
- Retry with exponential backoff for transient failures (tenacity)
- Use context managers for connection lifecycle

## Configuration

### pydantic-settings
```python
from pydantic_settings import BaseSettings
from pydantic import Field

class Config(BaseSettings):
    model_config = {"env_prefix": "APP_", "env_file": ".env"}

    db_host: str = Field(description="Database hostname")
    db_port: int = Field(default=5432)
    debug: bool = Field(default=False)
    log_level: str = Field(default="INFO")
```
- Env vars > config files > defaults (precedence)
- Validate at startup, fail fast on missing required config
- Type coercion built-in (str -> int, bool, etc.)

## Async Patterns

```python
import asyncio
from typing import Iterable

async def process_batch(items: Iterable, concurrency: int = 10):
    semaphore = asyncio.Semaphore(concurrency)
    async def bounded(item):
        async with semaphore:
            return await process_item(item)
    return await asyncio.gather(*[bounded(i) for i in items])
```
- Use semaphores to bound concurrency
- `asyncio.gather` for parallel I/O (API calls, file ops)
- `asyncio.TaskGroup` (3.11+) for structured concurrency
- Avoid mixing sync/async — use `asyncio.to_thread()` for blocking calls

## Testing

```python
# conftest.py
import pytest
from unittest.mock import AsyncMock

@pytest.fixture
def mock_client():
    client = AsyncMock(spec=httpx.AsyncClient)
    client.get.return_value = httpx.Response(200, json={"key": "value"})
    return client
```
- `pytest` + `pytest-asyncio` for async tests
- Mock external services, never hit real APIs in unit tests
- Use `respx` for httpx mocking, `responses` for requests mocking
- Test CLI with `typer.testing.CliRunner` or `click.testing.CliRunner`

## Project Layout

```
my_tool/
├── pyproject.toml        # PEP 621 metadata + deps
├── src/my_tool/
│   ├── __init__.py
│   ├── __main__.py       # Entry point
│   ├── cli.py            # Typer/Click commands
│   ├── client.py         # API clients
│   ├── config.py         # Settings
│   └── utils.py
├── tests/
└── Dockerfile
```
- Use `pyproject.toml` (not setup.py/setup.cfg)
- `src/` layout to prevent import confusion
- Pin deps in `pyproject.toml`, lock with `uv.lock` or `pip-compile`

## Packaging

- Use `uv` for fast dependency management and virtual envs
- Multi-stage Docker builds: build deps in builder, copy to slim runtime
- For internal tools: publish to private PyPI or install from git

## When to Use

- Building DevOps CLI tools and automation
- Writing API integration scripts
- Setting up Python project structure for infrastructure tooling
- Reviewing Python scripts for production readiness
