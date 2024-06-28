import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallet_intern/Provider/Provider.dart';
import 'package:wallet_intern/Provider/wallet.dart';
import 'package:wallet_intern/home/screens/homescreen.dart';
import 'package:wallet_intern/models/wallet.dart';
import 'package:wallet_intern/utility.dart';
import 'package:http/http.dart' as http;

class HomeServices {
  void createWallet(
      BuildContext context, String walletname, String pincode) async {
    try {
      walletname = walletname.trim();
      pincode = pincode.trim();

      var token = Provider.of<UserProvider>(context, listen: false).user!.token;

      var res = await http.post(
          Uri.parse('https://api.socialverseapp.com/solana/wallet/create'),
          headers: {
            'Flic-Token': token,
          },
          body: {
            "wallet_name": walletname,
            "network": "devnet",
            "user_pin": pincode,
          });

      var data = jsonDecode(res.body);

      if (data['status'] == 'error') {
        showSnackBar(context, data['message']);
      } else {
        Wallet wallet = Wallet.fromMap(data);
        Provider.of<WalletProvider>(context).setWallet(wallet);
        Navigator.pushNamedAndRemoveUntil(
          context,
          Homescreen.routename,
          (route) => false,
        );

        showSnackBar(context, 'Wallet Created Successfully');
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  balanceTransfer(
    BuildContext context,
    String senderaddress,
    String amount,
  ) async {
    try {
      var user = Provider.of<UserProvider>(context, listen: false).user!;
      senderaddress = senderaddress.trim();
      amount = amount.trim();

      var balance = int.parse(amount);

      var res = await http.post(
        Uri.parse('https://api.socialverseapp.com/solana/wallet/transfer'),
        headers: {
          'Content-Type': 'application/json',
          'Flic-Token': user.token,
        },
        body: jsonEncode({
          "recipient_address": user.wallet_address,
          "network": "devnet",
          "sender_address": senderaddress,
          "amount": balance,
          "user_pin": "123456"
        }),
      );

      var data = jsonDecode(res.body);

      if (res.statusCode != 200) {
        showSnackBar(context, data['message']);
      } else {
        showSnackBar(context, 'Balance Transfer Successfully');
        Navigator.pushNamedAndRemoveUntil(
          context,
          Homescreen.routename,
          (route) => false,
        );
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  requestAirDrop(BuildContext context, String amount) async {
    try {
      var user = Provider.of<UserProvider>(context, listen: false).user!;
      int bal = int.parse(amount);
      var res = await http.post(
        Uri.parse('https://api.socialverseapp.com/solana/wallet/airdrop'),
        headers: {
          'Content-Type': 'application/json',
          'Flic-Token': user.token,
        },
        body: jsonEncode(
          {
            "wallet_address": user.wallet_address,
            "network": "devnet",
            "amount": bal
          },
        ),
      );

      var data = jsonDecode(res.body);

      if (res.statusCode != 200) {
        showSnackBar(context, data['message']);
        Navigator.pop(context);
      } else {
        showSnackBar(context, 'AirDrop Requested Successfully');
        Navigator.pop(context);
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
