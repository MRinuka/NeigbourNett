import 'package:flutter/material.dart';

class CreateGroupPage extends StatefulWidget {
  const CreateGroupPage({super.key});

  @override
  State<CreateGroupPage> createState() => _CreateGroupPageState();
}

class _CreateGroupPageState extends State<CreateGroupPage> {
  final _formKey = GlobalKey<FormState>();
  final _groupNameController = TextEditingController();
  final _groupDescriptionController = TextEditingController();

  // We'll use this to "fake" an image upload
  String? _previewImageUrl;

  @override
  void dispose() {
    _groupNameController.dispose();
    _groupDescriptionController.dispose();
    super.dispose();
  }

  void _pickImage() {
    // In a real app, you'd use image_picker
    setState(() {
      _previewImageUrl = "assets/images/posts/padel_post.jpg"; // Mock image
    });
  }

  void _createGroup() {
    // Validate the form
    if (_formKey.currentState!.validate()) {
      final groupName = _groupNameController.text;
      final groupDescription = _groupDescriptionController.text;

      // ---
      // TODO: Implement your group creation logic here
      // 1. Upload image (if _previewImageUrl is not null)
      // 2. Create group entry in your database with name, description, and image URL
      // ---

      // Show a success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Group "$groupName" created! (Demo)'),
          backgroundColor: Colors.green,
        ),
      );

      // Go back to the chat page
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Create New Group'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(24.0),
          children: [
            // --- 1. Group Photo ---
            Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.grey.shade200,
                    backgroundImage: _previewImageUrl != null
                        ? AssetImage(_previewImageUrl!)
                        : null,
                    child: _previewImageUrl == null
                        ? Icon(
                      Icons.group,
                      size: 50,
                      color: Colors.grey.shade400,
                    )
                        : null,
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: _pickImage,
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: const BoxDecoration(
                          color: Colors.lightBlueAccent,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.edit,
                            color: Colors.white, size: 20),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),

            // --- 2. Group Name ---
            TextFormField(
              controller: _groupNameController,
              decoration: InputDecoration(
                labelText: 'Group Name',
                hintText: 'E.g., "Building A Neighbors"',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a group name';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),

            // --- 3. Group Description ---
            TextFormField(
              controller: _groupDescriptionController,
              decoration: InputDecoration(
                labelText: 'Group Description',
                hintText: 'What is this group about?',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              minLines: 3,
              maxLines: 5,
            ),
            const SizedBox(height: 30),

            // --- 4. Create Group Button ---
            ElevatedButton(
              onPressed: _createGroup,
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
                    'Create Group',
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
      ),
    );
  }
}