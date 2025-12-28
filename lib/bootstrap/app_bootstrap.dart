import 'dart:async';
import 'dart:developer' as dev;
import 'dart:io';

import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:my_app/bootstrap/app_config.dart';
import 'package:my_app/bootstrap/injection.dart';
import 'package:my_app/i18n/strings.g.dart';
import 'package:path_provider/path_provider.dart';

Future<void> bootstrap(Widget Function() builder) async {
  const tag = 'BOOT';
  dev.log('⚙️ Bootstrapping app', name: tag);
  await AppConfig.load();
  await injection();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: HydratedStorageDirectory((await getApplicationSupportDirectory()).path),
  );

  if (Platform.isAndroid) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.white,
        statusBarColor: Colors.white,
        statusBarBrightness: .dark,
        statusBarIconBrightness: .dark,
        systemNavigationBarIconBrightness: .dark,
      ),
    );
  }

  unawaited(LocaleSettings.useDeviceLocale());

  dev.log('🚀 App ready, launching', name: tag);
  runApp(
    TranslationProvider(
      child: DevicePreview(
        enabled: false,
        builder: (context) => builder(),
      ),
    ),
  );
}
