import 'package:equatable/equatable.dart';

class UserRegistration extends Equatable {
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String email;
  final String password;
  final String bvn;
  final String cardName;
  final String cardNumber;
  final String expiryDate;
  final String cvv;
  final String billingAddress;
  final String? referralCode;

  const UserRegistration({
    this.firstName = '',
    this.lastName = '',
    this.phoneNumber = '',
    this.email = '',
    this.password = '',
    this.bvn = '',
    this.cardName = '',
    this.cardNumber = '',
    this.expiryDate = '',
    this.cvv = '',
    this.billingAddress = '',
    this.referralCode,
  });

  UserRegistration copyWith({
    String? firstName,
    String? lastName,
    String? phoneNumber,
    String? email,
    String? password,
    String? bvn,
    String? cardName,
    String? cardNumber,
    String? expiryDate,
    String? cvv,
    String? billingAddress,
    String? referralCode,
  }) {
    return UserRegistration(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
      password: password ?? this.password,
      bvn: bvn ?? this.bvn,
      cardName: cardName ?? this.cardName,
      cardNumber: cardNumber ?? this.cardNumber,
      expiryDate: expiryDate ?? this.expiryDate,
      cvv: cvv ?? this.cvv,
      billingAddress: billingAddress ?? this.billingAddress,
      referralCode: referralCode ?? this.referralCode,
    );
  }

  bool get isBasicInfoComplete => 
      firstName.isNotEmpty && 
      lastName.isNotEmpty && 
      phoneNumber.isNotEmpty && 
      email.isNotEmpty && 
      password.isNotEmpty;

  bool get isBVNComplete => bvn.length == 11;

  bool get isCardDetailsComplete => 
      cardName.isNotEmpty && 
      cardNumber.isNotEmpty && 
      expiryDate.isNotEmpty && 
      cvv.isNotEmpty && 
      billingAddress.isNotEmpty;

  @override
  List<Object?> get props => [
        firstName,
        lastName,
        phoneNumber,
        email,
        password,
        bvn,
        cardName,
        cardNumber,
        expiryDate,
        cvv,
        billingAddress,
        referralCode,
      ];

  @override
  String toString() {
    return 'UserRegistration(firstName: $firstName, lastName: $lastName, phoneNumber: $phoneNumber, email: $email)';
  }
}