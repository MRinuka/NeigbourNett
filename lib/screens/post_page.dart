import 'package:flutter/material.dart';

class PostPage extends StatefulWidget {
  const PostPage({super.key});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  final TextEditingController _captionController = TextEditingController();
  String? _previewImageUrl;

  void _pickImage() {
    setState(() {
      _previewImageUrl = "assets/images/hamburgers.jpg"; // Your placeholder
    });
  }

  void _removeImage() {
    setState(() {
      _previewImageUrl = null;
    });
  }

  void _submitPost() {
    final caption = _captionController.text;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Posting... (Demo)'),
        backgroundColor: Colors.green,
      ),
    );

    _captionController.clear();
    _removeImage();
  }

  @override
  void dispose() {
    _captionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 1. --- THIS SCAFFOLD IS THE FIX ---
    // It provides the Material "canvas" that the TextFormField needs.
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        // 2. --- PADDING ---
        // This 100px padding clears your main app's floating nav bar
        padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 120.0),
        children: [
          // --- 1. User Details Header ---
          Row(
            children: [
              const CircleAvatar(
                radius: 24,
                backgroundImage:
                AssetImage("assets/images/profiles/profile_1.jpg"), // Mock user
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "John Meyers", // Mock user
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Posting as Resident",
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 24),

          // --- 2. Caption Block ---
          // This TextFormField will now find the Scaffold's Material
          TextFormField(
            controller: _captionController,
            decoration: const InputDecoration(
              hintText: "What's on your mind?",
              border: InputBorder.none, // Clean, modern look
              hintStyle: TextStyle(fontSize: 20),
            ),
            style: const TextStyle(fontSize: 20),
            minLines: 4,
            maxLines: 8,
            keyboardType: TextInputType.multiline,
          ),
          const SizedBox(height: 20),

          // --- 3. Upload Image Section ---
          Stack(
            children: [
              // The main upload box
              GestureDetector(
                onTap: _pickImage,
                child: Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: _previewImageUrl == null
                      ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.add_photo_alternate_outlined,
                        size: 50,
                        color: Colors.grey[600],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Tap to add a photo",
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                    ],
                  )
                      : ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      _previewImageUrl!,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),

              // "Remove Image" button
              if (_previewImageUrl != null)
                Positioned(
                  top: 8,
                  right: 8,
                  child: GestureDetector(
                    onTap: _removeImage,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.6),
                        shape: BoxShape.circle,
                      ),
                      child:
                      const Icon(Icons.close, color: Colors.white, size: 20),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 30),

          // --- 4. Post Button ---
          ElevatedButton(
            onPressed: _submitPost,
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
                child: const Text(
                  'Post',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}