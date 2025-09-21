import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:notion_clone/app_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");

  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
  );

  // KAKAO_NATIVE_KEY를 Info.plist와 동일한 값으로 직접 설정하여 불일치 문제를 해결합니다.
  const kakaoNativeKey = '68fa31fe004743ebbca4d08156c22265';
  final kakaoJavaScriptKey = dotenv.env['KAKAO_JS_KEY'];

  if (kakaoJavaScriptKey == null) {
    throw Exception('KAKAO_JS_KEY is not set in .env file');
  }

  KakaoSdk.init(
    nativeAppKey: kakaoNativeKey,
    javaScriptAppKey: kakaoJavaScriptKey,
  );

  final router = createRouter();

  runApp(MyApp(router: router));
}

class MyApp extends StatelessWidget {
  final GoRouter router;

  const MyApp({super.key, required this.router});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: router,
      title: 'Notion Clone',
      theme: ThemeData.dark(),
    );
  }
}
