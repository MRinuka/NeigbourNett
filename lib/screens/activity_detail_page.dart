import 'package:flutter/material.dart';

class ActivityDetailPage extends StatelessWidget {
  final Map<String, String?> activity;

  const ActivityDetailPage({
    super.key,
    required this.activity,
  });

  @override
  Widget build(BuildContext context) {
    // Safely get the data from the map
    final String title = activity['title'] ?? 'Activity';
    final String? subtitle = activity['subtitle'];
    final String? imageUrl = activity['imageUrl'];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(title),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // --- 1. Image Header ---
            if (imageUrl != null)
              Image.asset(
                imageUrl,
                height: 250,
                width: double.infinity,
                fit: BoxFit.cover,
              ),

            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),

                  if (subtitle != null)
                    Row(
                      children: [
                        Icon(Icons.access_time,
                            color: Colors.grey[700], size: 20),
                        const SizedBox(width: 8),
                        Text(
                          subtitle,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(color: Colors.grey[700]),
                        ),
                      ],
                    ),
                  const SizedBox(height: 24),
                  const Divider(),
                  const SizedBox(height: 24),


                  Text(
                    'About this Activity',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Book now and have a blast with other residents for a couple of hours near the Riveira Reve now!',
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(height: 1.5),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushNamed(context, "/verification");

        },
        label: const Text('Book Slot'),
        icon: const Icon(Icons.check_circle_outline),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}