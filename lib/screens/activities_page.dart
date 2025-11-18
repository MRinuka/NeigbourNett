import 'package:flutter/material.dart';
import 'package:neigbor_connect/widgets/announcement_card.dart';
import 'package:neigbor_connect/screens/activity_detail_page.dart';



final List<Map<String, String?>> activitiesData = [
  {
    "title": "BBQ",
    "subtitle": "1 hour - 3 hours",
    "date": null,
    "imageUrl": "assets/images/events/BBQ Poster.png",
  },
  {
    "title": "Padel",
    "subtitle": "45 mins - 1 hour",
    "date": null,
    "imageUrl": "assets/images/events/padel.jpg",
  },
  {
    "title": "Golf Session",
    "subtitle": "1 hour - 3 hours",
    "date": null,
    "imageUrl": "assets/images/events/golf.jpg",
  },
  {
    "title": "Social Meetup",
    "subtitle": "1 hour - 3 hours",
    "date": null,
    "imageUrl": null,
  },
];

// --- NEW: Mock data for Restaurants ---
final List<Map<String, String?>> mockRestaurantData = [
  {
    "title": "The DailyGrill",
    "subtitle": "Cafe & Bistro • \$\$\$",
    "imageUrl": "assets/images/hamburgers.jpg",
  },
  {
    "title": "Pizza Palace",
    "subtitle": "Italian • \$\$",
    "imageUrl": "assets/images/posts/padel_post.jpg",
  },
  {
    "title": "Aqua Cafe",
    "subtitle": "Seafood • \$\$\$\$",
    "imageUrl": "assets/images/posts/water_park.jpg",
  },
];

class ActivitiesPage extends StatelessWidget {
  const ActivitiesPage({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. --- WRAPPED IN DefaultTabController ---
    return DefaultTabController(
      length: 2, // Two tabs
      child: Column(
        children: [
          // --- 2. THE TAB BAR (Updated Style) ---
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Container(
              height: 44, // Give the bar a defined height
              decoration: BoxDecoration(
                color: Colors.grey.shade200, // Background of the whole component
                borderRadius: BorderRadius.circular(22.0), // Makes the whole bar circular
              ),
              child: TabBar(
                tabs: const [
                  Tab(text: 'Events'),
                  Tab(text: 'Restaurants'),
                ],
                // Style for the selected text
                labelColor: Colors.white,
                labelStyle: const TextStyle(fontWeight: FontWeight.bold),
                // Style for the unselected text
                unselectedLabelColor: Colors.grey[700],
                // --- This creates the circular, animated indicator ---
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(22.0), // Circular shape
                  gradient: const LinearGradient( // Use the app's gradient
                    colors: [Colors.blue, Colors.lightBlueAccent],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  boxShadow: [ // Add a subtle shadow to the indicator
                    BoxShadow(
                      color: Colors.blue.withOpacity(0.3),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                indicatorSize: TabBarIndicatorSize.tab,
                // This removes the default underline indicator
                dividerColor: Colors.transparent,
              ),
            ),
          ),


          // --- 3. THE TAB CONTENT ---
          Expanded(
            child: TabBarView(
              children: [
                // --- Tab 1: Events ---
                _EventsTab(),
                // --- Tab 2: Restaurants ---
                _RestaurantsTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// --- WIDGET FOR TAB 1: EVENTS ---
// This is your original page content
class _EventsTab extends StatelessWidget {
  const _EventsTab();

  @override
  Widget build(BuildContext context) {
    return ListView(
      // 4. --- PADDING UPDATED ---
      // Ensures 100px padding at the bottom for the nav bar
      padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 100.0),
      children: [
        // "Create Event" Button
        Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, "/create_event");
            },
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.zero, // Remove padding for gradient
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
            ),
            child: Ink(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Colors.blue, Colors.lightBlueAccent],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Container(
                height: 50,
                width: double.infinity,
                alignment: Alignment.center,
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.add, color: Colors.white),
                    SizedBox(width: 8),
                    Text(
                      'Create New Event',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),

        // List of activities
        ...activitiesData.map((activity) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ActivityDetailPage(activity: activity),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: AnnouncementCard(
                title: activity['title']!,
                subtitle: activity['subtitle'],
                date: activity['date'],
                imageUrl: activity['imageUrl'],
              ),
            ),
          );
        }).toList(),
      ],
    );
  }
}

// --- WIDGET FOR TAB 2: RESTAURANTS ---
// This is the new widget for the restaurants list
class _RestaurantsTab extends StatelessWidget {
  const _RestaurantsTab();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      // 5. --- PADDING ADDED ---
      // Ensures 100px padding at the bottom for the nav bar
      padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 100.0),
      itemCount: mockRestaurantData.length,
      itemBuilder: (context, index) {
        final restaurant = mockRestaurantData[index];
        return GestureDetector(
          onTap: () {
            // TODO: Navigate to a RestaurantDetailPage
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Opening ${restaurant["title"]}')),
            );
          },
          child: Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            // We can reuse the AnnouncementCard for a consistent look
            child: AnnouncementCard(
              title: restaurant['title']!,
              subtitle: restaurant['subtitle'],
              imageUrl: restaurant['imageUrl'],
            ),
          ),
        );
      },
    );
  }
}