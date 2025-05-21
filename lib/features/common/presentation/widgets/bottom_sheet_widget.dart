import 'package:flutter/material.dart';

class BottomSheetWidget extends StatelessWidget {
  final Widget body;
  final bool isFullScreen;
  final VoidCallback? onClose;
  final double? initialChildSize;
  final double? minChildSize;
  final double? maxChildSize;
  final String title;

  const BottomSheetWidget({
    super.key,
    required this.body,
    this.isFullScreen = false,
    this.onClose,
    this.initialChildSize,
    this.minChildSize,
    this.maxChildSize,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: isFullScreen ? 1 : initialChildSize ?? 0.44,
      minChildSize: minChildSize ?? 0.3,
      maxChildSize: isFullScreen ? 1.0 : maxChildSize ?? 1,
      expand: isFullScreen,
      builder: (BuildContext context, ScrollController scrollController) {
        return Container(
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.only(top: 46),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondaryContainer,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(6)),
          ),
          child: Container(
            margin: const EdgeInsets.only(bottom: 16),
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 12),
                        child: Text(
                          title,
                          style: Theme.of(context).textTheme.titleMedium,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: onClose ?? () => Navigator.pop(context),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    controller: scrollController,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: body,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

Future<T?> showTheBottomSheet<T>({
  required BuildContext context,
  required Widget body,
  required String title,
  bool isFullScreen = false,
  VoidCallback? onClose,
  double? initialChildSize,
  double? minChildSize,
  double? maxChildSize,
  bool isScrollControlled = false,
}) {
  return showModalBottomSheet<T>(
    context: context,
    isScrollControlled: isFullScreen ? true : isScrollControlled,
    backgroundColor: Colors.transparent,
    builder: (BuildContext context) {
      return BottomSheetWidget(
        title: title,
        body: body,
        isFullScreen: isFullScreen,
        onClose: onClose,
        initialChildSize: initialChildSize,
        minChildSize: minChildSize,
        maxChildSize: maxChildSize,
      );
    },
  );
}
