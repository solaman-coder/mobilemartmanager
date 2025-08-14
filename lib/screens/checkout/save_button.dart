import 'package:flutter/material.dart';

class SaveButton extends StatelessWidget {
  final VoidCallback? onpressed;

  const SaveButton({super.key, required this.onpressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: onpressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: const Text("Save and Continue",
            style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
