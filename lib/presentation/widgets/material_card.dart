import 'package:flutter/material.dart';
import '../../core/resources/theme/theme.dart';

class TierMaterialCard extends StatelessWidget {
  final String title;
  final int quantity;
  final int tier;

  const TierMaterialCard({
    super.key,
    required this.title,
    required this.quantity,
    required this.tier,
  });

  Color _getTierColor(BuildContext context) {
    final rarityColors = Theme.of(context).extension<RarityColors>();
    
    if (rarityColors != null) {
      return rarityColors.getTierColor(tier);
    }
    
    // Fallback to original colors if the extension is not available
    switch (tier) {
      case 3:
        return Colors.purple;
      case 2:
        return Colors.blue;
      case 1:
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = _getTierColor(context);
    return Card(
      child: Container(
        width: 120,
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: color.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                Icons.storage,
                color: color,
                size: 32,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 12),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              'x$quantity',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}