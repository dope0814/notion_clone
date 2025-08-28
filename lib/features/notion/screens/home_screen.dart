import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:notion_clone/features/auth/screens/login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('홈'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              // 로그아웃 기능
              await supabase.auth.signOut();
              // 로그아웃 후 로그인 화면으로 이동
              if (context.mounted) {
                context.go('/login');
              }
            },
          ),
        ],
      ),
      body: const Center(child: Text('로그인에 성공했습니다!')),
    );
  }
}
