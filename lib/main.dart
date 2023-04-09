import 'package:courses/bloc/internet/internet_cubit.dart';
import 'package:courses/model/joke.dart';
import 'package:courses/screen/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/joke/joke_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(JokeAdapter());
  await Hive.openBox<Joke>("Joke");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.lightBlue),
      home: MultiBlocProvider(
        providers: [
          BlocProvider<JokeBloc>(
            create: (context) => JokeBloc(),
          ),
          BlocProvider(
            create: (_) => InternetCubit(),
          ),
        ],
        child: const Home(),
      ),
    );
  }
}
