import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Mock data for the chat list. You'll replace this with real data.
final List<Map<String, String>> mockChatData = [
  {
    "name": "Jason Tate",
    "lastMessage": "Hey, are you going to the BBQ on Friday?",
    "time": "10:42 AM",
    "avatarUrl": "assets/images/profiles/profile_3.jpg",
    "unreadCount": "2",
  },
  {
    "name": "Community Group",
    "lastMessage": "Alex: Has anyone seen a lost grey cat?",
    "time": "9:15 AM",
    "avatarUrl": "group",
    "unreadCount": "5",
  },
  {
    "name": "Jane Doe",
    "lastMessage": "Thanks for the help with the plumbing!",
    "time": "Yesterday",
    "avatarUrl": "assets/images/jane_profile.jpg",
    "unreadCount": "0",
  },
  {
    "name": "Kevin Michael",
    "lastMessage": "See you at the pool tomorrow.",
    "time": "Sunday",
    "avatarUrl": "assets/images/profiles/profile_2.jpg",
    "unreadCount": "0",
  },
];

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  // We'll add a controller for the search bar
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _addGroupChat() {
    // TODO: Implement navigation to a "create group" page
    Navigator.pushNamed(context, "/create_group");
  }

  // This navigates to an individual chat
  void _openChat(Map<String, String> chat) {
    // TODO: Implement navigation to the specific chat detail screen
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Opening chat with ${chat["name"]}')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Chats'),
        actions: [
          IconButton(
            icon: const Icon(Icons.group_add_outlined),
            onPressed: _addGroupChat,
            tooltip: 'Create Group Chat',
          ),
        ],
      ),
      // 1. --- WRAPPED IN A STACK ---
      body: Stack(
        children: [
          Column(
            children: [
              // --- Search Bar ---
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextFormField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search chats...',
                    prefixIcon: const Icon(Icons.search),
                    filled: true,
                    fillColor: Colors.grey.shade100,
                    contentPadding: EdgeInsets.zero,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24.0),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  onChanged: (value) {
                    // TODO: Implement search filter logic
                  },
                ),
              ),

              // --- Chat List ---
              Expanded(
                child: ListView.builder(
                  // Added 100px bottom padding to clear the MAIN nav bar
                  padding: const EdgeInsets.only(bottom: 100.0),
                  itemCount: mockChatData.length,
                  itemBuilder: (context, index) {
                    final chat = mockChatData[index];
                    final bool isGroup = chat['avatarUrl'] == 'group';
                    final int unreadCount =
                        int.tryParse(chat['unreadCount']!) ?? 0;

                    return ListTile(
                      onTap: () => _openChat(chat),
                      leading: CircleAvatar(
                        radius: 28,
                        backgroundImage: isGroup || chat['avatarUrl'] == null
                            ? null // Use default child
                            : AssetImage(chat['avatarUrl']!),
                        child: isGroup
                            ? const Icon(Icons.group, color: Colors.white)
                            : null,
                      ),
                      title: Text(
                        chat['name']!,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        chat['lastMessage']!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: unreadCount > 0
                              ? Colors.black
                              : Colors.grey[600],
                          fontWeight: unreadCount > 0
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                      trailing: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            chat['time']!,
                            style: TextStyle(
                              color: unreadCount > 0
                                  ? Colors.lightBlueAccent
                                  : Colors.grey[600],
                              fontSize: 12,
                              fontWeight: unreadCount > 0
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                          ),
                          const SizedBox(height: 4),
                          if (unreadCount > 0)
                            Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: Colors.lightBlueAccent,
                                shape: BoxShape.circle,
                              ),
                              child: Text(
                                chat['unreadCount']!,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),

          // 2. --- ADDED THE FLOATING NAV BAR ---
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
                  border: Border.all(
                    color: Colors.lightBlue,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildNavItem(
                      context: context,
                      icon: CupertinoIcons.chat_bubble_fill,
                      onTap: () {
                        // This page is already Chat, so this does nothing
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
      ),
    );
  }

  Widget _buildNavItem({
    required BuildContext context,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    final color = Colors.lightBlueAccent.shade100;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color, size: 30.0),
            const SizedBox(height: 2),
          ],
        ),
      ),
    );
  }
}