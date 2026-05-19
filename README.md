# vivekdevfolio

A responsive Flutter portfolio for Vivek Kumar — built with clean architecture, Riverpod, and go_router.

## Table of contents

- [Features](#features)
- [Tech stack](#tech-stack)
- [Architecture](#architecture)
- [Getting started](#getting-started)
- [Build](#build)
- [Deploy to GitHub Pages](#deploy-to-github-pages)
- [Configuration](#configuration)
- [License](#license)

## Features

- **Responsive layout** — Adaptive toolbar, spacing, and section layout for mobile, tablet, and desktop breakpoints.
- **Portfolio sections** — About, skills, experience, projects, reviews, awards, education, certifications, and contact, driven from `assets/data.json`.
- **Section navigation** — Sticky nav with scroll-synced active section via `ScrollablePositionedList`.
- **Deep links** — Shareable URLs for each section (`/section/:id`) with `go_router`.
- **Light and dark theme** — Toggle persisted with Riverpod; Material 3 styling via custom `AppColors`.
- **Projects gallery** — Tag filters, project cards with previews, and a detail bottom sheet.
- **Section carousels** — Paged carousels with controls and optional auto-play for multi-card content.
- **Contact and social** — Email, phone, location, and social links (GitHub, LinkedIn, WhatsApp, etc.) via `url_launcher`.
- **JSON-driven content** — Edit copy, metrics, experience, and projects without changing UI code.
- **CI pipeline** — Analyze, test, build web, and deploy on pushes to `main` (see [Deploy to GitHub Pages](#deploy-to-github-pages)).

## Tech stack

- Flutter & Dart
- Riverpod — state management
- go_router — URL navigation and section deep links
- json_serializable — typed JSON models
- ScrollablePositionedList — anchored section scrolling

## Architecture

```
lib/
├── domain/       # Entities, use cases, repository interfaces
├── data/         # Data sources, DTOs, mappers, repository implementations
├── presentation/ # Screens, widgets, Riverpod providers
└── core/         # App shell, routing, theming
```

Data is loaded from `assets/data.json`, parsed on a background isolate, and mapped to domain entities.

## Getting started

**Prerequisites:** Flutter (stable) and Chrome for web.

```bash
flutter pub get
dart run build_runner build
flutter run -d chrome
```

## Build

```bash
flutter build web --release
```

Output is in `build/web/`.

For a **project site** served at `https://<user>.github.io/<repo>/`, set the base path when building:

```bash
flutter build web --release --base-href="/<repo>/"
```

For a **user or organization site** at `https://<user>.github.io/`, use `--base-href="/"` (the default).

## Deploy to GitHub Pages

- **Build:** `flutter build web --release` (add `--base-href` if the app is not hosted at the domain root; see [Build](#build)).
- **Options**
  - Serve the `build/web` folder with any static host.
  - For GitHub Pages, enable Pages in the repository **Settings → Pages** and publish the build artifacts (for example, via a deploy workflow or a manual `gh-pages` branch).
- **Typical Pages deployment step** (append to a workflow after the web build):

```yaml
      - name: Deploy to GitHub Pages
        uses: peaceiris/actions-gh-pages@v3
        with:
          github_token: ${{ secrets.GITHUB_TOKEN }}
          publish_dir: ./build/web
```

This repository also includes [`.github/workflows/main.yml`](.github/workflows/main.yml), which runs `flutter analyze`, tests, `flutter build web --release`, and deploys `build/web` via `peaceiris/actions-gh-pages`. Adjust `publish_dir`, branch, or `external_repository` in that workflow to match your Pages setup.

**Live site:** After deployment, the app is available at your GitHub Pages URL (for example `https://<user>.github.io/<repo>/` for a project site).

## Configuration

Portfolio content lives in `assets/data.json`. Image and icon assets are under `assets/`.

## License

MIT — see [LICENSE](LICENSE).
