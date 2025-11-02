import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'di_container.dart' as di;
import 'features/user/presentation/bloc/user_bloc.dart';
import 'features/user/presentation/screen/user_list.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => di.sl<UsersBloc>(),
        ),
      ],
      child: const MyApp())
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:  UserListScreen(),
    );
  }
}