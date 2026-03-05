import 'package:flutter/material.dart';

class HygiaDialog extends StatelessWidget {
  final String title;
  final String description;

  /// Put a Lottie/GIF/Image here. Example: Lottie.asset('assets/mascot.json')
  final Widget? sideMedia;

  final String? primaryText;
  final VoidCallback? onPrimary;

  final String? secondaryText;
  final VoidCallback? onSecondary;

  /// If you want a close (X) button in top-right
  final bool showClose;

  const HygiaDialog({
    super.key,
    required this.title,
    required this.description,
    this.sideMedia,
    this.primaryText,
    this.onPrimary,
    this.secondaryText,
    this.onSecondary,
    this.showClose = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Dialog(
      elevation: 0,
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420),
          child: Stack(
            children: [
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: theme.cardColor,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                    color: theme.dividerColor.withOpacity(0.18),
                  ),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 18,
                      offset: const Offset(0, 10),
                      color: Colors.black.withOpacity(0.10),
                    ),
                  ],
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Text side
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: theme.textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.w800,
                              height: 1.1,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            description,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              height: 1.25,
                              color: theme.textTheme.bodyMedium?.color
                                  ?.withOpacity(0.80),
                            ),
                          ),

                          // Buttons
                          if (primaryText != null || secondaryText != null) ...[
                            const SizedBox(height: 16),
                            Row(
                              children: [
                                if (secondaryText != null) ...[
                                  OutlinedButton(
                                    onPressed:
                                        onSecondary ??
                                        () => Navigator.pop(context),
                                    style: OutlinedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 14,
                                        vertical: 12,
                                      ),
                                    ),
                                    child: Text(secondaryText!),
                                  ),
                                  const SizedBox(width: 10),
                                ],
                                if (primaryText != null)
                                  Expanded(
                                    child: ElevatedButton(
                                      onPressed:
                                          onPrimary ??
                                          () => Navigator.pop(context),
                                      style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 14,
                                          vertical: 12,
                                        ),
                                      ),
                                      child: Text(primaryText!),
                                    ),
                                  ),
                              ],
                            ),
                          ],
                        ],
                      ),
                    ),

                    // Media side
                    if (sideMedia != null) ...[
                      const SizedBox(width: 14),
                      SizedBox(
                        width: 120,
                        height: 120,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(14),
                          child: Center(child: sideMedia),
                        ),
                      ),
                    ],
                  ],
                ),
              ),

              // Close button
              if (showClose)
                Positioned(
                  top: 6,
                  right: 6,
                  child: IconButton(
                    splashRadius: 18,
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                    tooltip: 'Close',
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
