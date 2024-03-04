class PaymentMethodModel{
  final String id;
  final String cardNumber;
  final String cardHolderName;
  final String expiryDate;
  final String ccvCard;
  final String imgUrl;
  final String name;
  final bool isSelected;

  PaymentMethodModel({
    required this.id, 
    required this.cardNumber, 
    required this.cardHolderName, 
    required this.expiryDate, 
    required this.ccvCard,
    this.isSelected = false,
    this.name = 'Master Card',
    this.imgUrl ='https://images.fastcompany.net/image/upload/w_1200,c_limit,q_auto:best/wp-cms/uploads/2023/04/i-3-90885664-mastercard-logo.jpg',
  });

   PaymentMethodModel copyWith({
    String? id,
    String? cardNumber,
    String? cardHolderName,
    String? expiryDate,
    String? ccvCard,
    String? name,
    String? imgUrl,
    bool? isSelected,
  }) {
    return PaymentMethodModel(
      id: id ?? this.id,
      cardNumber: cardNumber ?? this.cardNumber,
      cardHolderName: cardHolderName ?? this.cardHolderName,
      expiryDate: expiryDate ?? this.expiryDate,
      ccvCard: ccvCard ?? this.ccvCard,
      name: name ?? this.name,
      imgUrl: imgUrl ?? this.imgUrl,
      isSelected: isSelected ?? this.isSelected,
    );
  }


   Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'id': id});
    result.addAll({'cardNumber': cardNumber});
    result.addAll({'cardHolderName': cardHolderName});
    result.addAll({'expiryDate': expiryDate});
    result.addAll({'ccvCard': ccvCard});
    result.addAll({'name': name});
    result.addAll({'imgUrl': imgUrl});
  
    return result;
  }

  factory PaymentMethodModel.fromMap(Map<String, dynamic> map, String documentId) {
    return PaymentMethodModel(
      id: documentId,
      cardNumber: map['cardNumber'] ?? '',
      cardHolderName: map['cardHolderName'] ?? '',
      expiryDate: map['expiryDate'] ?? '',
      ccvCard: map['ccvCard'] ?? '',
      name: map['name'] ?? '',
      imgUrl: map['imgUrl'] ?? '',
    );
  }
  
}

List<PaymentMethodModel> savedCards =[
  PaymentMethodModel(
    id: '1',
    cardNumber: '4567892251145',
    cardHolderName: 'Ahmed Mohammad',
    expiryDate: '01/28',
    ccvCard: '375',
  ),
  PaymentMethodModel(
    id:'2' ,
    cardNumber: '4567892261145',
    cardHolderName: 'Tala Mohammad',
    expiryDate: '01/25',
    ccvCard: '388',
  ),
  PaymentMethodModel(
    id: '3',
    cardNumber: '4567892271145',
    cardHolderName: 'Sami Mohammad',
    expiryDate: '01/26',
    ccvCard: '283',
  ),
];