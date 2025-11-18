import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:neigbor_connect/widgets/post_card.dart';
import 'package:neigbor_connect/widgets/announcement_card.dart';
import 'package:neigbor_connect/widgets/quick_access_card.dart';
import 'package:neigbor_connect/widgets/user_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Widget> horizontalPosts = [
      _buildHorizontalPostCard(
        userName: 'John Meyers',
        userStatus: 'Resident',
        timeAgo: '2h',
        postText: 'Some of the best hamburgers I have had so far',
        postImageUrl: 'assets/images/hamburgers.jpg',
        userProfileImageUrl: 'assets/images/profiles/profile_1.jpg',
        likes: 25,
        comments: 12,
      ),
      _buildHorizontalPostCard(
        userName: 'Jason Tate',
        userStatus: 'Resident',
        timeAgo: '5h',
        postText: 'Most fun I had playing padel',
        postImageUrl: "assets/images/posts/padel_post.jpg",
        userProfileImageUrl: 'assets/images/profiles/profile_3.jpg',
        likes: 8,
        comments: 3,
      ),
      _buildHorizontalPostCard(
        userName: 'Joe Keery',
        timeAgo: '2h',
        postText: "Best hamburgers",
        postImageUrl: "assets/images/hamburgers.jpg",
        userProfileImageUrl: "",
        likes: 45,
        comments: 9,
      ),
    ];
    final List<Widget> announcements = [
      _buildHorizontalAnnouncementCard(
        title: 'Community BBQ',
        subtitle: 'Join us this Friday at 6 PM...',
        date: 'FRI, NOV 8 • 6:00 PM',
        imageUrl: 'assets/images/events/BBQ Poster.png',
      ),
      _buildHorizontalAnnouncementCard(
        title: 'Pool Maintenance',
        subtitle: 'The pool will be closed...',
        date: 'SAT, NOV 9',
      ),
    ];

    final List<Widget> quickActions = [
      QuickAccessCard(
        name: "Post",
        icon: Icons.upload,
        onTap: () {
          Navigator.pushNamed(context, "/post");
        },
      ),
      QuickAccessCard(
        name: "Activities",
        icon: Icons.local_activity,
        onTap: () {
          // TODO: Add route for activities in main.dart
          // Navigator.pushNamed(context, "/activity");
        },
      ),
      QuickAccessCard(
        name: "Chat",
        icon: CupertinoIcons.chat_bubble,
        onTap: () {
          Navigator.pushNamed(context, "/chat");
        },
      ),
    ];

    final List<Widget> users = [
      UserCard(
        userName: "Kevin",
        location: "Azizi Riveira",
        userProfileImageUrl: "assets/images/profiles/profile_2.jpg",
      ),
      UserCard(
        userName: "James",
        location: "Azizi Riveira",
        userProfileImageUrl: "assets/images/profiles/profile_1.jpg",
      ),
      UserCard(
        userName: "Michael",
        location: "Riveira Reve",
      )
    ];

    return Stack(
      children: [
        ListView(
          padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 100.0),
          children: [
            Text(
              'Welcome, Resident!',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),

            SizedBox(
              height: 450,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: horizontalPosts.length,
                itemBuilder: (context, index) {
                  return horizontalPosts[index];
                },
              ),
            ),

            const SizedBox(height: 24),

            Text(
              "Announcements",
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 12,
            ),
            SizedBox(
              height: 300,
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return announcements[index];
                },
                scrollDirection: Axis.horizontal,
                itemCount: announcements.length,
              ),
            ),

            const SizedBox(
              height: 24,
            ),

            // Text(
            //   "Quick Actions",
            //   style: Theme.of(context)
            //       .textTheme
            //       .headlineSmall
            //       ?.copyWith(fontWeight: FontWeight.bold),
            // ),
            // const SizedBox(
            //   height: 12,
            // ),
            //
            // if (quickActions.length == 3)
            //   Column(
            //     children: [
            //       Row(
            //         children: [
            //           Expanded(child: quickActions[0]),
            //           const SizedBox(
            //             width: 12,
            //           ),
            //           Expanded(child: quickActions[1]),
            //         ],
            //       ),
            //       const SizedBox(
            //         height: 12,
            //       ),
            //       Row(
            //         children: [
            //           Expanded(child: Container(), flex: 1),
            //           Expanded(
            //             child: quickActions[2],
            //             flex: 2,
            //           ),
            //           Expanded(child: Container(), flex: 1)
            //         ],
            //       )
            //     ],
            //   )
            // else
            //   GridView.count(
            //     crossAxisCount: 3,
            //     crossAxisSpacing: 12,
            //     mainAxisSpacing: 12,
            //     shrinkWrap: true,
            //     physics: const NeverScrollableScrollPhysics(),
            //     children: quickActions,
            //   ),

            const SizedBox(
              height: 24,
            ),

            Text(
              "Connect",
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 12,
            ),
            SizedBox(
              height: 200,
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return users[index];
                },
                scrollDirection: Axis.horizontal,
                itemCount: users.length,
              ),
            )
          ],
        ),


        Positioned(
          bottom: 20,
          left: 60,
          right: 60,
          child: Material(
            elevation: 8.0,
            borderRadius: BorderRadius.circular(20.0),
            color: Colors.white,
            child: Container(
              height: 70,
              decoration: BoxDecoration(
                // border: Border.all(
                //   color: const Color(0xFF404E5C),
                //   width: 1,
                // ),
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildNavItem(
                    context: context,
                    icon: CupertinoIcons.chat_bubble_fill,
                    onTap: () {
                      Navigator.pushNamed(context, "/chat");
                    },
                  ),
                  _buildNavItem(
                    context: context,
                    icon: CupertinoIcons.person,
                    onTap: () {
                      Navigator.pushNamed(context, "/profile");
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }


  Widget _buildNavItem({
    required BuildContext context,
    required IconData icon,

    required VoidCallback onTap,
  }) {
    final color = const Color(0xFF1768AC);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color, size: 40.0),
            const SizedBox(height: 2),
          ],
        ),
      ),
    );
  }



  Widget _buildHorizontalPostCard({
    required String userName,
    required String timeAgo,
    required String postText,
    required String userProfileImageUrl,
    String? userStatus,
    String? postImageUrl,
    int likes = 0,
    int comments = 0,
  }) {
    return SizedBox(
      width: 320,
      child: Padding(
        padding: const EdgeInsets.only(
            right: 16.0),
        child: PostCard(
          userName: userName,
          userStatus: userStatus ?? 'Resident',
          timeAgo: timeAgo,
          postText: postText,
          postImageUrl: postImageUrl,
          userProfileImageUrl: userProfileImageUrl,
          likes: likes,
          comments: comments,
        ),
      ),
    );
  }
}


Widget _buildHorizontalAnnouncementCard({
  required String title,
  String? subtitle,
  String? date,
  String? imageUrl,
}) {
  return SizedBox(
    width: 280,
    child: Padding(
      padding: const EdgeInsets.only(right: 16.0),
      child: AnnouncementCard(
        title: title,
        subtitle: subtitle,
        date: date,
        imageUrl: imageUrl,
      ),
    ),
  );
}