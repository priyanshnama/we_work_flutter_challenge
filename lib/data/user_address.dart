class UserAddress {
  final String mainAddress;
  final String secondaryAddress;

  UserAddress({
    required this.mainAddress,
    required this.secondaryAddress,
  });

  // Factory constructor to create a Location from a JSON object
  factory UserAddress.fromJson(Map<String, dynamic> json) {
    return UserAddress(
      mainAddress: json['mainAddress'],
      secondaryAddress: json['secondaryAddress'],
    );
  }

  // Method to convert a Location instance to a JSON object
  Map<String, dynamic> toJson() {
    return {
      'mainAddress': mainAddress,
      'secondaryAddress': secondaryAddress,
    };
  }
}
