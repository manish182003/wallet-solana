import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:wallet_intern/Provider/Provider.dart';
import 'package:wallet_intern/Provider/wallet.dart';
import 'package:wallet_intern/home/screens/balance-transfer.dart';
import 'package:wallet_intern/home/screens/create-wallet.dart';
import 'package:wallet_intern/home/services/home_services.dart';
import 'package:wallet_intern/login/screens/login.dart';
import 'package:wallet_intern/utility.dart';

class Homescreen extends StatefulWidget {
  static const String routename = '/home';
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserProvider>(context).user!;
    var size = MediaQuery.of(context).size;
    var startText = user.wallet_address.substring(0, 6);
    var endText = user.wallet_address.substring(user.wallet_address.length - 5);
    String text = '$startText...$endText';
    final price = TextEditingController();
    HomeServices homeServices = HomeServices();
    final formkey = GlobalKey<FormState>();

    dispose() {
      price.dispose();
    }

    return Scaffold(
      appBar: user.has_wallet == false
          ? null
          : AppBar(
              title: const Text(
                'Wallet',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              actions: [
                PopupMenuButton<String>(
                  onSelected: (String value) {
                    // Handle menu item selection
                    switch (value) {
                      case 'Logout':
                        // Handle logout action
                        // Clear user data and navigate to login screen
                        Provider.of<UserProvider>(context, listen: false)
                            .clearUser();
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          Login.routename,
                          (route) => false,
                        );
                        break;
                    }
                  },
                  itemBuilder: (BuildContext context) {
                    return {'Profile', 'Logout'}.map((String choice) {
                      return PopupMenuItem<String>(
                        value: choice,
                        child: Text(choice),
                      );
                    }).toList();
                  },
                  icon: const Icon(Icons.more_vert),
                ),
              ],
            ),
      body: user.has_wallet == false
          ? Stack(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: double.infinity,
                  child: Image.asset(
                    'assets/images/button.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: Colors.black.withOpacity(0.4),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Text(
                          'Welcome to Wallet App, Your wallet is a gateway to the decentralized web. You can use it to store, send, and receive cryptocurrencies.',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                          style: ButtonStyle(
                              minimumSize: WidgetStateProperty.all<Size>(
                                const Size(double.infinity, 50),
                              ),
                              backgroundColor: WidgetStateProperty.all<Color>(
                                Colors.white,
                              ),
                              shape: WidgetStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              )),
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              CreateWallet.routename,
                            );
                          },
                          child: const Text(
                            'Create a Wallet',
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: size.height * 0.2,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15, top: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Total Balance',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            '\$${user.balance}.00',
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Text(
                                '$startText...$endText',
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 13,
                                ),
                              ),
                              IconButton(
                                iconSize: 14,
                                color: Colors.black,
                                onPressed: () {
                                  Clipboard.setData(
                                      ClipboardData(text: user.wallet_address));
                                  showSnackBar(context, 'Copied to Clipboard');
                                },
                                icon: const Icon(
                                  Icons.copy,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Stack(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 50,
                        decoration: BoxDecoration(
                          image: const DecorationImage(
                            image: AssetImage('assets/images/send.jpg'),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                      Center(
                        child: ElevatedButton(
                          style: ButtonStyle(
                            minimumSize: WidgetStateProperty.all<Size>(
                              const Size(double.infinity, 50),
                            ),
                            backgroundColor: WidgetStateProperty.all<Color>(
                              Colors.transparent,
                            ),
                            shape:
                                WidgetStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              BalanceTransfer.routename,
                            );
                          },
                          child: const Text(
                            'Send',
                            style: TextStyle(
                              fontSize: 22,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Stack(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 50,
                        decoration: BoxDecoration(
                          image: const DecorationImage(
                            image: AssetImage('assets/images/req.jpg'),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                      Center(
                        child: ElevatedButton(
                          style: ButtonStyle(
                            minimumSize: WidgetStateProperty.all<Size>(
                              const Size(double.infinity, 50),
                            ),
                            backgroundColor: WidgetStateProperty.all<Color>(
                              Colors.transparent,
                            ),
                            shape:
                                WidgetStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                          onPressed: () {
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (context) {
                                return Form(
                                  key: formkey,
                                  child: AlertDialog(
                                    title: const Text(
                                      'Request AirDrop',
                                      style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    alignment: Alignment.center,
                                    actions: [
                                      ElevatedButton(
                                        style: ButtonStyle(
                                          minimumSize:
                                              WidgetStateProperty.all<Size>(
                                            const Size(double.infinity, 50),
                                          ),
                                          backgroundColor:
                                              WidgetStateProperty.all<Color>(
                                            Colors.white,
                                          ),
                                          shape: WidgetStateProperty.all<
                                              RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                          ),
                                        ),
                                        onPressed: () {
                                          if (formkey.currentState!
                                              .validate()) {
                                            homeServices.requestAirDrop(
                                              context,
                                              price.text,
                                            );
                                            price.text = "";
                                          }
                                        },
                                        child: const Text(
                                          'Send',
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                    titlePadding: EdgeInsets.symmetric(
                                      horizontal: size.width * 0.18,
                                    ).copyWith(top: 20),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    contentPadding: const EdgeInsets.all(30),
                                    content: SizedBox(
                                      width: size.width * 0.8,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          TextFormField(
                                            controller: price,
                                            keyboardType: TextInputType.number,
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'Field cannot be empty';
                                              } else if (!RegExp(r'^[0-9]+$')
                                                  .hasMatch(value)) {
                                                return 'amount can only contain numbers';
                                              }
                                            },
                                            decoration: InputDecoration(
                                              contentPadding:
                                                  const EdgeInsets.all(16),
                                              focusedBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  borderSide: const BorderSide(
                                                    color: Colors.transparent,
                                                  )),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                borderSide: const BorderSide(
                                                  color: Colors.transparent,
                                                ),
                                              ),
                                              filled: true,
                                              hintText: 'Amount in \$VIBLE',
                                              hintStyle: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              errorBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                borderSide: const BorderSide(
                                                  color: Colors.transparent,
                                                ),
                                              ),
                                              focusedErrorBorder:
                                                  OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                borderSide: const BorderSide(
                                                  color: Colors.transparent,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          child: const Text(
                            'Request Airdrop',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
    );
  }
}
