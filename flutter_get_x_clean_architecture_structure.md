# Flutter GetX Clean Architecture (Full Structure)

This document describes a **clean, scalable Flutter project structure using GetX**. It follows **Clean Architecture principles**: separation of concerns, testability, and long-term maintainability.

---

## Core Principles

- **Presentation** → UI + GetX controllers
- **Domain** → Business logic (entities & use cases)
- **Data** → API, database, repositories implementation
- **Dependency Rule** → Outer layers depend on inner layers, never the opposite

---

## Recommended Folder Structure

```
lib/
│
├── main.dart
├── app.dart
│
├── core/
│   ├── constants/
│   │   ├── app_colors.dart
│   │   ├── app_strings.dart
│   │   └── app_sizes.dart
│   │
│   ├── theme/
│   │   └── app_theme.dart
│   │
│   ├── utils/
│   │   ├── validators.dart
│   │   ├── helpers.dart
│   │   └── extensions.dart
│   │
│   ├── error/
│   │   ├── exceptions.dart
│   │   └── failures.dart
│   │
│   ├── network/
│   │   ├── api_client.dart
│   │   ├── network_info.dart
│   │   └── interceptors.dart
│   │
│   └── widgets/
│       ├── app_button.dart
│       ├── app_textfield.dart
│       └── loading_view.dart
│
├── routes/
│   ├── app_pages.dart
│   └── app_routes.dart
│
├── bindings/
│   └── initial_binding.dart
│
├── data/
│   ├── models/
│   │   └── user_model.dart
│   │
│   ├── datasources/
│   │   ├── local/
│   │   │   └── user_local_data_source.dart
│   │   └── remote/
│   │       └── user_remote_data_source.dart
│   │
│   ├── repositories/
│   │   └── user_repository_impl.dart
│   │
│   └── mappers/
│       └── user_mapper.dart
│
├── domain/
│   ├── entities/
│   │   └── user_entity.dart
│   │
│   ├── repositories/
│   │   └── user_repository.dart
│   │
│   └── usecases/
│       └── get_user_usecase.dart
│
├── presentation/
│   ├── controllers/
│   │   └── user_controller.dart
│   │
│   ├── pages/
│   │   └── user_page.dart
│   │
│   └── widgets/
│       └── user_card.dart
│
└── di/
    └── dependency_injection.dart
```

---

## Layer Explanation

## 1. Presentation Layer

**Responsibility:** UI + State management

### Controllers (GetX)
- Holds UI state
- Calls use cases
- No API or database logic

Example:
- `UserController`

### Pages
- Screens (Scaffold, Widgets)
- Observes controller using `Obx`

---

## 2. Domain Layer

**Responsibility:** Business logic (framework-independent)

### Entities
- Pure Dart objects
- No JSON, no annotations

### Repositories (Abstract)
- Contracts only

### Use Cases
- Single responsibility
- One action per class

Example:
- `GetUserUseCase`

---

## 3. Data Layer

**Responsibility:** Data sources & implementation

### Models
- JSON serialization
- API response mapping

### Data Sources
- Remote → REST / GraphQL
- Local → SharedPreferences / Hive / SQLite

### Repository Implementation
- Implements domain repository
- Combines data sources

---

## 4. Core Layer

**Shared utilities across app**

- Network handling
- Errors & failures
- Themes & constants
- Reusable widgets

---

## 5. Routing (GetX)

### app_routes.dart
Defines route names

### app_pages.dart
Maps routes to pages & bindings

---

## 6. Dependency Injection

### initial_binding.dart
- Inject global dependencies

### dependency_injection.dart
- LazyPut / Put / Create

---

## main.dart Example Flow

- Initialize bindings
- Load app theme
- Set initial route

---

## Best Practices

- One feature = one controller
- Do NOT import Flutter in domain layer
- Do NOT return models to UI, return entities
- Keep controllers thin
- Use `Bindings` for dependency injection

---

## When to Create a New Feature

Create:
```
feature_name/
├── data/
├── domain/
└── presentation/
```

(Feature-based clean architecture – scalable for large apps)

---

## Recommended Packages

- get
- dio
- freezed (optional)
- json_serializable
- intl

---

## Result

This structure is:
- Clean
- Testable
- Scalable
- Industry-ready

Perfect for **medium to large Flutter apps using GetX**.

---

If you want:
- Feature-based version
- Auth module example
- Real API example
- Folder generator script

Just tell me.

