import 'package:flutter/cupertino.dart';

class PrimaryLoading extends StatelessWidget {
  const PrimaryLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CupertinoActivityIndicator(),
    );
  }
}
