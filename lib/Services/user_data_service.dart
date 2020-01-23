// Comment the following portion

import 'package:req_res/DemoData/UserInsert.dart';
import 'package:req_res/DemoData/demo_data.dart';
import 'package:req_res/Services/api_response.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserDataService{

  static const API = "https://reqres.in";

  Future<APIResponse<List<UserInfo>>> getUserList() {
    return http.get(
      Uri.encodeFull("$API/api/users?page=2")
    )
         .then((data) {
       if(data.statusCode == 200) {
         final jsonData = json.decode(data.body);
         final userData = <UserInfo>[];
         final actualData = jsonData["data"];
         for(var item in actualData) {
           userData.add(UserInfo.fromJson(item));
         }

         return APIResponse<List<UserInfo>>(
           data: userData
         );
       }

       return APIResponse<List<UserInfo>>(
           error: true,
         errorMessage: 'Unfortunately Something went wrong'
       );
    }).catchError(
        (_)=> APIResponse<List<UserInfo>>(error: true,errorMessage: 'Unfortunately Something went wrong')
    );
  }

  Future<APIResponse<UserInfo>> getUserSingle() {
    return http.get(
      Uri.encodeFull("$API/api/users/2")
    )
         .then((data) {
       if(data.statusCode == 200) {
         final jsonData = json.decode(data.body);
         final item = jsonData["data"];
         final uData = UserInfo.fromJson(item);

         return APIResponse<UserInfo>(
           data: uData
         );
       }

       return APIResponse<UserInfo>(
           error: true,
         errorMessage: 'Unfortunately Something went wrong'
       );
    }).catchError(
        (_)=> APIResponse<UserInfo>(error: true,errorMessage: 'Unfortunately Something went wrong')
    );
  }

  Future<APIResponse<bool>> createUser(UserInsert item) {
    return http.post(
      "$API/api/users",
      body: json.encode(item.toJson())
    )
         .then((data) {
       if(data.statusCode == 201) {
         return APIResponse<bool>(
           data: true 
         );
       }

       return APIResponse<bool>(
           error: true,
         errorMessage: 'Unfortunately Something went wrong'
       );
    }).catchError(
        (_)=> APIResponse<bool>(error: true,errorMessage: 'Unfortunately Something went wrong')
    );
  }
}




// Till here


// Uncomment this one out

//import 'package:req_res/DemoData/demo_data.dart';
//
//class UserDataService {
//
//  List<UserInfo> getUserInfo() {
//    return [
//      UserInfo(
//          userId: 1,
//          firstName: "Sushan",
//          lastName: 'Shakya',
//          email: 'sushaanshakya88@gmail.com'
//      ),
//      UserInfo(
//          userId: 1,
//          firstName: "Susman",
//          lastName: 'Shakya',
//          email: 'sushaanshakya88@gmail.com'
//      ),
//      UserInfo(
//          userId: 1,
//          firstName: "Suskun",
//          lastName: 'Shakya',
//          email: 'sushaanshakya88@gmail.com'
//      ),
//    ];
//  }
//
//}