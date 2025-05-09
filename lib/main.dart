import 'package:clicks_interview_test/app/submission_form/presentation/pages/submission_form_screen.dart';
import 'package:clicks_interview_test/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

void main() => runApp(ClicksMachineTestApp());

class ClicksMachineTestApp extends StatelessWidget {
  const ClicksMachineTestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Interview Test',
      theme: AppTheme.dark,
      debugShowCheckedModeBanner: false,
      home: SubmissionFormScreen(),
    );
  }
}
