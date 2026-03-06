import 'package:flutter/material.dart';
import '../data/attractions_data.dart';
import '../widgets/attraction_card.dart';
import 'attraction_detail_screen.dart';
import '../utils/constants.dart';

class AttractionsListScreen extends StatelessWidget {
  const AttractionsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('المعالم السياحية'),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppConstants.jordanianRed,
                AppConstants.jordanianGreen,
              ],
            ),
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.amber.shade50,
              Colors.white,
            ],
          ),
        ),
        child: ListView.builder(
          itemCount: attractions.length,
          itemBuilder: (context, index) {
            final attraction = attractions[index];
            return AttractionCard(
              attraction: attraction,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AttractionDetailScreen(
                      attraction: attraction,
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}