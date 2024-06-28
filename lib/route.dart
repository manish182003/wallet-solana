import 'package:flutter/material.dart';
import 'package:wallet_intern/home/screens/balance-transfer.dart';
import 'package:wallet_intern/home/screens/homescreen.dart';
import 'package:wallet_intern/home/screens/create-wallet.dart';
import 'package:wallet_intern/login/screens/login.dart';

Route<dynamic> RouteName(RouteSettings settings) {
  switch (settings.name) {
    case Homescreen.routename:
      return MaterialPageRoute(
        builder: (context) => const Homescreen(),
      );

    case Login.routename:
      return MaterialPageRoute(
        builder: (context) => const Login(),
      );

    case CreateWallet.routename:
      return MaterialPageRoute(
        builder: (context) => const CreateWallet(),
      );

    case BalanceTransfer.routename:
      return MaterialPageRoute(
        builder: (context) => const BalanceTransfer(),
      );

    default:
      return MaterialPageRoute(
        builder: (context) {
          return const Scaffold(
            body: Center(
              child: Text('Something Went Wrong'),
            ),
          );
        },
      );
  }
}
