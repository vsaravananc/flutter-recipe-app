# Flutter Recipe App | Clean Architecture | BLoC | SQLite | Offline First | Material 3 | Complete Source Code

A modern, high-performance, and feature-rich Recipe Book application built using **Flutter**. This application leverages **Clean Architecture** principles to separate concerns, making the codebase highly maintainable, testable, and scalable. It integrates with **TheMealDB API** for recipe data, **Firebase** for cloud services, and **Sqflite** for persistent local caching.

---

## 🚀 Key Features

*   **Splash & Welcome Flow**: Smooth user onboarding and initial app initialization.
*   **Authentication**: Secure user login and registration powered by **Firebase Auth** and **Google Sign-In**.
*   **User Preferences**: Dynamic collection of user preferences (favorite cuisines/areas and categories) stored both locally and synced to **Cloud Firestore**.
*   **Home Dashboard**: A modern layout containing categorized meal feeds, recipe suggestions, and user-tailored recommendations.
*   **Interactive Barcode Scanner**: Powered by **Camerawesome** and **Google ML Kit Barcode Scanning**, allowing users to scan product barcodes directly from a draggable slide-up modal bottom sheet to look up recipes.
*   **Fuzzy Recipe Search**: Instantly look up dishes and recipes by name, area, or category.
*   **Detailed Recipe Views**: Beautiful ingredient list displays, step-by-step instructions, in-app YouTube player tutorial integration (`youtube_player_flutter`), and custom screen transitions.
*   **Premium Theming**: Support for customized light and dark modes powered by **FlexColorScheme** (Mango theme), utilizing rich visual aesthetics, custom icons (`HugeIcons`), and micro-animations (`Flutter Animate`).

---

## 🛠 Tech Stack & Key Dependencies

*   **State Management**: `flutter_bloc` & `bloc` (State management pattern using event-driven BloC and lightweight Cubits).
*   **Dependency Injection**: `get_it` (Service Locator for managing singletons, lazy singletons, and factory instances).
*   **Local Caching & DB**: `sqflite` (SQLite database helper with support for custom tables: category, meals, areas, recipes, food details).
*   **API / Networking**: `dio` (HTTP client for rest communications with TheMealDB API).
*   **Declarative Routing**: `go_router` (Robust path-based routing management supporting nested navigations and custom transition animations).
*   **Cloud Backend**: `firebase_auth`, `firebase_core`, `cloud_firestore` & `google_sign_in`.
*   **Hardware Integration**: `camerawesome` (Camera UI rendering) & `google_mlkit_barcode_scanning` (AI barcode recognition).
*   **Rich UI & Animations**: `flex_color_scheme` (Harmonious Material 3 color palettes), `flutter_animate` (Sleek entrance/exit animations), `hugeicons` (Modern custom stroke icon set).
*   **Data Structures**: `dartz` (Functional programming constructs such as `Either` for error handling).

---

## 🏗 Project Architecture & Structure

This project is built using **Clean Architecture** patterns, separating files by domain features rather than file types. The `lib` folder is split into two primary segments: `core` and `feature`.

```text
lib/
├── main.dart                      # App entry point (initializes DI, database, theme)
├── core/                          # Cross-cutting concerns & shared layers
│   ├── api/                       # API clients (Dio) and endpoint configurations
│   ├── database/                  # Sqflite SQLite configurations, database creator, and tables
│   ├── enums/                     # Shared app-wide enums
│   ├── extensions/                # Dart extension methods (theme, colors, layout dimensions)
│   ├── handler/                   # Global error/exception handlers
│   ├── images/                    # Image asset helpers
│   ├── messages/                  # App-wide text messages and strings
│   ├── route/                     # Declarative GoRouter routing definitions
│   ├── services/                  # Core services (Dependency Injection helper, dimensions)
│   ├── theme/                     # Base custom styling, decoration, and gradient extensions
│   └── validator/                 # Input field validation rules
│
└── feature/                       # Independent modular feature folders
    ├── auth/                      # Login, signup, Firebase/Google registration flow
    ├── dashboard/                 # Main navigation layout shell (home / barcode scanner)
    ├── details/                   # Recipe details screen (ingredients, YouTube videos)
    ├── home/                      # Recipes Feed, category grids
    ├── profile/                   # User profile, history, settings
    ├── scanner/                   # Camerawesome ML Kit barcode scanner
    ├── search/                    # Search page with search filters
    ├── splash/                    # Splash screen initialization
    ├── user_sugestion/            # User onboarding questionnaire (area & category select)
    └── welcome/                   # Onboarding screen & user introduction
```

### 🧩 Detailed Feature Folder Structure
Every modular feature directory inside `lib/feature/...` is split into three clean layers:

1.  **Data Layer (`data/`)**:
    *   **Data Sources**: Remote API calling (`RemoteDataSource`) or Local Database caching (`LocalDataSource`).
    *   **Models**: Serialized JSON classes representing data payloads.
    *   **Repository Implementations**: Implementations of the domain interfaces mapping data source responses to domain entities.
2.  **Domain Layer (`domain/`)**:
    *   **Entities**: Pure Dart objects consumed by the presentation layer.
    *   **Use Cases**: Core business logic commands (e.g. `LoginWithEmailUsecase`, `GetDetailUsecase`).
    *   **Repository Interfaces**: Abstractions defining contracts for repository implementations.
3.  **Presentation Layer (`presentation/`)**:
    *   **BLoCs / Cubits**: Emits state transitions in response to user actions.
    *   **Screens**: Primary pages referenced by `GoRouter`.
    *   **Widgets**: Feature-specific sub-components.

---

## 🛠 Getting Started

### Prerequisites
*   [Flutter SDK](https://docs.flutter.dev/get-started/install) (version `>= 3.10.0`)
*   [Cocoapods](https://cocoapods.org/) (for iOS builds)
*   Firebase console account configured for Android & iOS bundle IDs.

### Setup Instructions

1.  **Install dependencies**:
    ```bash
    make init
    ```
    *(Or run `flutter pub get`)*

2.  **Clean up previous builds (if needed)**:
    ```bash
    make clean
    ```
    *(Or run `flutter clean`)*

3.  **Run the application**:
    ```bash
    make run
    ```
    *(Or run `flutter run`)*

---

## ⚙️ Development Config & Scripts

A `makefile` is available in the root directory for standard terminal commands:
*   `make init`: Runs `flutter pub get` to fetch dependencies.
*   `make clean`: Runs `flutter clean` to wipe build directories.
*   `make run`: Boots up the app on an active emulator or device.
