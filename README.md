# Medical Center App 🏥

A professional, production-ready Flutter mobile application designed for medical centers to manage patient data, invoices, and medical results. This app serves as a frontend for an **Oracle APEX** based hospital management system.

Built with strict **Clean Architecture** principles and **BLoC (Cubit)** pattern to ensure scalability, maintainability, and testability.

---

## 🚀 Application Overview

The app acts as a secure patient portal and medical record viewer, empowering patients to:
- 🔍 **Track Records**: Retrieve medical records using a unique **Invoice ID**.
- 👤 **Patient Profile**: View comprehensive **Patient Information**.
- 🧪 **Lab Results**: Access detailed laboratory test results with normal ranges and abnormalities highlighted.
- 🩻 **Radiology**: View radiology reports and images.
- 💊 **Treatments**: Access diagnosis details and prescribed treatment plans.
- 🩺 **Diagnosis**: View detailed diagnosis information.
- 📄 **PDF Reports**: **Share** or **Save** official medical reports as PDF.
- 🌍 **Localization**: Seamlessly toggle between **English** and **Arabic** (Full RTL support).

---

## 🏗️ Architecture

This project strictly follows **Clean Architecture** combined with **BLoC (Cubit)** pattern, ensuring clear separation of concerns:

### 1. Presentation Layer (`lib/presentation/`)
Responsible for specific UI code and State Management.
- **Screens**: UI pages (e.g., `HomeScreen`, `LabResultsScreen`).
- **Blocs**: State management using Cubits (e.g., `PatientCubit`).
- **Widgets**: Reusable UI components (e.g., `ResultCard`, `SectionHeader`).
- **Routes**: Centralized navigation management via `AppRoutes`.

### 2. Domain Layer (`lib/domain/`)
The inner-most layer, containing pure business logic. **No Flutter dependencies** (mostly).
- **Entities**: Pure Dart objects representing core business data (e.g., `PatientEntity`, `LabResultEntity`).
- **Repositories (Interfaces)**: Abstract contracts defining data operations (e.g., `MedicalRepository`).
- **UseCases**: Encapsulate specific business rules (e.g., `GetLabResults`).

### 3. Data Layer (`lib/data/`)
Responsible for data retrieval and manipulation.
- **Models**: DTOs (Data Transfer Objects) handling JSON parsing/serialization (e.g., `LabResultModel`).
- **Datasources**: Remote API interaction logic (e.g., `MedicalApiService`).
- **Repositories (Implementations)**: Concrete implementations of domain repositories using datasources.

### 4. Core Layer (`lib/core/`)
Cross-cutting concerns and shared utilities.
- **Constants**: App-wide constants (Colors, Dimensions, Strings).
- **Network**: HTTP overrides and configurations.
- **Utils**: Helper classes (Date formatting, PDF generation).
- **Widgets**: Generic widgets shared across the app (Loaders, Error Views).

---

## 🗂️ Project Structure

```bash
lib/
├── core/                   # Shared utilities, constants, theme, network
│   ├── constants/
│   ├── error/
│   ├── localization/
│   ├── network/
│   ├── theme/
│   ├── utils/
│   └── widgets/
├── data/                   # Data layer implementation
│   ├── datasources/        # Remote API services
│   ├── models/             # Data models (JSON parsing)
│   └── repositories/       # Repository implementations
├── domain/                 # Business logic definitions
│   ├── entities/           # Pure business objects
│   ├── repositories/       # Repository interfaces
│   └── usecases/           # Application business rules
├── presentation/           # UI Layer & State Management
│   ├── blocs/              # BLoC/Cubit implementations
│   ├── routes/             # Navigation configuration
│   ├── screens/            # App pages
│   └── widgets/            # Reusable UI components
└── main.dart               # App entry point
```

---

## 🛠️ Tech Stack & Dependencies

- **Framework**: [Flutter](https://flutter.dev/) (SDK 3.x)
- **Language**: Dart
- **State Management**: [flutter_bloc](https://pub.dev/packages/flutter_bloc) (Cubit)
- **Networking**: [http](https://pub.dev/packages/http)
- **UI & Design**:
  - [GetWidget](https://pub.dev/packages/getwidget) for standard components.
  - [Glassmorphism](https://pub.dev/packages/glassmorphism) for modern UI effects.
  - [Google Fonts](https://pub.dev/packages/google_fonts) for typography.
  - [Flutter Animate](https://pub.dev/packages/flutter_animate) & [Animate Do](https://pub.dev/packages/animate_do) for animations.
- **Utilities**:
  - `printing` & `syncfusion_flutter_pdf` for PDF generation.
  - `flutter_localization` for Internationalization.
  - `share_plus` for sharing content.

---

## ⚙️ Setup & Installation

1. **Prerequisites**: Ensure you have Flutter SDK installed and environment set up.
2. **Clone the Repository**:
   ```bash
   git clone <repository-url>
   cd medical_center_system
   ```
3. **Install Dependencies**:
   ```bash
   flutter pub get
   ```
4. **Run the App**:
   ```bash
   flutter run
   ```

---

## 🌍 Localization

The app supports **English (en)** and **Arabic (ar)**.
- **RTL Support**: The UI automatically mirrors for Arabic language.
- **Switching**: Users can toggle language directly from the Home Screen app bar.

---

## ✨ Author

Developed by **Malek Al-edresi** – 2025 💼
