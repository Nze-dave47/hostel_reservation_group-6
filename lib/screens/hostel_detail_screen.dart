import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HostelDetailScreen extends StatelessWidget {
  final String hostelId;
  final Map<String, dynamic>? hostelData;

  const HostelDetailScreen({
    super.key,
    required this.hostelId,
    this.hostelData,
  });

  @override
  Widget build(BuildContext context) {
    final name = hostelData?['name'] ?? 'Hostel Details';
    final imageUrl = hostelData?['imageUrl'] as String?;
    final totalRooms = hostelData?['totalRooms'];
    final availableRooms = hostelData?['availableRooms'];

    return Scaffold(
      appBar: AppBar(
        title: Text(name),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.go('/hostels');
            }
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (imageUrl != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  imageUrl,
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => const SizedBox(
                    height: 200,
                    child: Center(child: Icon(Icons.error)),
                  ),
                ),
              ),
            const SizedBox(height: 16),
            Text(name, style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: 8),
            Text(
              'Total Rooms: $totalRooms',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            Text(
              'Available Rooms: $availableRooms',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green[800],
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  context.push('/hostel/$hostelId/rooms');
                },
                child: const Text('View Rooms'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
