import 'package:flutter/material.dart';

class PAgenda extends StatelessWidget {
  const PAgenda({super.key});
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
              width: MediaQuery.of(context).size.width,
              height: 280,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                colors: [Color(0xFFFACCCC), Color(0xFFF6EFE9)],
              )))
        ],
      ),
    );
  }
}
