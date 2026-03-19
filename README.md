# GIF Search App

A Flutter application for searching GIFs using the Giphy API.

## Features

- Search GIFs using Giphy
- Auto search with debounce
- Pagination when scrolling
- Responsive grid layout
- Supports portrait and landscape orientation
- GIF detail screen
- Loading indicators
- Error handling
- Unit tests for controller logic

## Tech Stack

- Flutter
- Riverpod
- GoRouter
- Dio
- Giphy API

## Project Structure

lib/
  app/
  core/
  features/
    gif_search/
      data/
      domain/
      presentation/

## Architecture

The project uses a simple feature-based structure with separation into:

- **data** — API service, DTOs, repository
- **domain** — app model
- **presentation** — screens, widgets, controller, providers

Navigation is separated from page widget code using `go_router`.

State management is implemented with `Riverpod`.

## Setup

1. Clone the repository

2. Run:

```bash
flutter pub get
```

3. Add your Giphy API key to:

lib/core/constants/api_constants.dart

Replace:

```dart
static const String apiKey = 'PASTE_YOUR_GIPHY_API_KEY_HERE';
```

with your real API key.

4. Run the app:

```bash
flutter run
```

## Running Tests

```bash
flutter test
```

## Implemented Requirements

### Technical

- iOS & Android support
- Auto search with small delay after typing
- Pagination
- Vertical & horizontal orientation support
- Error handling
- Unit tests

### UI

- Responsive UI
- At least 2 views sourced by Giphy data
- Results displayed in a grid
- Tap on a GIF opens a detailed view
- Loading indicators
- Error display

### Bonus

- Riverpod state management
- Understandable architecture
- Navigation separated from page widget code

## Notes

- The project uses a Giphy API key for local development.
- The API key should not be committed to a public repository.

## Flutter Version

Flutter 3.38.5  
Dart 3.10.4
