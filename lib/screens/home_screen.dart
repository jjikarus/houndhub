import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/walk_service.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HoundHub'),
      ),
      body: Center(
        child: Consumer<WalkService>(
          builder: (context, walkService, child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  walkService.isTracking 
                    ? 'Walk in progress...' 
                    : 'Ready to walk your dog?',
                  style: const TextStyle(fontSize: 20),
                ),
                const SizedBox(height: 10),
                Text(
                  walkService.isTracking
                    ? 'Duration: ${walkService.formattedDuration}'
                    : '',
                  style: const TextStyle(fontSize: 16, color: Colors.grey),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () async {
                    if (walkService.isTracking) {
                      await walkService.endWalk();
                    } else {
                      await walkService.startWalk();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                    textStyle: const TextStyle(fontSize: 18),
                  ),
                  child: Text(walkService.isTracking ? 'END WALK' : 'START WALK'),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}