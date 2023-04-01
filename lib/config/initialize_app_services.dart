import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_projects/config/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../firebase_options.dart';

final initializeAppServicesProvider = Provider<InitializeAppServices>((ref) {
  return InitializeAppServices(ref);
});

class InitializeAppServices{
  final Ref ref;
  InitializeAppServices(this.ref);

  Future<void> init() async{
    WidgetsFlutterBinding.ensureInitialized();
    await ScreenUtil.ensureScreenSize();
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,);
    await ref.read(connectivityWatcherProvider).init();
    await ref.read(realTimeManagerProvider).init();

  }
}
