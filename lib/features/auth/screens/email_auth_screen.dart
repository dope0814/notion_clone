import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:notion_clone/features/auth/screens/login_screen.dart';
import 'package:notion_clone/features/auth/widgets/footer_text.dart';
import 'package:pinput/pinput.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class EmailAuthScreen extends StatefulWidget {
  final String email;
  const EmailAuthScreen({super.key, required this.email});

  @override
  State<EmailAuthScreen> createState() => _EmailAuthScreenState();
}

class _EmailAuthScreenState extends State<EmailAuthScreen> {
  int _seconds = 60;
  bool _resendEnabled = false;
  late Timer _timer;

  final _otpController = TextEditingController();
  bool _isLoading = false;

  @override
  void initState() {
    print('email: ${widget.email}');
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    _otpController.dispose();
    super.dispose();
  }

  void _startTimer() {
    _resendEnabled = false;
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (_seconds > 0) {
        setState(() {
          _seconds--;
        });
      } else {
        setState(() {
          _resendEnabled = true;
        });
        _timer.cancel();
      }
    });
  }

  void _verifyOtp() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final res = await supabase.auth.verifyOTP(
        type: OtpType.email,
        token: _otpController.text,
        email: widget.email,
      );
      // context.go('/home');
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('오류 발생: ${e.toString()}')));
      }
    }
    setState(() {
      _isLoading = false;
    });
  }

  void _resendOtp() async {
    try {
      await supabase.auth.signInWithOtp(
        email: widget.email,
        emailRedirectTo: 'io.supabase.flutterquickstart://login-callback',
      );

      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('인증 코드를 다시 보냈습니다.')));
      }

      setState(() {
        _seconds = 60;
      });
      _startTimer();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('오류 발생: ${e.toString()}')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.arrow_back_ios),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                '이메일 인증 코드를 입력하세요.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 40),
              Pinput(
                controller: _otpController,
                length: 6,
                autofocus: true,
                defaultPinTheme: PinTheme(
                  width: 56,
                  height: 56,
                  textStyle: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey[700]!),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              if (_isLoading)
                const Center(child: CircularProgressIndicator())
              else
                ElevatedButton(
                  onPressed: _verifyOtp,
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('계속하기'),
                ),

              const SizedBox(height: 24),
              TextButton(
                onPressed: _resendEnabled ? _resendOtp : null,

                child: Text(
                  !_resendEnabled ? '$_seconds초 후 재전송' : "인증코드 재전송하기",
                  style:
                      !_resendEnabled
                          ? TextStyle(color: Colors.grey[500])
                          : TextStyle(
                            fontSize: 18,
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                ),
              ),
              const SizedBox(height: 24),
              FooterText(),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
