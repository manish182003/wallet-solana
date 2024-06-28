import 'dart:convert';

class Wallet {
  final String walletName;
  final String userPin;
  final String network;
  final String publicKey;
  final String secretKey;

  Wallet({
    required this.walletName,
    required this.userPin,
    required this.network,
    required this.publicKey,
    required this.secretKey,
  });

  Map<String, dynamic> toMap() {
    return {
      'walletName': walletName,
      'userPin': userPin,
      'network': network,
      'publicKey': publicKey,
      'secretKey': secretKey,
    };
  }

  factory Wallet.fromMap(Map<String, dynamic> map) {
    return Wallet(
      walletName: map['walletName'] ?? '',
      userPin: map['userPin'] ?? '',
      network: map['network'] ?? '',
      publicKey: map['publicKey'] ?? '',
      secretKey: map['secretKey'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Wallet.fromJson(String source) => Wallet.fromMap(json.decode(source));
}
