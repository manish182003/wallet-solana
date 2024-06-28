import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallet_intern/Provider/Provider.dart';
import 'package:wallet_intern/Provider/wallet.dart';
import 'package:wallet_intern/home/screens/homescreen.dart';
import 'package:wallet_intern/login/screens/login.dart';

import 'package:wallet_intern/route.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final user = UserProvider();
  final wallet = WalletProvider();
  await user.loadUser();
  await wallet.loadWallet();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => user,
        ),
        ChangeNotifierProvider(
          create: (context) => wallet,
        )
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserProvider>(context).user;

    if (user != null) {
      debugPrint(user.token);
    } else {
      debugPrint('User is null');
    }
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(useMaterial3: true),
      onGenerateRoute: (settings) => RouteName(settings),
      home: user != null && user.token.isNotEmpty
          ? const Homescreen()
          : const Login(),
    );
  }
}
