import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noty/ui/pages/main/splash_screen.dart';
import 'package:noty/utils/themes/decorations.dart';

final gRef = ProviderContainer();
void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
      UncontrolledProviderScope(container: gRef, child: const SplashScreen()));
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
    systemNavigationBarColor: Decorations.bgColor1,
    systemNavigationBarIconBrightness: Brightness.dark,
  ));
}
