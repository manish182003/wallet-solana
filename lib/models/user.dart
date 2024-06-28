import 'dart:convert';

class User {
  final int balance;
  final String token;
  final String username;
  final String email;
  final String first_name;
  final String last_name;
  final bool isVerified;
  final String owner_id;
  final String wallet_address;
  final bool has_wallet;
  final String last_login;
  final String profile_picture_url;

  User({
    required this.balance,
    required this.token,
    required this.username,
    required this.email,
    required this.first_name,
    required this.last_name,
    required this.isVerified,
    required this.owner_id,
    required this.wallet_address,
    required this.has_wallet,
    required this.last_login,
    required this.profile_picture_url,
  });

  Map<String, dynamic> toMap() {
    return {
      'balance': balance,
      'token': token,
      'username': username,
      'email': email,
      'first_name': first_name,
      'last_name': last_name,
      'isVerified': isVerified,
      'owner_id': owner_id,
      'wallet_address': wallet_address,
      'has_wallet': has_wallet,
      'last_login': last_login,
      'profile_picture_url': profile_picture_url,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      balance: map['balance']?.toInt() ?? 0,
      token: map['token'] ?? '',
      username: map['username'] ?? '',
      email: map['email'] ?? '',
      first_name: map['first_name'] ?? '',
      last_name: map['last_name'] ?? '',
      isVerified: map['isVerified'] ?? false,
      owner_id: map['owner_id'] ?? '',
      wallet_address: map['wallet_address'] ?? '',
      has_wallet: map['has_wallet'] ?? false,
      last_login: map['last_login'] ?? '',
      profile_picture_url: map['profile_picture_url'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));
}
