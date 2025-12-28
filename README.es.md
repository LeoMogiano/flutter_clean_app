# Estructura del Proyecto Flutter
Este documento describe la organización de un proyecto Flutter siguiendo una arquitectura limpia y modular.

---

## Estructura de Carpetas
```plaintext
lib/
├── main.dart                   # Punto de entrada de la aplicación. Llama a runApp(AppBootstrap()).
│
├── bootstrap/                  # Inicialización y configuración global
│   ├── app_bootstrap.dart      # Inicialización general de la app (GetIt, HydratedBloc, servicios globales)
│   ├── app_config.dart         # Configuración para endpoints, clientes, variables globales
│   └── injection.dart          # Registro de dependencias por característica y dependencias globales
│
├── core/                       # Lógica y recursos reutilizables en toda la app
│   ├── network/
│   │   ├── api_client.dart     # Cliente base e inyección de dependencias para múltiples APIs
│   │   ├── interceptors/
│   ├── error/
│   │   └── failure.dart                # Manejo global de errores y fallos
│   │   └── error_translations.dart     # Mapea errores a mensajes amigables para el usuario
│   ├── i18n/
│   │   ├── localization.dart
│   │   └── en.arb / es.arb     # Internacionalización y archivos de traducción
│   ├── themes/
│   │   ├── app_colors.dart
│   │   ├── app_text_styles.dart
│   │   └── app_theme.dart      # Define colores, tipografía y tema global de la app
│   ├── services/
│   │   ├── analytics_service.dart
│   │   ├── notification_service.dart
│   │   ├── push_service.dart
│   │   └── crashlytics_service.dart # Servicios globales (analytics, notificaciones, crashlytics, etc.)
│   ├── repositories/
│   │   └── user_repository.dart # Repositorios de datos compartidos
│   └── utils/
│       ├── validators.dart
│       ├── date_utils.dart
│       └── logger.dart         # Funciones auxiliares y utilidades generales
│
├── features/                   # Funcionalidades de la app, separadas por dominio
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
├── shared/                     # Componentes reutilizables, extensiones y constantes
│   ├── widgets/
│   ├── extensions/
│   └── constants/
│
├── data/                       # Almacenamiento de datos local y remoto
│   ├── local/
│   └── remote/
│
├── blocs/                      # Carpeta opcional para BLoCs globales o compartidos
│
├── utils/                      # Funciones de utilidad adicionales
│
└── assets/                     # Recursos de la app: imágenes, fuentes, iconos, etc.
```

---

## Notas

- Cada **característica** tiene su propia estructura: `presentation`, `data`, `domain`.
- `core` contiene toda la lógica reutilizable, incluyendo temas, servicios, utilidades y manejo de errores.
- `bootstrap` centraliza la inicialización de la app y la inyección de dependencias.
- `shared` contiene widgets, extensiones y constantes que pueden ser usadas por cualquier característica.
- `data/local` y `data/remote` separan la lógica de persistencia local de la comunicación con APIs.

---