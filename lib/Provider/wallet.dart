import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wallet_intern/models/wallet.dart';

class WalletProvider extends ChangeNotifier {
  Wallet? _wallet;

  Wallet? get wallet => _wallet;

  loadWallet() async {
    final pref = await SharedPreferences.getInstance();
    final wallet = pref.getString('wallet');
    if (wallet != null) {
      final walletjson = Wallet.fromJson(wallet);
      _wallet = walletjson;
      notifyListeners();
    }
  }

  void setWallet(Wallet wallet) async {
    final pref = await SharedPreferences.getInstance();

    final walletJson = wallet.toJson();
    pref.setString('wallet', walletJson);

    _wallet = wallet;
    notifyListeners();
  }
}
