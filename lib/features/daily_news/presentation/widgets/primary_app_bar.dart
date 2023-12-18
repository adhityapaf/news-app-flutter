import 'package:flutter/material.dart';

class PrimaryAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool isLeadingDisabled;
  final String? title;
  final List<Widget>? actions;
  const PrimaryAppBar({
    super.key,
    this.isLeadingDisabled = false,
    this.title,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: _BuildLeading(isDisabled: isLeadingDisabled),
      title: _BuildTitle(title: title),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _BuildLeading extends StatelessWidget {
  final bool isDisabled;
  const _BuildLeading({required this.isDisabled});

  @override
  Widget build(BuildContext context) {
    if (!isDisabled) {
      return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => Navigator.pop(context),
        child: const Icon(
          Icons.arrow_back_ios_new,
          color: Colors.black,
        ),
      );
    }
    return const SizedBox();
  }
}

class _BuildTitle extends StatelessWidget {
  final String? title;
  const _BuildTitle({this.title});

  @override
  Widget build(BuildContext context) {
    if (title != null) {
      return Text(
        title ?? '-',
        style: const TextStyle(color: Colors.black),
      );
    }
    return const SizedBox();
  }
}
