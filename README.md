# Medical Center App 🏥

A professional, production-ready Flutter mobile application designed for medical centers to manage patient data, invoices, and medical results. Built with **Clean Architecture** principles to ensure scalability, maintainability, and testability.

---

## 🚀 Application Overview

The app serves as a patient portal and medical record viewer, allowing users to:
- Retrieve medical records using a unique **Invoice ID**.
- View comprehensive **Patient Information**.
- Access detailed **Lab Results**, **Radiology Images**, **Diagnosis**, and **Treatment Plans**.
- **Share** or **Save** reports as PDF.
- Toggle between **English** and **Arabic** (RTL support).

---

## 🏗️ Architecture

This project follows **Clean Architecture** combined with **MVVM** pattern:

### 1. Presentation Layer (`lib/presentation/`)
- **Screens**: UI pages (Home, InvoiceDetails, LabResults, etc.).
- **Widgets**: Reusable components (ResultCard, CustomTextField, etc.).
- **State Management**: Uses `Provider` for state injection and management.

### 2. Domain Layer (`lib/domain/`)
- **Entities**: Pure Dart objects representing core business data.
- **Repositories (Interfaces)**: Abstract contracts defining data operations.
- **UseCases**: Encapsulate specific business logic (e.g., `GetPatientByInvoice`).

### 3. Data Layer (`lib/data/`)
- **Models**: DTOs (Data Transfer Objects) that handle JSON parsing and serialization.
- **Datasources**: Remote API definitions (using `http`).
- **Repositories (Implementations)**: Concrete implementations of domain repositories.

### 4. Core Layer (`lib/core/`)
- **Utils**: Shared utilities (Theme, Constants, Exception Handling).
- **Localization**: Multi-language support configuration.

---

## 🗂️ Project Structure

```bash
lib/
├── core/                   # Core utilities, constants, theme, and errors
├── data/                   
│   ├── datasources/        # Remote API services
│   ├── models/             # Data models (JSON parsing)
│   └── repositories/       # Repository implementations
├── domain/
│   ├── entities/           # Business entities
│   ├── repositories/       # Repository interfaces
│   └── usecases/           # Application business rules
├── logic/
│   └── providers/          # State management (Provider)
├── presentation/
│   ├── routes/             # Navigation configuration
│   ├── screens/            # App screens
│   └── widgets/            # Reusable UI components
└── main.dart               # App entry point
```

---

## 🛠️ Tech Stack & Dependencies

- **Framework**: [Flutter](https://flutter.dev/)
- **State Management**: [Provider](https://pub.dev/packages/provider)
- **Networking**: [http](https://pub.dev/packages/http)
- **UI Components**: [GetWidget](https://pub.dev/packages/getwidget), [Flashy Tab Bar](https://pub.dev/packages/flashy_tab_bar2)
- **Animations**: [Animate Do](https://pub.dev/packages/animate_do), [Flutter Animate](https://pub.dev/packages/flutter_animate)
- **Utilities**: 
  - `share_plus` (File sharing)
  - `syncfusion_flutter_pdf` (PDF generation)
  - `flutter_localization` (Internationalization)
  - `google_fonts` (Typography)

---

## ⚙️ Setup & Installation

1. **Prerequisites**: Ensure you have Flutter SDK installed (Version 3.x+).
2. **Clone the Repository**:
   ```bash
   git clone https://github.com/your-username/medical-center-app.git
   cd medical-center-app
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

The app supports **English** and **Arabic**. 
The locale is automatically handled based on user preference or device settings, with full **RTL (Right-to-Left)** layout support for Arabic.

---

## 🤝 Contribution

1. Fork the Project.
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`).
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`).
4. Push to the Branch (`git push origin feature/AmazingFeature`).
5. Open a Pull Request.

---

## ✨ Author

Developed by **Malek Al-edresi** – 2025 💼
