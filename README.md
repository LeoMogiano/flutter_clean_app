# Estructura del Proyecto Flutter

Este documento describe la organización del proyecto Flutter siguiendo una arquitectura limpia y modular.

---

## Estructura de Carpetas

```plaintext
lib/
├── main.dart                   # Punto de entrada de la aplicación. Llama a runApp(AppBootstrap()).
│
├── bootstrap/                  # Inicialización y configuración global
│   ├── app_bootstrap.dart      # Inicialización general de la app (GetIt, HydratedBloc, servicios globales)
│   ├── app_config.dart         # Configuración de endpoints, clientes, variables globales
│   └── injection.dart          # Registro de dependencias por feature y dependencias globales
│
├── core/                       # Lógica y recursos reutilizables de la app
│   ├── network/
│   │   ├── api_client.dart     #Cliente Base y uso de injección de dependencias para multiples APIs
│   │   ├── interceptors/
│   ├── error/
│   │   └── failure.dart                # Manejo de errores y fallos globales
│   │   └── error_translations.dart     # Mapeo de errores a mensajes de usuario
│   ├── i18n/
│   │   ├── localization.dart
│   │   └── en.arb / es.arb     # Archivos de internacionalización y traducciones
│   ├── themes/
│   │   ├── app_colors.dart
│   │   ├── app_text_styles.dart
│   │   └── app_theme.dart      # Definición de colores, tipografía y theme global de la app
│   ├── services/
│   │   ├── analytics_service.dart
│   │   ├── notification_service.dart
│   │   ├── push_service.dart
│   │   └── crashlytics_service.dart # Servicios globales (analítica, notificaciones, crashlytics, etc.)
│   ├── repositories/
│   │   └── user_repository.dart # Repositorios de datos compartidos
│   └── utils/
│       ├── validators.dart
│       ├── date_utils.dart
│       └── logger.dart         # Funciones y utilidades generales
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
├── shared/                     # Componentes, extensiones y constantes reutilizables
│   ├── widgets/
│   ├── extensions/
│   └── constants/
│
├── data/                       # Almacenamiento local y remoto de datos
│   ├── local/
│   └── remote/
│
├── blocs/                      # Carpeta opcional para BLoCs globales o compartidos
│
├── utils/                      # Funciones utilitarias adicionales
│
└── assets/                     # Recursos de la app: imágenes, fuentes, iconos, etc.
```

---

## Notas

- Cada **feature** tiene su propia estructura: `presentation`, `data`, `domain`.
- `core` contiene todo lo reutilizable, incluyendo temas, servicios, utilidades y manejo de errores.
- `bootstrap` centraliza la inicialización de la app y la inyección de dependencias.
- `shared` guarda widgets, extensiones y constantes que pueden usarse en cualquier feature.
- `data/local` y `data/remote` separan la lógica de persistencia local y comunicación con APIs.

---