import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noty/ui/pages/main/splash_screen.dart';
import 'package:noty/utils/themes/decorations.dart';

final gRef = ProviderContainer();
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('google_fonts/OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });

  runApp(
      UncontrolledProviderScope(container: gRef, child: const SplashScreen()));
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
    systemNavigationBarColor: Decorations.bgColor1,
    systemNavigationBarIconBrightness: Brightness.dark,
  ));
}
