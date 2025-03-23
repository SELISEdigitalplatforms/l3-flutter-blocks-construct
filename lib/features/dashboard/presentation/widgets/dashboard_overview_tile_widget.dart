import 'package:flutter/material.dart';

class DashboardOverviewTileWidget extends StatelessWidget {
  final String title;
  final String value;
  final String growth;
  final String image;
  final bool trending;
  final String duration;

  const DashboardOverviewTileWidget({
    super.key,
    required this.title,
    required this.value,
    required this.growth,
    required this.image,
    required this.trending,
    required this.duration,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.titleSmall,
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: theme.textTheme.headlineMedium,
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(image),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            Icon(
              trending ? Icons.trending_up : Icons.trending_down,
              size: 16,
              color: trending ? theme.colorScheme.tertiary : theme.colorScheme.onError,
            ),
            const SizedBox(width: 4),
            Text(
              growth,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: trending ? theme.colorScheme.tertiary : theme.colorScheme.onError,
              ),
            ),
            const SizedBox(width: 4),
            Text(
              "from last $duration",
              style: theme.textTheme.titleSmall,
            ),
          ],
        ),
      ],
    );
  }
}
