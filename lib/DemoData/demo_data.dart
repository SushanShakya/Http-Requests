class UserInfo{
  final int userId;
  final String firstName;
  final String lastName;
  final String email;
  final avatar;

  UserInfo({this.userId, this.firstName, this.lastName, this.email, this.avatar});

  factory UserInfo.fromJson(Map<dynamic,dynamic> item) {
    return UserInfo(
             userId: item['id'],
             firstName: item['first_name'],
             lastName: item['last_name'],
             email: item['email'],
             avatar: item['avatar'],
           );
  }
}

// class DemoData{
//   List<UserInfo> users = [
//     UserInfo(
//       userId: 1,
//       firstName: "Sushan",
//       lastName: 'Shakya',
//       email: 'sushaanshakya88@gmail.com'
//     ),
//     UserInfo(
//       userId: 1,
//       firstName: "Susman",
//       lastName: 'Shakya',
//       email: 'sushaanshakya88@gmail.com'
//     ),
//     UserInfo(
//       userId: 1,
//       firstName: "Suskun",
//       lastName: 'Shakya',
//       email: 'sushaanshakya88@gmail.com'
//     ),
//   ];

//   List get userList => users;
// }