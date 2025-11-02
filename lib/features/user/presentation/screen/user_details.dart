

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:user_app_for_sokrio/features/user/domain/entities/user_entities.dart';

class UserDetailScreen extends StatelessWidget {
  final UserEntity user;
  const UserDetailScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('User Detail')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CircleAvatar(radius: 56, backgroundImage: CachedNetworkImageProvider(user.avatar)),
            const SizedBox(height: 16),
            Text('${user.firstName} ${user.lastName}', style: TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            Row(children: [const Icon(Icons.email), const SizedBox(width: 8), Text(user.email)]),
            const SizedBox(height: 8),
            Row(children: [const Icon(Icons.phone), const SizedBox(width: 8), Text('N/A')]),
          ],
        ),
      ),
    );
  }
}