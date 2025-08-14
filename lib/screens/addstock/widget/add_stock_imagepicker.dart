import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddStockImagePicker extends StatefulWidget {
  final Function(File) onImageSelected;
  const AddStockImagePicker({super.key, required this.onImageSelected});

  @override
  State<AddStockImagePicker> createState() => _AddStockImagePickerState();
}

class _AddStockImagePickerState extends State<AddStockImagePicker> {
  File? _image;
  final picker = ImagePicker();

  Future<void> pickImage() async {
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        _image = File(picked.path);
      });
      widget.onImageSelected(_image!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: pickImage,
      child: Container(
        height: 120,
        width: double.infinity,
        decoration: BoxDecoration(
          color: const Color(0xFFF5F6FA),
          borderRadius: BorderRadius.circular(12),
        ),
        child: _image == null
            ? const Center(child: Text("Upload Picture"))
            : Stack(
                alignment: Alignment.topRight,
                children: [
                  Center(child: Image.file(_image!, height: 100)),
                  IconButton(
                    icon: const Icon(Icons.cancel),
                    onPressed: () {
                      setState(() => _image = null);
                    },
                  )
                ],
              ),
      ),
    );
  }
}
