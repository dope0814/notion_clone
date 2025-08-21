import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _showEmailInput = false;
  bool _showOtpInput = false;
  final bool _isLoading = false;
  bool _isEmail = true;
  final _emailController = TextEditingController();
  final _otpController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _otpController.dispose();
    super.dispose();
  }

  //로그인 기능
  void _loginWithGoogle(BuildContext context) {
    _showNotImplemented('Google');
  }

  void _loginWithPassKey(BuildContext context) {
    _showNotImplemented('PassKey');
  }

  void _loginWithEmail(BuildContext context) {
    _showNotImplemented('Email');
  }

  void _showNotImplemented(String feature) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$feature 로그인은 아직 구현되지 않았습니다.'),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  //OTP 기능
  void _signInWithEmailOtp() async {
    if (_emailController.text.isEmpty) {
      _showNotImplemented('이메일을 입력해주세요.');
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 24),
                const Icon(Icons.ac_unit, size: 48),
                const SizedBox(height: 24),
                const Text(
                  '상상하는 것은 무엇이든 만들 수 있어요.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                _LoginButton(
                  icon: Icons.g_mobiledata_outlined,
                  text: "Google 계정으로 계속하기",
                  onPressed: () => _loginWithGoogle(context),
                ),
                _LoginButton(
                  icon: Icons.apple,
                  text: "Apple 계정으로 계속하기",
                  onPressed: () => _showNotImplemented("Apple"),
                ),
                _LoginButton(
                  icon: Icons.window,
                  text: "Microsoft로 계속하기",
                  onPressed: () => _showNotImplemented("Microsoft"),
                ),
                _LoginButton(
                  icon: Icons.vpn_key_outlined,
                  text: "패스키로 로그인",
                  onPressed: () => _loginWithPassKey(context),
                ),
                _LoginButton(
                  icon: Icons.business_center_outlined,
                  text: "SSO(통합로그인)",
                  onPressed:
                      () => setState(() {
                        _showEmailInput = true;
                        _showOtpInput = false;
                        _isEmail = false;
                      }),
                  // _showNotImplemented(context, "SSO"),
                ),
                _LoginButton(
                  icon: Icons.mail_outline,
                  text: "이메일로 계속하기",
                  onPressed:
                      () => setState(() {
                        _showEmailInput = true;
                        _showOtpInput = false;
                        _isEmail = true;
                      }),
                ),
                if (_showEmailInput) _buildEmailInputForm(),
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
                          text: '개인정보처리방\n침을 이해하고 동의하는 것으로 간주됩니다.',
                          style: const TextStyle(
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: TapGestureRecognizer()..onTap = () {},
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
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
                  textAlign: TextAlign.start,
                  style: TextStyle(fontSize: 12, color: Colors.grey[700]),
                ),
                const SizedBox(height: 48),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmailInputForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 8),
        const Divider(),
        const SizedBox(height: 8),
        const Text('이메일', style: TextStyle(fontSize: 12)),
        const SizedBox(height: 8),
        TextField(
          controller: _emailController,
          style: TextStyle(fontSize: 14),
          keyboardType: TextInputType.emailAddress,
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 10),
            hintText: '이메일 주소를 입력하세요',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          '조직 이메일을 사용하여 팀원들과 쉽게 협업하세요.',
          style: TextStyle(fontSize: 12, color: Colors.grey),
        ),
        const SizedBox(height: 16),
        if (_showOtpInput)
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                '인증 코드',
                style: TextStyle(fontSize: 12),
                textAlign: TextAlign.start,
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _otpController,
                style: TextStyle(fontSize: 14),
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  hintText: '코드 입력',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 10,
                  ),
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                '수신함으로 코드를 보내드렸습니다.',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),

        const SizedBox(height: 16),

        if (_isLoading)
          const Center(child: CircularProgressIndicator())
        else
          ElevatedButton(
            onPressed: () {
              setState(() {
                _showOtpInput = true;
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 8),
            ),
            child: Text(_isEmail ? '계속' : 'SSO로 계속하기'),
          ),
        const SizedBox(height: 16),
        if (_showOtpInput)
          const Text(
            '인증 코드 재전송하기',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: Colors.blueAccent),
          ),
      ],
    );
  }
}

class _LoginButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onPressed;

  const _LoginButton({
    required this.icon,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: Colors.black,
          side: BorderSide(color: Colors.grey[600]!),
          padding: const EdgeInsets.symmetric(vertical: 8),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Icon(icon, size: 28),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                text,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
