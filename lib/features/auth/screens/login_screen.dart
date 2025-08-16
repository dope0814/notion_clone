import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  void _loginWithGoogle(BuildContext context) {
    _showNotImplemented(context, 'Google');
  }

  void _showNotImplemented(BuildContext context, String feature) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$feature 로그인은 아직 구현되지 않았습니다.'),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(flex: 2),
              const Icon(Icons.ac_unit, size: 48),
              const SizedBox(height: 24),
              const Text(
                '상상하는 것은 무엇이든 만들 수 있어요.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),

              _LoginButton(
                icon: Icons.g_mobiledata,
                text: "Google 계정으로 계속하기",
                onPressd: () => _loginWithGoogle(context),
              ),
              _LoginButton(
                icon: Icons.apple,
                text: "Apple 계정으로 계속하기",
                onPressd: () => _loginWithGoogle(context),
              ),
              _LoginButton(
                icon: Icons.window,
                text: "Microsoft로 계속하기",
                onPressd: () => _loginWithGoogle(context),
              ),
              _LoginButton(
                icon: Icons.vpn_key_outlined,
                text: "패스키로 로그인",
                onPressd: () => _loginWithGoogle(context),
              ),
              _LoginButton(
                icon: Icons.business_center_outlined,
                text: "SSO(통합로그인)",
                onPressd: () => _loginWithGoogle(context),
              ),
              _LoginButton(
                icon: Icons.mail_outline,
                text: "이메일로 계속하기",
                onPressd: () => _loginWithGoogle(context),
              ),
              const Spacer(flex: 1),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: TextStyle(fontSize: 12, color: Colors.grey[500]),
                    children: [
                      const TextSpan(text: '계속 진행하면 '),
                      TextSpan(
                        text: '이용약관',
                        style: const TextStyle(
                          decoration: TextDecoration.underline,
                        ),
                        recognizer: TapGestureRecognizer()..onTap = () {},
                      ),
                      const TextSpan(text: "및 "),
                      TextSpan(
                        text: '개인정보처리방침',
                        style: const TextStyle(
                          decoration: TextDecoration.underline,
                        ),
                        recognizer: TapGestureRecognizer()..onTap = () {},
                      ),
                      const TextSpan(text: '을 이해하고 동의하는 것으로 간주됩니다.'),
                    ],
                  ),
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '이용약관 및 개인정보 보호정책',
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  ),
                  const SizedBox(width: 16),
                  Text(
                    '도움이 필요하세요?',
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                '© 2025 Notion Labs, Inc.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12, color: Colors.grey[700]),
              ),
              const Spacer(flex: 1),
            ],
          ),
        ),
      ),
    );
  }
}

class _LoginButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onPressd;

  const _LoginButton({
    required this.icon,
    required this.text,
    required this.onPressd,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6),
      child: OutlinedButton.icon(
        icon: Icon(icon, size: 28),
        onPressed: onPressd,
        label: Text(text),
        style: OutlinedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: Colors.grey[850],
          side: BorderSide(color: Colors.grey[700]!),
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }
}
