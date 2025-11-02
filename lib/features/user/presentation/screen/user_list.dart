

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_app_for_sokrio/features/user/presentation/bloc/user_bloc.dart';
import 'package:user_app_for_sokrio/features/user/presentation/bloc/user_event.dart';
import 'package:user_app_for_sokrio/features/user/presentation/bloc/user_state.dart';
import 'package:user_app_for_sokrio/features/user/presentation/screen/user_details.dart';

class UserListScreen extends StatefulWidget {
  const UserListScreen({super.key});
  @override
  State<UserListScreen> createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListScreen> {

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<UsersBloc>().add(UsersFetched());
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        context.read<UsersBloc>().add(UsersFetched());
      }
    });
  }

  @override
  void dispose() {
     _scrollController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Users')),
      body: BlocBuilder<UsersBloc, UsersState>(
        builder: (context, state) {
          if (state is UsersLoadInProgress && state is! UsersLoadSuccess) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is UsersLoadFailure) {
            return Center(child: Text('Error: ${state.message}'));
          } else if (state is UsersLoadSuccess) {
            final users = state.users;

            return RefreshIndicator(
              onRefresh: () async {
                context.read<UsersBloc>().add(UsersFetched(isRefresh: true));
              },
              child: ListView.separated(
                controller: _scrollController,
                itemCount: users.length + (state.hasReachedMax ? 0 : 1),
                separatorBuilder: (_, __) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  if (index >= users.length) {
                    return const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }

                  final user = users[index];
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage:
                      CachedNetworkImageProvider(user.avatar),
                    ),
                    title: Text('${user.firstName} ${user.lastName}'),
                    subtitle: Text(user.email),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => UserDetailScreen(user: user),
                        ),
                      );
                    },
                  );
                },
              ),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}