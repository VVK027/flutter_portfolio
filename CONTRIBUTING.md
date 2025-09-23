# Contributing Guide

Thank you for your interest in contributing to this Flutter portfolio project. Contributions of all kinds are welcome, including code, documentation, tests, design, and performance improvements.

## Ways to contribute

- Report bugs and issues with clear steps to reproduce.
- Propose features that improve developer experience, performance, or accessibility.
- Improve documentation, examples, and comments.
- Refactor or optimize code where it meaningfully reduces complexity or cost.
- Add tests that improve coverage and prevent regressions.

## Project overview

This app uses a pragmatic clean architecture with typed models and background JSON parsing.
- Presentation: UI pages, widgets, and slivers.
- Domain: Freezed models representing portfolio data.
- Data: Repository abstraction with asset-backed implementation and isolate parsing.

## Development setup

- Prerequisites
    - Flutter (stable channel) and Dart SDK included.
    - A recent Chrome for web builds.
- Clone and install
    - git clone <your-fork-url>
    - cd <repo>
    - flutter pub get
- Code generation
    - dart run build_runner build --delete-conflicting-outputs
- Run the app
    - flutter run -d chrome
- Build for web
    - flutter build web --release

## Branch strategy

- Default branch: main.
- Create feature branches from main:
    - feature/<short-description> for new features.
    - fix/<short-description> for bug fixes.
    - docs/<short-description> for documentation changes.
    - chore/<short-description> for maintenance and tooling.

## Issue workflow

- Search existing issues before opening a new one.
- When filing a new issue, include reproduction steps, expected behavior, actual behavior, and environment details.
- Tag issues with suitable labels if available.
- For feature requests, describe the problem, proposed solution, and alternatives considered.

## Pull request workflow

- Fork the repo and create a topic branch from main.
- Keep changes focused and cohesive; avoid mixing unrelated changes.
- Update or add tests for new behavior.
- Update documentation when behavior or APIs change.
- Ensure all checks pass locally before opening a PR.
- Include a clear description, screenshots for UI changes, and testing notes.

### PR checklist

- The branch is up to date with main.
- Code formatted and analyzed without errors.
- Tests were added or updated and pass locally.
- No debug prints or dead code remain.
- README and relevant docs updated if needed.

## Coding guidelines

- Style and formatting
    - Use dart format on the entire repo.
    - Follow the lints configured in analysis_options.yaml.
    - Prefer const constructors where possible.
- Architecture conventions
    - Keep UI in presentation, business logic in application, models in domain, and I/O in data.
    - Avoid referencing data layer directly from presentation; go through providers.
- State management
    - Use Riverpod providers; prefer select to minimize rebuilds.
    - Keep providers small and composable; avoid side effects in build methods.
- UI and performance
    - Prefer a single sliver pipeline; avoid nested scroll views and shrinkWrap lists.
    - Parse large JSON on a background isolate using compute.
    - Split large widgets into small leaf widgets; avoid heavy work in build.
    - Debounce rapid interactions where appropriate.
- Testing
    - Write unit tests for domain and application logic.
    - Add widget tests for critical flows and rendering.
    - Keep tests deterministic; avoid network or file I/O in unit tests.

## Commit conventions

Use Conventional Commits for readable history and automated tooling.
- feat: add a new feature.
- fix: bug fix.
- docs: documentation changes.
- style: formatting or style only.
- refactor: code changes without behavior change.
- perf: performance improvements.
- test: add or update tests.
- build: build system or dependencies.
- ci: continuous integration changes.
- chore: maintenance tasks.
- revert: revert a prior commit.

Examples:
- feat(projects): add tag filtering for payments
- fix(theme): correct surface container color on dark scheme
- perf(slivers): replace shrinkWrap grid with SliverGrid

## Running checks locally

- Format
    - dart format .
- Analyze
    - flutter analyze
- Generate
    - dart run build_runner build --delete-conflicting-outputs
- Test
    - flutter test --coverage
- Full web build
    - flutter build web --release