import 'package:flutter/material.dart';
import '../../../core/utils/color_generator.dart';

class AwakerCard extends StatelessWidget {
  final String name;
  final bool isActive;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;

  const AwakerCard({
    super.key,
    required this.name,
    required this.isActive,
    this.onTap,
    this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Card(
        child: Column(
          children: [
            Expanded(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: ColorGenerator.fromString(name),
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(4),
                      ),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.person,
                        size: 64,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  if (!isActive)
                    Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context)
                            .colorScheme
                            .shadow
                            .withValues(alpha: 0.8),
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(4),
                        ),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.mode_night,
                          size: 64,
                          color: Colors.white54,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                name,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: isActive ? null : Theme.of(context).disabledColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
