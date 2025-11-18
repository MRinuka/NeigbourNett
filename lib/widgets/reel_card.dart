import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class ReelCard extends StatelessWidget {
  final String userName;

  final String timeAgo;
  // final String postText;
  final String? postImageUrl;
  final String userProfileImageUrl;
  final int likes;
  final int comments;
  final Icon icon;

  const ReelCard({
    super.key,
    required this.userName,

    required this.timeAgo,
    // required this.postText,
    this.postImageUrl,
    required this.userProfileImageUrl,
    this.likes = 0,
    this.comments = 0,
    this.icon = const Icon(CupertinoIcons.film),
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey.shade50,
      margin: const EdgeInsets.only(bottom: 16.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      elevation: 4.0, // Card shadow
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                // Profile Picture
                CircleAvatar(
                  radius: 24,
                  backgroundImage: AssetImage(userProfileImageUrl),
                ),
                const SizedBox(width: 12),
                // User Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        userName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      // Text(
                      //   '$userStatus • $timeAgo',
                      //   style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      //     color: Colors.grey[600],
                      //   ),
                      // ),
                    ],
                  ),
                ),
                // More Options Icon
                IconButton(
                  icon: const Icon(Icons.more_horiz),
                  onPressed: () {
                    // TODO: Implement more options functionality
                  },
                ),
              ],
            ),
          ),

          // ***Post Image***
          if (postImageUrl != null && postImageUrl!.isNotEmpty)
            Stack(
              children: [
                Image.asset(
                  postImageUrl!,
                  width: double.infinity,
                  height: 160,
                  fit: BoxFit.cover,
                ),

                Positioned(child: Container(
                  padding: const EdgeInsets.all(6.0),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.4),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    icon.icon,
                    color: Colors.white,
                    size: 20.0,
                  ),
                ))
              ],
            ),

        ],
      ),
    );
  }

  // Helper method to build consistent action buttons
  Widget _buildActionButton({
    required IconData icon,
    int? count,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
        child: Row(
          mainAxisSize: MainAxisSize.min, // Wrap content tightly
          children: [
            Icon(icon, size: 20, color: Colors.grey[700]),
            if (count != null) ...[ // Only show count if provided
              const SizedBox(width: 6),
              Text(
                '$count',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}