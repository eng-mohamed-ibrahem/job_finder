import 'package:flutter/material.dart';

class TitleHomeScreen extends StatelessWidget {
  const TitleHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hi, Rafif Dian👋',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 24),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  'Create a better future for yourself here',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
                ),
              ],
            ),
          ),
          IconButton(
            iconSize: 16,
            style: const ButtonStyle(
              side: MaterialStatePropertyAll(
                BorderSide(
                  color: Color.fromRGBO(209, 213, 219, 1),
                  width: 1,
                ),
              ),
            ),
            onPressed: () {
              // go to notification page
            },
            icon: const Icon(
              Icons.notifications,
              color: Color.fromRGBO(41, 45, 50, 1),
            ),
          ),
        ],
      ),
    );
  }
}
