import 'package:flutter/material.dart';

class IAMScreen extends StatefulWidget {
  const IAMScreen({super.key});

  @override
  State<IAMScreen> createState() => _IAMScreenState();
}

class _IAMScreenState extends State<IAMScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text('IAM Screen', style: Theme.of(context).textTheme.headlineSmall),
      ),
    );
  }
}
