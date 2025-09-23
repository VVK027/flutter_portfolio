# Vivek Kumar — Portfolio (Flutter)

[![Flutter](https://img.shields.io/badge/Flutter-stable-blue?logo=flutter&logoColor=white)](https://flutter.dev)
[![License](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![CI](https://img.shields.io/github/actions/workflow/status/<OWNER>/<REPO>/ci.yml?branch=main&label=CI)](https://github.com/<OWNER>/<REPO>/actions)
[![Website](https://img.shields.io/website?url=https%3A%2F%2F<OWNER>.github.io%2F<REPO>&label=GitHub%20Pages)](https://<OWNER>.github.io/<REPO>)
[![PRs welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](CONTRIBUTING.md)

A high-performance, responsive Flutter portfolio using sliver-first layouts, background JSON parsing with isolates, Riverpod state management, go_router navigation, and a pragmatic clean architecture.

## Table of contents
- Features
- Tech stack
- Architecture
- Project structure
- Data model schema
- Getting started
- Run and build
- Configuration
- Theming
- Navigation
- State management
- Performance notes
- CI/CD (GitHub Actions)
- Deploy to GitHub Pages
- Contributing
- License

## Features
- Sliver-first scrolling with CustomScrollView/SliverGrid for smooth performance without nested shrinkWrap lists or grids.
- Background JSON parsing via compute to prevent UI jank.
- Clean architecture split into presentation, application, domain, and data layers.
- Reactive state with Riverpod, cached asset loading, and minimized rebuilds using select.
- URL-based navigation with go_router and section deep-linking/anchoring.
- Adaptive layout with breakpoint-driven columns aligned to Material guidance.
- Material 3 theme, plus ThemeExtension for reusable spacing and tokens.

## Tech stack
- Flutter, Dart, Material 3
- Riverpod for state management
- go_router for URL-driven navigation
- json_serializable for immutable typed models
- ScrollablePositionedList for anchored section scrolling

## Architecture
A pragmatic clean architecture that keeps modules small, testable, and composable.
- Presentation: Pages, widgets, slivers, and section shells in a single scroll pipeline.
- Application: Riverpod providers for data loading, filters, and derived lists.
- Domain: models representing portfolio entities for safe, typed access.
- Data: Repository abstraction with an asset-backed implementation parsing JSON on a background isolate.

## Project structure


## Data model schema
The app consumes a typed JSON asset mapped to a domain models.


## Getting started
- Prerequisites
  - Flutter (stable channel) and Dart SDK included.
  - Chrome installed for the web target.
- Install dependencies
  - Run: flutter pub get
- Code generation
  - Run: dart run build_runner build --delete-conflicting-outputs

## Run and build
- Run dev server (web): flutter run -d chrome
- Build web release: flutter build web --release

## Configuration
- Assets
  - Declare the data file in pubspec.yaml:
    ```
    flutter:
      assets:
        - assets/data.json
    ```
- Repository
  - AssetPortfolioRepository defaults to assets/data.json; customize the path if needed.

## Theming
- ThemeData uses Material 3 with a dark color scheme and consistent typography.
- A ThemeExtension (e.g., Metrics) holds shared spacing and layout tokens to avoid magic numbers.

## Navigation
- go_router provides declarative routes and deep links such as /section/Projects.
- ScrollablePositionedList enables smooth in-page anchor scrolling by section index.

## State management
- A FutureProvider loads and caches Portfolio from the repository.
- A StateProvider holds the current projects tag filter; a derived Provider exposes filtered lists with minimal rebuilds.

## Performance notes
- Prefer a single sliver pipeline (CustomScrollView/SliverGrid) over nested scrollables and shrinkWrap.
- Parse JSON on a background isolate using compute to avoid main-thread stalls.
- Split large widgets into small leaf components and prefer const constructors.
- Centralize layout decisions with breakpoints for predictable adaptive behavior.

## Deploy to GitHub Pages
- Build: flutter build web --release
- Options
  - Serve the build/web folder with any static host.
  - For GitHub Pages, enable Pages in repository settings and publish the build artifacts (for example, via a deploy workflow or a manual gh-pages branch).
- Typical Pages deployment step (append to workflow):


## Contributing
- Fork the repository and create a feature branch.
- Write tests when adding features or fixing bugs.
- Run format, analyze, and tests before opening a PR.
  - dart format .
  - flutter analyze
  - flutter test

## License
This project is licensed under the MIT License. See LICENSE for details.
