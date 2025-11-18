import 'package:flutter/material.dart';

class UserCard extends StatelessWidget {
  final String userName;
  final String location;
  final String? userProfileImageUrl;
  final VoidCallback? onTap;

  const UserCard({
    super.key,
    required this.userName,
    required this.location,
    this.userProfileImageUrl,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // Set a defined width for the card, as requested
      width: 160,
      child: Card(
        color: Colors.grey.shade50,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        elevation: 3.0,
        clipBehavior: Clip.antiAlias, // For the InkWell ripple
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              // Make the card only as tall as its content
              mainAxisSize: MainAxisSize.min,
              // Center the content
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // --- Profile Picture ---
                CircleAvatar(
                  radius: 32, // A bit larger for emphasis
                  backgroundImage: userProfileImageUrl != null
                      ? AssetImage(userProfileImageUrl!)
                      : null,
                  // Fallback icon if no image is provided
                  child: userProfileImageUrl == null
                      ? const Icon(Icons.person, size: 32)
                      : null,
                ),
                const SizedBox(height: 12),

                // --- User Name ---
                Text(
                  userName,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),

                Row(
                  children: [
                    Icon(Icons.pin_drop),
                      const SizedBox(width: 8,),

                      Text(
                        location,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.black,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}