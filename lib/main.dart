import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_depi/controller/exercise_cubit.dart';
import 'package:flutter_application_depi/controller/search_cubit/cubit/search_result_cubit.dart';
import 'package:flutter_application_depi/utils/constants/Routes/route.dart';
import 'package:flutter_application_depi/core/services/get_exercieses-servciese.dart';
import 'package:flutter_application_depi/core/services/services.dart';
import 'package:flutter_application_depi/utils/constants/Routes/route_manger.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  InitServices initservices = InitServices();
  
  await InitServices.initialize();
  //InitServices.sharedPref.clear();
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});
  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
      }
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ExerciseCubit(),
        ),
        BlocProvider(
          create: (context) => SearchResultCubit(SearchServices()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: const Color(0xFF1F2937),
          scaffoldBackgroundColor: const Color(0xFF111827),
          colorScheme: const ColorScheme.dark(
            primary: Color(0xFF3B82F6),
            secondary: Color(0xFF3B82F6),
          ),
          textTheme: const TextTheme(
            titleLarge: TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
            bodyLarge: TextStyle(fontSize: 16, color: Colors.white),
            bodyMedium: TextStyle(fontSize: 14, color: Colors.white),
          ),
        ),
        onGenerateRoute: RouteManeger.getRoutes,
        initialRoute: InitServices.sharedPref.getString("splash") == "1" ?  (InitServices.sharedPref.getString("remember") == "1" ? (InitServices.sharedPref.getString("member") == "1" ? Routes.homeMain: Routes.onboarnding) : Routes.login) : Routes.splashscreen, 
      ),
    );
  }
}
