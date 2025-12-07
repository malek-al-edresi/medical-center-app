
# Medical Center App 🏥

A professional Flutter mobile application built using **Clean Architecture** to manage patient data and medical results for a medical center.

---

## 📦 Features

- 🔍 Fetch data dynamically using `invoiceId`
- 🧍 Patient information display
- 💉 Lab results view
- 🩻 Radiology (X-ray) results
- 💊 Diagnosis and treatment sections
- 📋 Unified card design using `UnifiedInfoCard`
- 🌐 Localization support (Arabic & English)
- 📤 PDF export, share & QR code generation
- 🧱 Structured with **Provider**, **UseCases**, and **Repositories**
- 💎 Modern UI using **GetWidget**, **Google Fonts**, and **Animate_do**

---

## 🗂️ Project Structure

```
lib/
├── core/
│   └── theme, constants, utils
├── data/
│   └── services, repositories, models
├── domain/
│   └── entities, usecases
├── logic/
│   └── providers
├── presentation/
│   └── screens, widgets, routes
```

---

## 🛠️ How to Run

1. Make sure Flutter SDK is installed.
2. Clone the project and run:

```bash
flutter pub get
flutter run
```

3. Ensure backend API (ORDS or similar) is active and reachable.

---

## 📄 Dependencies

- `provider`
- `getwidget`
- `google_fonts`
- `animate_do`
- `intl`
- `pdf`, `printing`, `share_plus`, `qr_flutter`

---

## 📍 Notes

- All screens expect a valid `invoiceId` to fetch data.
- UI follows RTL (Arabic) layout by default.
- Easily extendable and maintainable using Clean Architecture.

---

## ✨ Author

Developed by **Malek Al-edresi** – 2025 💼

---

# medical-center-app
