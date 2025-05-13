import 'package:flutter/material.dart';
import 'package:morimens_planner/core/data/models/awaker.dart';
import '../../core/resources/theme/theme.dart';
import '../../core/services/awaker_image_name.dart';

class AwakerCard extends StatelessWidget {
  final Awaker awaker;
  final bool isActive;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;

  const AwakerCard({
    super.key,
    required this.awaker,
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
                      color: Theme.of(context).extension<RealmColors>()?.getRealmColor(awaker.realm) ?? Colors.grey,
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(4),
                      ),
                    ),
                    child: Center(
                      child: Image(image: AssetImage(AwakerImageName.getCardPath(awaker)),)
                    ),
                  ),
                  if (!isActive)
                    Container(
                      decoration: BoxDecoration(
                        color: Theme.of(
                          context,
                        ).colorScheme.shadow.withValues(alpha: 0.8),
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
                awaker.name,
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
