import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// Import the card widgets
import 'package:neigbor_connect/widgets/simple_post_card.dart';
import 'package:neigbor_connect/widgets/reel_card.dart';
import 'package:neigbor_connect/main_layout.dart';
import 'post_page.dart';

// --- Data for the FIRST feed ---
final List<Map<String, dynamic>> wallFeedData = [
  {
    "postText": "Some of the best hamburgers I have had so far",
    "userName": "John Meyers",
    "userStatus": "Resident",
    "timeAgo": "2h",
    "postImageUrl": "assets/images/hamburgers.jpg",
    "userProfileImageUrl": "assets/images/profiles/profile_1.jpg",
    "likes": 25,
    "comments": 12,
  },
  {
    "postText": "Most fun I had playing padel",
    "userName": "Jason Tate",
    "userStatus": "Resident",
    "timeAgo": "5h",
    "postImageUrl": "assets/images/posts/padel_post.jpg",
    "userProfileImageUrl": "assets/images/profiles/profile_3.jpg",
    "likes": 18,
    "comments": 4,
  },
];

// --- Data for the Reels ---
final List<Widget> reels = [
  const ReelCard(
    userName: "John Doe",
    timeAgo: "2h",
    postImageUrl: "assets/images/posts/reel_1.jpg",
    userProfileImageUrl: "assets/images/profiles/profile_3.jpg",
  ),
  const ReelCard(
    userName: "Kevin Michael",
    timeAgo: "2h",
    postImageUrl: "assets/images/posts/reel_2.jpg",
    userProfileImageUrl: "assets/images/profiles/profile_2.jpg",
  ),
  const ReelCard(
    userName: "Sarah Wilson",
    timeAgo: "5h",
    userProfileImageUrl: "assets/images/profiles/profile_4.jpg",
    postImageUrl: "assets/images/posts/reel_3.jpg", // Example reel image
  ),
];

final List<Map<String, dynamic>> moreFeedData = [
  {
    "postText": "Best hamburgers",
    "userName": "Joe Keery",
    "userStatus": "Resident",
    "timeAgo": "1d",
    "postImageUrl": "assets/images/hamburgers.jpg",
    "userProfileImageUrl": "assets/images/jane_profile.jpg",
    "likes": 8,
    "comments": 3,
  },
  {
    "postText": "Best water park in town",
    "userName": "Kevin Michael",
    "userStatus": "Resident",
    "timeAgo": "2d",
    "postImageUrl": "assets/images/posts/water_park.jpg",
    "userProfileImageUrl": "assets/images/profiles/profile_2.jpg",
    "likes": 42,
    "comments": 19,
  },
];


// 1. --- Converted to StatefulWidget ---
class WallPage extends StatefulWidget {
  const WallPage({super.key});

  @override
  State<WallPage> createState() => _WallPageState();
}

class _WallPageState extends State<WallPage> {
  // 2. --- Added state for the NEW sub-navbar ---
  int _subPageIndex = 0;

  void _onSubItemTapped(int index) {
    setState(() {
      _subPageIndex = index;
    });
  }

  static const List<Widget> _widgetOptions = <Widget>[
    _CommunityFeedTab(),
    const PostPage(),
    _ReelsTab(),

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Match page background

      body: Stack(
        children: [
          // Page Content
          IndexedStack(
            index: _subPageIndex,
            children: _widgetOptions,
          ),
          Positioned(
            bottom: 40.0,
            left: 60,
            right: 60,
            child: _SubNavBar(
              selectedIndex: _subPageIndex,
              onTapped: _onSubItemTapped,
            ),
          ),
        ],
      ),
    );
  }
}

class _CommunityFeedTab extends StatelessWidget {
  const _CommunityFeedTab();

  @override
  Widget build(BuildContext context) {
    return ListView(

      padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 180.0),
      children: [
        Text(
          "Recent Posts",
          style: Theme.of(context)
              .textTheme
              .headlineMedium
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        ...wallFeedData.map((post) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: SimplePostCard(
              postText: post['postText']!,
              userName: post['userName'],
              userStatus: post['userStatus'],
              timeAgo: post['timeAgo'],
              postImageUrl: post['postImageUrl'],
              userProfileImageUrl: post['userProfileImageUrl'],
              likes: post['likes'] ?? 0,
              comments: post['comments'] ?? 0,
              onTap: () {
                // TODO: Navigate to post detail page
              },
            ),
          );
        }).toList(),
        const SizedBox(
          height: 24,
        ),
        Text(
          "Reels",
          style: Theme.of(context)
              .textTheme
              .headlineMedium
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 300,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: reels.length,
            itemBuilder: (context, index) {
              return SizedBox(
                width: 200,
                child: Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: reels[index],
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 24),
        Text(
          "More Posts",
          style: Theme.of(context)
              .textTheme
              .headlineMedium
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        ...moreFeedData.map((post) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: SimplePostCard(
              postText: post['postText']!,
              userName: post['userName'],
              userStatus: post['userStatus'],
              timeAgo: post['timeAgo'],
              postImageUrl: post['postImageUrl'],
              userProfileImageUrl: post['userProfileImageUrl'],
              likes: post['likes'] ?? 0,
              comments: post['comments'] ?? 0,
              onTap: () {
                // TODO: Navigate to post detail page
              },
            ),
          );
        }).toList(),
      ],
    );
  }
}

