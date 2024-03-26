import 'package:flutter/material.dart';

class DrawerTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onPressed;

  const DrawerTile({super.key, 
    required this.title,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
        child: Row(
          children: [
            Icon(
              icon,
              size: 24,
              color: Colors.black54,
            ),
            const SizedBox(width: 20),
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black87,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
