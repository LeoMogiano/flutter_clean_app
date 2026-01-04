import 'package:flutter/material.dart';
import 'package:my_app/bootstrap/app_bootstrap.dart';
import 'package:my_app/bootstrap/app_provider.dart';
import 'package:my_app/core/theme/app_theme.dart';
import 'package:my_app/i18n/strings.g.dart';
import 'package:my_app/routes/app_router.dart';
import 'package:sizer/sizer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized().ensureSemantics();
  await bootstrap(() => const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (_, _, _) {
      return StateProviders(
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          locale: TranslationProvider.of(context).flutterLocale,
          theme: AppTheme.darkTheme,
          routerConfig: appRouter,
        ),
      );
    });
  }
}
