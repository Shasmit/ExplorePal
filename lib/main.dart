import 'package:exploree_pal/core/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/common/widget/injection_container.dart' as di;

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
  di.init();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
}
