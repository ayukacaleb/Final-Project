import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('Pioneer SACCO'),
      backgroundColor: Colors.red[700],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
