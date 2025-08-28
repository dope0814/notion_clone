import 'package:flutter/material.dart';

class FooterText extends StatelessWidget {
  const FooterText({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              '이용약관 및 개인정보 보호정책',
              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            ),
            SizedBox(width: 16),
            Text(
              '도움이 필요하세요?',
              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          '© 2025 Dope, Inc.',
          textAlign: TextAlign.start,
          style: TextStyle(fontSize: 12, color: Colors.grey[700]),
        ),
        const SizedBox(height: 48),
      ],
    );
  }
}
