## Purpose
Short, actionable guidance for AI coding agents working on the Medical Center Flutter app.

## Big picture (what to know first)
- Architecture: Clean Architecture split across:
  - presentation: `lib/presentation/*` (screens, routes, widgets)
  - logic: `lib/logic/providers` (Flutter `ChangeNotifier` providers)
  - domain: `lib/domain` (entities + usecases)
  - data: `lib/data` (services, repositories, models)
  - core: `lib/core` (constants, theme, utils)
- Data flow: UI -> Provider (presentation/logic) -> UseCase (domain) -> Repository (data/repositories/*) -> Service (data/services/*) -> remote API
- Wiring: Most service/repository/usecase/provider instances are created and registered in `lib/main.dart` inside `MultiProvider`. Edit `main.dart` when adding providers or new top-level dependencies.

## Key files to consult
- `lib/main.dart` — app wiring, default `Locale('ar')`, `initialRoute` and `MultiProvider` registration.
- `lib/core/constants.dart` — `ApiConstSystemAll` holds API base URLs (update here for backend host changes).
- `lib/presentation/routes/app_routes.dart` — route names and `onGenerateRoute` implementation.
- `lib/logic/providers/*` — providers implement `ChangeNotifier` and expose `fetch...` methods used by screens.
- `lib/data/services/*` and `lib/data/repositories/*_impl.dart` — HTTP calls live in services; repositories adapt service calls into domain-friendly results.

## Project-specific conventions
- Naming:
  - Providers: `XxxProvider` in `lib/logic/providers`
  - Use cases: `GetSomething`, `RegisterPatientUseCaseImpl` in `lib/domain/usecases`
  - Repository implementations: `XxxRepositoryImpl` in `lib/data/repositories`
  - Services: `XxxService` in `lib/data/services`
- UI patterns:
  - Screens expect an `invoiceId` and usually call `Provider.of<...>(context, listen: false).fetchResults(invoiceId)` in `initState()` (often wrapped in `Future.microtask`). See `lib/presentation/screens/diagnosis_screen.dart` for an example.
  - Many screens enforce RTL via `Directionality(textDirection: TextDirection.rtl)` and use the Cairo font (`GoogleFonts.cairo`) — `kArabicFont = 'Cairo'` in `core/constants.dart`.

## How to run, debug & test (practical)
- Get dependencies: `flutter pub get`
- Run on device/emulator: `flutter run -d <device-id>` (app default route is `/welcome` and default locale is Arabic)
- Run unit/widget tests: `flutter test` (there's a `test/widget_test.dart` starter file)
- Static analysis / lint: `flutter analyze` (project includes `flutter_lints` and `analysis_options.yaml`)

## Integration & environment notes
- Backend: API base URLs are hard-coded in `lib/core/constants.dart` (host `http://engmalek:8443/...` in this copy). For local or CI runs, update `ApiConstSystemAll` or refactor to use environment/config-based injection.
- Navigation: uses `NavigationService.navigatorKey` and `AppRoutes.generateRoute` — prefer route names rather than pushing raw widgets.
- Exports: PDF, sharing and QR features are available (`printing`, `qr_flutter`, `share_plus`) — check `lib/presentation/shared/widgets` for export helpers.

## Common change recipe (how to add a new remote-backed screen)
1. Add a service in `lib/data/services/` to wrap HTTP calls.
2. Add a repository impl in `lib/data/repositories/` that depends on the service and returns domain models.
3. Add a usecase in `lib/domain/usecases/` that depends on the repository.
4. Add a provider in `lib/logic/providers/` that depends on the usecase and exposes `fetch...` and `isLoading`/`results`.
5. Register the service/repo/usecase/provider in `lib/main.dart` `MultiProvider` (follow existing patterns).
6. Add a route in `lib/presentation/routes/app_routes.dart` and a screen in `lib/presentation/screens/` that accepts required params (e.g., `invoiceId`) and calls the provider in `initState()`.

## Examples (from this codebase)
- Fetch-on-open pattern (see `diagnosis_screen.dart`):
  - `Future.microtask(() { Provider.of<DiagnosisResultProvider>(context, listen: false).fetchResults(widget.invoiceId); });`
- API constants (modify for environment):
  - `lib/core/constants.dart` -> `ApiConstSystemAll.basePatientUrl`

## What to avoid / gotchas
- Do not assume English LTR layout — many screens are RTL by default.
- The backend host may be local/host-specific. Confirm `ApiConstSystemAll` before running integration tests.
- When adding a provider, remember to register it in `main.dart` or the provider won't be available to screens.

## If you get stuck
- Inspect `lib/main.dart` to understand which providers/usecases exist and how they're constructed.
- Search `fetchResults(` across `lib/logic/providers` to find similar patterns.

---
If any section is unclear or you'd like more examples (route wiring, a typical service implementation, or a suggested refactor to centralize API host configuration), tell me which area to expand.
