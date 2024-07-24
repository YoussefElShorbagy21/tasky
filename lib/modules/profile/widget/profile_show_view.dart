import 'package:flutter/material.dart';

class ProfileShow extends StatelessWidget {
  const ProfileShow({super.key, required this.title, required this.value});
  final String title;
  final String value;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: 15, vertical: 12),
      child: Container(
        width: double.infinity,
        decoration: ShapeDecoration(
          color: const Color(0xFFF5F5F5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child:  Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Color(0x662F2F2F),
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),

              Text(
                value,
                style: const TextStyle(
                  color: Color(0x992F2F2F),
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}