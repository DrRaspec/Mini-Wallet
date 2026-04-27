# Scalable Flutter + GetX + go_router Project Structure

## Overview

This structure is designed for scalability, maintainability, and clean
separation of concerns using: - Feature-first architecture - GetX for
state management & dependency injection - go_router for navigation

------------------------------------------------------------------------

## Project Structure

    lib/
    │
    ├── core/                        # Shared/global stuff
    │   ├── constants/               # App-wide constants
    │   ├── theme/                   # Theme, colors, typography
    │   ├── utils/                   # Helpers, formatters
    │   ├── network/                 # API client, interceptors
    │   ├── errors/                  # Error handling
    │   └── services/                # Global services (storage, auth, etc.)
    │
    ├── routes/                      # go_router config (single source of truth)
    │   ├── app_router.dart
    │   ├── route_names.dart
    │   └── route_guards.dart
    │
    ├── bindings/                    # Global bindings (GetX DI)
    │   └── initial_binding.dart
    │
    ├── features/                    # Feature-first architecture ⭐
    │   │
    │   ├── auth/
    │   │   ├── data/
    │   │   │   ├── models/              # DTOs / API models
    │   │   │   ├── datasources/         # API / local data sources
    │   │   │   └── repositories_impl/   # Repository implementations
    │   │   │
    │   │   ├── domain/
    │   │   │   ├── entities/            # Core business objects
    │   │   │   ├── repositories/        # Abstract repository contracts
    │   │   │   └── usecases/            # Business logic
    │   │   │
    │   │   ├── presentation/
    │   │   │   ├── controllers/         # GetX controllers
    │   │   │   ├── pages/               # Screens
    │   │   │   └── widgets/             # Feature-specific widgets
    │   │   │
    │   │   └── bindings/                # Feature DI
    │   │       └── auth_binding.dart
    │   │
    │   ├── home/
    │   │   ├── data/
    │   │   ├── domain/
    │   │   ├── presentation/
    │   │   └── bindings/
    │   │
    │   └── profile/
    │       └── ...
    │
    ├── shared/                        # Reusable UI/components
    │   ├── widgets/
    │   ├── extensions/
    │   └── mixins/
    │
    ├── my_app.dart                    # App root widget
    └── main.dart                      # Entry point

------------------------------------------------------------------------

## Key Principles

### 1. Feature-First Architecture

Each feature is self-contained and includes: - Data layer - Domain
layer - Presentation layer

### 2. Separation of Concerns

-   `core/` → global utilities and services
-   `features/` → business logic
-   `shared/` → reusable UI

### 3. Navigation

-   Use `go_router` only
-   Keep routing centralized in `routes/`

### 4. State Management

-   Use GetX for:
    -   Controllers
    -   Dependency injection
-   Avoid using GetX for navigation

------------------------------------------------------------------------

## Best Practices

-   Keep controllers thin
-   Use use-cases for business logic
-   Lazy load dependencies using bindings
-   Avoid global state unless necessary

------------------------------------------------------------------------

## Optional Enhancements

-   Add code generation (freezed, json_serializable)
-   Add environment configs (dev/staging/prod)
-   Split into packages for large apps

------------------------------------------------------------------------

## Summary

This structure balances: - Simplicity - Scalability - Maintainability

It avoids overengineering while still being production-ready.
