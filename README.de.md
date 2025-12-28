# Flutter-Projektstruktur
Dieses Dokument beschreibt die Organisation eines Flutter-Projekts nach einer sauberen und modularen Architektur.

---

## Ordnerstruktur
```plaintext
lib/
├── main.dart                   # Einstiegspunkt der Anwendung. Ruft runApp(AppBootstrap()) auf.
│
├── bootstrap/                  # Initialisierung und globale Konfiguration
│   ├── app_bootstrap.dart      # Allgemeine App-Initialisierung (GetIt, HydratedBloc, globale Dienste)
│   ├── app_config.dart         # Konfiguration für Endpunkte, Clients, globale Variablen
│   └── injection.dart          # Abhängigkeitsregistrierung nach Feature und globale Abhängigkeiten
│
├── core/                       # Wiederverwendbare Logik und Ressourcen in der gesamten App
│   ├── network/
│   │   ├── api_client.dart     # Basis-Client und Dependency Injection für mehrere APIs
│   │   ├── interceptors/
│   ├── error/
│   │   └── failure.dart                # Globale Fehler- und Ausfallbehandlung
│   │   └── error_translations.dart     # Ordnet Fehler benutzerfreundlichen Nachrichten zu
│   ├── i18n/
│   │   ├── localization.dart
│   │   └── en.arb / es.arb     # Internationalisierung und Übersetzungsdateien
│   ├── themes/
│   │   ├── app_colors.dart
│   │   ├── app_text_styles.dart
│   │   └── app_theme.dart      # Definiert Farben, Typografie und globales App-Theme
│   ├── services/
│   │   ├── analytics_service.dart
│   │   ├── notification_service.dart
│   │   ├── push_service.dart
│   │   └── crashlytics_service.dart # Globale Dienste (Analytics, Benachrichtigungen, Crashlytics, etc.)
│   ├── repositories/
│   │   └── user_repository.dart # Gemeinsame Daten-Repositories
│   └── utils/
│       ├── validators.dart
│       ├── date_utils.dart
│       └── logger.dart         # Allgemeine Hilfsfunktionen und Dienstprogramme
│
├── features/                   # App-Funktionalitäten, nach Domäne getrennt
│   ├── auth/
│   │   ├── presentation/bloc/
│   │   ├── presentation/pages/
│   │   ├── data/remote/
│   │   ├── data/models/
│   │   └── domain/
│   └── home/
│       ├── presentation/bloc/
│       ├── presentation/pages/
│       ├── data/remote/
│       ├── data/models/
│       └── domain/
│
├── shared/                     # Wiederverwendbare Komponenten, Erweiterungen und Konstanten
│   ├── widgets/
│   ├── extensions/
│   └── constants/
│
├── data/                       # Lokale und entfernte Datenspeicherung
│   ├── local/
│   └── remote/
│
├── blocs/                      # Optionaler Ordner für globale oder gemeinsame BLoCs
│
├── utils/                      # Zusätzliche Hilfsfunktionen
│
└── assets/                     # App-Ressourcen: Bilder, Schriftarten, Icons, etc.
```

---

## Hinweise

- Jedes **Feature** hat seine eigene Struktur: `presentation`, `data`, `domain`.
- `core` enthält alle wiederverwendbare Logik, einschließlich Themes, Dienste, Dienstprogramme und Fehlerbehandlung.
- `bootstrap` zentralisiert die App-Initialisierung und Dependency Injection.
- `shared` enthält Widgets, Erweiterungen und Konstanten, die von jedem Feature verwendet werden können.
- `data/local` und `data/remote` trennen die lokale Persistenzlogik von der API-Kommunikation.

---