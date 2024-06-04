# DuoTask: A Flutter Task Management App

DuoTask is a Flutter application designed for efficient task
management. It leverages the power of MobX for state management and adopts a
clean architecture pattern, separating the application's concerns into distinct
layers: presentation, domain, and data.

## Getting Started

1. Clone the repository.
2. Run `flutter pub get` to install dependencies.
3. Run the application using `flutter run`.

## Test Credentials

For testing purposes, you can use the following credentials to sign in to the
application:

- Email: `test@example.com`
- Password: `88888888`

These credentials are defined in the `auth_cred_json.json` file located in
the `assets/icons` directory.

## Key Features

- **Clean Architecture**: The application follows the Clean Architecture
  principles, separating concerns into distinct layers (presentation, domain,
  data) for better maintainability and testability.
- **State Management with MobX**: MobX is used for efficient state management,
  providing reactive programming capabilities and a structured approach to
  managing application state.
- **Dependency Injection**: The `injection_container.dart` file sets up and
  registers dependencies using the `GetIt` package, enabling better code
  organization and testability.
- **Router and Navigation**: The `auto_route` package is used for declarative
  routing and navigation, making it easier to manage complex navigation flows.
- **Data Persistence**: The `hive` package is used for local data storage,
  allowing the application to persist and retrieve data efficiently.
- **Error Handling**: The `core/error` directory contains classes for handling
  exceptions and mapping them to appropriate failure objects, providing a
  consistent and centralized approach to error management.
- **View Models and Reactive UI**: The `presentation/view_models` directory
  contains view models that encapsulate business logic and state management for
  specific views, enabling reactive UI updates with MobX.
- **Base Widgets and Reusable Components**: The `presentation/base_widgets`
  directory contains reusable UI components and widgets, promoting code
  reusability and consistency across the application.

## Mock Client

The `mock_client.dart` file contains a `MockClient` mixin that provides
a `mockRequest` function. This function simulates API requests by introducing
random delays and occasionally simulating errors (e.g., 500 Internal Server
Error, 503 Service Unavailable).

The `mockRequest` function takes a callback that represents the actual API
request and an optional `authToken`. It first introduces a random delay between
500 and 1500 milliseconds to mimic network latency. Then, based on a random
chance, it may return a simulated error response.

If an `authToken` is provided, the `mockRequest` function calls
the `_checkToken` function to validate the token against a mock correct token.
If the token is invalid, a 401 Unauthorized response is returned.

The `MockClient` mixin is used in the data source implementations (
e.g., `MockAuthHttpDataSourceImpl`, `MockTaskHttpDataSourceImpl`) to simulate
API interactions during development and testing.

## Error Handling

The `error_handler.dart` file contains a `handleError` function that maps
exceptions and errors to corresponding `Failure` objects. This approach
separates error handling logic from the rest of the application code, making it
easier to manage and maintain.

## Project Structure

The project structure is organized as follows:
duotask/
├── assets/
│ └── icons/
│ ├── auth_cred_json.json
│ ├── default_response_json.json
│ ├── tasks_json.json
│ └── token_json.json
├── lib/
│ ├── core/
│ │ ├── error/
│ │ ├── helper/
│ │ ├── network/
│ │ ├── obs/
│ │ ├── storage/
│ │ ├── style/
│ │ └── util/
│ ├── data/
│ │ ├── datasources/
│ │ ├── models/
│ │ └── repositories/
│ ├── domain/
│ │ ├── entities/
│ │ └── repositories/
│ ├── presentation/
│ │ ├── base_widgets/
│ │ ├── view_models/
│ │ └── views/
│ │ ├── home_navigation_screen/
│ │ ├── root_screen/
│ │ ├── sign_in_screen/
│ │ └── tasks_screen/
│ └── router/
├── pubspec.yaml
├── app_config.dart
├── injection_container.dart
└── main.dart