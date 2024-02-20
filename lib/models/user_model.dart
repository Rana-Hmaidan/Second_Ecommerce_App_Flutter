class User{
  final String id;
  final String userName;
  final String email;
  final String imgUrl;
  final String password;

  User({
    required this.id,
    required this.userName,
    required this.email,
    required this.imgUrl,
    required this.password,
  });

}

List<User> dummyUsers = [
  User(
    id: '1',
    userName: 'Tarik',
    email: 'tarik@test.com',
    imgUrl: 'https://pbs.twimg.com/profile_images/1493704582505144323/Stvh3FSK_400x400.jpg',
    password: '123456'
  ),
];
