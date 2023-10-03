import 'package:event_hub/logic/cubits/cubit/event_cubit.dart';
import 'package:event_hub/logic/events/cubit/create_event_cubit.dart';
import 'package:event_hub/presentation/screens/home/home.dart';
import 'package:event_hub/presentation/screens/auth/login.dart';
import 'package:event_hub/presentation/screens/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

import 'logic/cubits/cubit/login_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey =
      "pk_test_51MxbuQL0OmplM2VE8Hb24JbnhlKDNX52d2cM9K57DmbraQOoa1t1z0yHLiF6pXkRvjjZfzNuLj6dpOh7T1MbYE0d00UaUK81fw";
  await dotenv.load(fileName: "assets/.env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => LoginCubit()),
        BlocProvider(create: (_) => CreateEventCubit()),
        BlocProvider(create: (_) => EventCubit())
      ],
      child: MaterialApp(
          title: 'Event Hub',
          theme: ThemeData(
            useMaterial3: true,
          ),
          home: const Splash()),
    );
  }
}
