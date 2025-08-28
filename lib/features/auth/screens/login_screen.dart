import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:notion_clone/features/auth/widgets/footer_text.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _showEmailInput = false;
  bool _isLoading = false;
  bool _isEmail = true;
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
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
    setState(() {
      _isLoading = true;
    });
    try {
      await supabase.auth.signInWithOtp(
        email: _emailController.text,
        emailRedirectTo: 'io.supabase.flutterquickstart://login-callback',
      );
      if (mounted) {
        context.push('/email-auth/${_emailController.text}');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('오류 발생: ${e.toString()}')));
        print(e.toString());
      }
    }
    setState(() {
      _isLoading = false;
    });
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
                        _isEmail = false;
                      }),
                ),
                _LoginButton(
                  icon: Icons.mail_outline,
                  text: "이메일로 계속하기",
                  onPressed:
                      () => setState(() {
                        _showEmailInput = true;
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
                FooterText(),
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
          onSubmitted: (_) => _signInWithEmailOtp(),
        ),
        const SizedBox(height: 4),
        const Text(
          '조직 이메일을 사용하여 팀원들과 쉽게 협업하세요.',
          style: TextStyle(fontSize: 12, color: Colors.grey),
        ),
        const SizedBox(height: 16),

        if (_isLoading)
          const Center(child: CircularProgressIndicator())
        else
          ElevatedButton(
            onPressed: () {
              _signInWithEmailOtp();
              // context.push('/email-auth/${_emailController.text}');
            },
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 14),
            ),
            child: Text(_isEmail ? '계속' : 'SSO로 계속하기'),
          ),
        const SizedBox(height: 16),
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
