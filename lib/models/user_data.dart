class UserData {
  final String id;
  final String email;
  final String username;
  final String password;
  final String imgUrl;

  UserData({
    required this.id, 
    required this.email, 
    required this.username, 
    required this.password,
    this.imgUrl = '',
  }
  );

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'id': id});
    result.addAll({'email': email});
    result.addAll({'username': username});
    result.addAll({'password': password});
    result.addAll({'imgUrl': imgUrl});
  
    return result;
  }

  factory UserData.fromMap(Map<String, dynamic> map, String documentId) {
    return UserData(
      id: documentId,
      email: map['email'] ?? '',
      username: map['username'] ?? '',
      password: map['password'] ?? '',
      imgUrl: map['imgUrl'] ?? '',
    );
  }
}

List<UserData> dummyUsers = [
  UserData(
    id: 'Hz8KjNGTAdNIOlYnACpd',
    username: 'Tarik',
    email: 'tarik@test.com',
    imgUrl: 'https://pbs.twimg.com/profile_images/1493704582505144323/Stvh3FSK_400x400.jpg',
    password: 'tarik1234',
  ),
];
