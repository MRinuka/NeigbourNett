import 'package:flutter/material.dart';

class SimplePostCard extends StatelessWidget {
  // --- Required properties ---
  final String postText;

  // --- Optional properties ---
  final String? userName;
  final String? userStatus;
  final String? timeAgo;
  final String? postImageUrl;
  final String? userProfileImageUrl;
  final int likes;
  final int comments;
  final VoidCallback? onTap;

  const SimplePostCard({
    super.key,
    required this.postText,
    this.userName,
    this.userStatus,
    this.timeAgo,
    this.postImageUrl,
    this.userProfileImageUrl,
    this.likes = 0,
    this.comments = 0,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey.shade50,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0), // More rounded corners
      ),
      elevation: 4.0,
      clipBehavior: Clip.antiAlias, // Clips the image to the card's shape
      child: InkWell(
        onTap: onTap, // Make the whole card tappable
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min, // Make card shrink to fit content
          children: [
            if (userName != null)
              _buildHeader(context),

            // if (postImageUrl != null && postImageUrl!.isNotEmpty)
            //   Image.asset(
            //     postImageUrl!,
            //     width: double.infinity,
            //     height: 250, // Fixed height for the image
            //     fit: BoxFit.cover, // Cover the space
            //   ),

            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 12.0),
              child: Text(
                postText,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),

            if (postImageUrl != null && postImageUrl!.isNotEmpty)
              Image.asset(
                postImageUrl!,
                width: double.infinity,
                height: 250, // Fixed height for the image
                fit: BoxFit.cover, // Cover the space
              ),

            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
              child: Row(
                children: [

                  _buildActionButton(
                    context: context,
                    icon: Icons.favorite_outline,
                    count: likes,
                  ),
                  const SizedBox(width: 16),
                  // Comments
                  _buildActionButton(
                    context: context,
                    icon: Icons.chat_bubble_outline,
                    count: comments,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {

    final subtitleParts = <String>[];
    if (userStatus != null) subtitleParts.add(userStatus!);
    if (timeAgo != null) subtitleParts.add(timeAgo!);
    final String subtitle = subtitleParts.join(' • ');

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          // Profile Picture
          CircleAvatar(
            radius: 20,
            backgroundImage: userProfileImageUrl != null
                ? AssetImage(userProfileImageUrl!)
                : null,
            child: userProfileImageUrl == null
                ? Icon(Icons.person, size: 20, color: Colors.grey[600])
                : null,
          ),
          const SizedBox(width: 12),
          // User Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  userName!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (subtitle.isNotEmpty)
                  Text(
                    subtitle,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.grey[600],
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required BuildContext context,
    required IconData icon,
    required int count,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 20, color: Colors.grey[700]),
        const SizedBox(width: 6),
        Text(
          '$count',
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w500,
            color: Colors.grey[800],
          ),
        ),
      ],
    );
  }
}