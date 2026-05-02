# Mini Wallet

Mini Wallet is a Flutter app for tracking wallet transactions and account balance. It uses GetX for state management, `go_router` for navigation, and a REST API backend for transaction CRUD and balance data.

## Features

- View the current account balance with income, expense, and total summaries.
- List recent transactions with details for each entry.
- Add, edit, and delete transactions.
- Open a transaction details screen from the home feed.
- Refresh data from the backend API.

## Backend API

This app is designed to work with the companion backend repository:

- [Mini-Wallet-API](https://github.com/DrRaspec/Mini-Wallet-API)

The app currently expects these API routes:

- `GET /transactions`
- `POST /transactions`
- `GET /transactions/{id}`
- `PUT /transactions/{id}`
- `DELETE /transactions/{id}`
- `GET /transactions/balance`

## Requirements

- Flutter 3.0+ with Dart 3.11+
- A running instance of the backend API
- Android emulator, iOS simulator, or a physical device

## Setup

1. Clone the Flutter app and open it in VS Code or Android Studio.
2. Make sure the backend API is running.
3. Copy an example environment file and fill in local values:

```bash
cp assets/env/.env.dev.example assets/env/.env.dev
cp assets/env/.env.prod.example assets/env/.env.prod
```

The app loads environment values from `assets/env/.env.dev` by default. You can switch files at launch time with `--dart-define=ENV_FILE=...`.

## Environment Variables

The app reads the following values from the selected `.env` file:

- `APP_FLAVOR` - App flavor label such as `dev` or `prod`.
- `API_BASE_URL` - Base URL of the backend server.
- `API_PREFIX` - API prefix, for example `api`.
- `API_VERSION` - API version, for example `v1`.
- `API_TIMEOUT_SECONDS` - Network timeout in seconds.

Example files are committed at `assets/env/.env.dev.example` and `assets/env/.env.prod.example`. Real `.env.*` files are ignored by Git.

Example development configuration:

```env
APP_FLAVOR=dev
API_BASE_URL=http://10.0.2.2:8080
API_PREFIX=api
API_VERSION=v1
API_TIMEOUT_SECONDS=15
```

## Run

```bash
cp assets/env/.env.dev.example assets/env/.env.dev
cp assets/env/.env.prod.example assets/env/.env.prod
```

For production-style settings, point `ENV_FILE` at `assets/env/.env.prod`.

## Project Structure

- `lib/core` - Shared configuration, networking, theme, storage, and widgets.
- `lib/features/transaction` - Transaction data, repository, controllers, and pages.
- `lib/features/shell` - App shell and shared navigation UI.
- `lib/routes` - Central route definitions.
- `assets/env` - Local environment files plus committed examples.

## Notes

Example development configuration:

```env
APP_FLAVOR=dev
API_BASE_URL=http://10.0.2.2:8080
API_PREFIX=api
API_VERSION=v1
API_TIMEOUT_SECONDS=15
```

## Run

```bash
flutter pub get
flutter run --dart-define=ENV_FILE=assets/env/.env.dev
```

For production-style settings, point `ENV_FILE` at `assets/env/.env.prod`.

## Project Structure

- `lib/core` - Shared configuration, networking, theme, storage, and widgets.
- `lib/features/transaction` - Transaction data, repository, controllers, and pages.
- `lib/features/shell` - App shell and shared navigation UI.
- `lib/routes` - Central route definitions.
- `assets/env` - Local environment files plus committed examples.

## Notes

- The app automatically attaches a bearer token to API requests when one is available in secure storage.
- If the backend returns `401`, stored tokens are cleared.
