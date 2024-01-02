import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  const UserImagePicker({super.key, required this.imagePickFn});

  final void Function(File pickedImage) imagePickFn;

  @override
  State<UserImagePicker> createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File? pickerImageFile;

  void _pickerImage() async {
    final pickerImage = await ImagePicker().pickImage(
        source: ImageSource.gallery, imageQuality: 50, maxWidth: 150);
    setState(() {
      pickerImageFile = File(pickerImage!.path);
    });
    widget.imagePickFn(pickerImageFile!);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
          backgroundImage:
              pickerImageFile != null ? FileImage(pickerImageFile!) : null,
        ),
        TextButton.icon(
          onPressed: _pickerImage,
          icon: const Icon(Icons.image),
          label: const Text('Add Image'),
        ),
      ],
    );
  }
}