// 9. --- WIDGET 2 FOR SUB-PAGES: The Reels Grid ---
// This is a new example page
class _ReelsTab extends StatelessWidget {
  const _ReelsTab();

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      // Also needs padding to clear both nav bars
      padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 180.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // 2 columns
        crossAxisSpacing: 18,
        mainAxisSpacing: 20,
        childAspectRatio: 0.65, // Adjust aspect ratio for your ReelCard
      ),
      itemCount: reels.length,
      itemBuilder: (context, index) {
        return reels[index];
      },
    );
  }
}



class _SubNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTapped;

  const _SubNavBar({
    required this.selectedIndex,
    required this.onTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        CustomPaint(
          size: const Size(double.infinity, 70),
          painter: _NavBarPainter(),
        ),

        // Navbar icons row (left and right)
        SizedBox(
          height: 70,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildNavItem(
                context: context,
                unselectedIcon: CupertinoIcons.square_grid_2x2,
                selectedIcon: CupertinoIcons.square_grid_2x2_fill,
                index: 0,
              ),
              const SizedBox(width: 60), // Leave space for center button
              _buildNavItem(
                context: context,
                unselectedIcon: CupertinoIcons.film,
                selectedIcon: CupertinoIcons.film_fill,
                index: 2,
              ),
            ],
          ),
        ),

        // Floating "+" button
        Positioned(
          top: -25, // moves button above the curve
          child: GestureDetector(
            onTap: () => onTapped(1),
            child: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF1768AC),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const Icon(
                CupertinoIcons.plus,
                color: Colors.white,
                size: 36,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNavItem({
    required BuildContext context,
    required IconData unselectedIcon,
    required IconData selectedIcon,
    required int index,
  }) {
    final bool isSelected = selectedIndex == index;
    final color = const Color(0xFF1768AC);

    return InkWell(
      onTap: () => onTapped(index),
      borderRadius: BorderRadius.circular(20),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Icon(
          isSelected ? selectedIcon : unselectedIcon,
          color: color,
          size: 32.0,
        ),
      ),
    );
  }
}
class _NavBarPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    const double fabRadius = 40.0; // notch width
    const double curveDepth = 10.0; // curve height
    const double cornerRadius = 25.0; // roundness of navbar ends

    final path = Path();

    // Start at bottom-left corner with rounded edge
    path.moveTo(0, cornerRadius);
    path.quadraticBezierTo(0, 0, cornerRadius, 0);

    // Left flat edge up to the start of the notch
    path.lineTo(size.width / 2 - fabRadius - 10, 0);

    // --- Curved Notch around FAB ---
    path.quadraticBezierTo(
      size.width / 2 - fabRadius,
      0,
      size.width / 2 - fabRadius + 10,
      curveDepth,
    );
    path.arcToPoint(
      Offset(size.width / 2 + fabRadius - 10, curveDepth),
      radius: const Radius.circular(50),
      clockwise: false,
    );
    path.quadraticBezierTo(
      size.width / 2 + fabRadius,
      0,
      size.width / 2 + fabRadius + 10,
      0,
    );

    // Right side straight line
    path.lineTo(size.width - cornerRadius, 0);

    // Rounded top-right corner
    path.quadraticBezierTo(size.width, 0, size.width, cornerRadius);

    // Bottom-right corner (rounded)
    path.lineTo(size.width, size.height - cornerRadius);
    path.quadraticBezierTo(
      size.width,
      size.height,
      size.width - cornerRadius,
      size.height,
    );

    // Bottom-left corner (rounded)
    path.lineTo(cornerRadius, size.height);
    path.quadraticBezierTo(0, size.height, 0, size.height - cornerRadius);
    path.close();

    // Draw shadow + fill
    canvas.drawShadow(path, Colors.black54, 6, true);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

