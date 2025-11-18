import 'package:flutter/material.dart';

class PostCard extends StatelessWidget {
  final String userName;
  final String userStatus;
  final String timeAgo;
  final String postText;
  final String? postImageUrl;
  final String userProfileImageUrl;
  final int likes;
  final int comments;

  const PostCard({
    super.key,
    required this.userName,
    this.userStatus = 'Resident', // Default status
    required this.timeAgo,
    required this.postText,
    this.postImageUrl,
    required this.userProfileImageUrl,
    this.likes = 0,
    this.comments = 0,
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
                      Text(
                        '$userStatus • $timeAgo',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.grey[600],
                        ),
                      ),
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
          // --- Post Text ---
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Text(
              postText,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w600,
                height: 1.2,
              ),
            ),
          ),
          const SizedBox(height: 8),

          // --- Post Image (Conditional) ---
          if (postImageUrl != null && postImageUrl!.isNotEmpty)
            Image.asset(
              postImageUrl!,
              width: double.infinity,
              height: 240,
              fit: BoxFit.cover,
            ),

          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                // Likes
                _buildActionButton(
                  icon: Icons.favorite_outline,
                  count: likes,
                  onTap: () {
                    // TODO: Handle like
                  },
                ),
                const SizedBox(width: 16),

                _buildActionButton(
                  icon: Icons.chat_bubble_outline,
                  count: comments,
                  onTap: () {
                    // TODO: Handle comment
                  },
                ),
                // Spacer to push share to the right
                const Spacer(),
                // Share
                _buildActionButton(
                  icon: Icons.share,
                  onTap: () {
                    // TODO: Handle share
                  },
                ),
              ],
            ),
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