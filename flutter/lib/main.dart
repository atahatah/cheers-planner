import 'package:cheers_planner/index.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'core/firebase/firebase_options.dart';

void main() async {
  usePathUrlStrategy();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseAppCheck.instance.activate(
    webProvider: ReCaptchaV3Provider(
      '6LdOtUcrAAAAAOcZEplc3ebjzTiO67N7iIXTgnRA',
    ),
    // androidProvider: AndroidProvider.debug,
    // appleProvider: AppleProvider.appAttest,
  );
  runApp(const ProviderScope(child: MyApp()));
}
