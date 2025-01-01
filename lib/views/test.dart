import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserProfileScreen extends StatefulWidget {
  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  String? email;
  String username = '';
  String phone = '';
  String address = '';
  String? imagePath;

  final ImagePicker _picker = ImagePicker();

  Future<void> pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        imagePath = image.path;
      });
    }
  }

  Future<void> updateUser() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      try {
        // await UserController.updateUser(
        //   email: email,
        //   username: username,
        //   phone: phone,
        //   address: address,
        //   imagePath: imagePath,
        // );
        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(content: Text('User data updated successfully!')),
        // );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error updating user data: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Email (Optional)'),
                onSaved: (value) => email = value,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Username'),
                validator: (value) =>
                value!.isEmpty ? 'Username cannot be empty' : null,
                onSaved: (value) => username = value!,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Phone'),
                validator: (value) =>
                value!.isEmpty ? 'Phone cannot be empty' : null,
                onSaved: (value) => phone = value!,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Address'),
                validator: (value) =>
                value!.isEmpty ? 'Address cannot be empty' : null,
                onSaved: (value) => address = value!,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: pickImage,
                child: Text('Select Image'),
              ),
              SizedBox(height: 20),




              if (imagePath != null) // Show preview if an image is selected
                Column(
                  children: [
                    Text(
                      'Selected Image:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Image.file(
                      File(imagePath!),
                      width: 150,
                      height: 150,
                      fit: BoxFit.cover,
                    ),
                  ],
                ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: updateUser,
                child: Text('Update Profile'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
