import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:req_res/DemoData/demo_data.dart';
import 'package:req_res/Screens/Creation.dart';
import 'package:req_res/Screens/SingleUserDisplay.dart';
import 'package:req_res/Screens/UserDelete.dart';
import 'package:req_res/Services/api_response.dart';
import 'package:req_res/Services/user_data_service.dart';
import 'Screens/User Creation.dart';

void setupLocator() {
  GetIt.instance.registerLazySingleton(() => UserDataService());
}

void main() {
  setupLocator();
  runApp(MaterialApp(
    title: "Req_Res",
    theme: ThemeData(
      primaryColor: Colors.deepPurple,
      primarySwatch: Colors.deepPurple,
    ),
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

// When you decide to use the demo data Dont forget to replace "_apiResponse.data" with "users"


class _HomeState extends State<Home> {

//  List<UserInfo> users; //uncomment

  UserDataService get service => GetIt.I<UserDataService>();

// Comment this portion
  APIResponse<List<UserInfo>> _apiResponse;
  bool _isLoading = false;
  // till here

  @override
  void initState() {
// Uncomment this line to use demo data
//    users = service.getUserInfo(); 

    _fetchData(); // Comment it out
    super.initState();
  }


// To use the Demo data ..... Comment the following out
  _fetchData() async {
    setState(() {
      _isLoading = true;
    });

    _apiResponse = await service.getUserList();

    setState(() {
      _isLoading = false;
    });
  }
  // Till this point


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: Icon(Icons.book),
        elevation: 0.0,
        title: Text("User's list"),
      ),

      body: Builder(
        builder: (context) {

          if(_isLoading) {
            return Center(child: CircularProgressIndicator());
          }

          if(_apiResponse.error) {
            return Center(child: Text(_apiResponse.errorMessage),);
          }

          return ListView.builder(
              itemCount: _apiResponse.data.length,
              itemBuilder: (context,index) {
                return GestureDetector(
                  onLongPress: () {
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) => CreateUser(
                          mode: Mode.Editing,
                          firstName: "${_apiResponse.data[index].firstName}",
                          lastName: "${_apiResponse.data[index].lastName}",
                          email: "${_apiResponse.data[index].email}",
                          avatar: "${_apiResponse.data[index].avatar}",
                          empId: _apiResponse.data[index].userId,
                        )
                    ));
                  },
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) => SingleUserView(
                          name: "${_apiResponse.data[index].firstName} ${_apiResponse.data[index].lastName}",
                          email: "${_apiResponse.data[index].email}",
                          avatar: "${_apiResponse.data[index].avatar}",
                          empId: _apiResponse.data[index].userId,
                        )
                    ));
                  },
                  child: Container(
                      height: 100.0,
                      margin: EdgeInsets.symmetric(vertical: 5.0,horizontal: 20.0),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black
                            )
                          ]
                      ),
                      child: Dismissible(
                        key: ValueKey(_apiResponse.data[index].userId),
                        direction: DismissDirection.endToStart,
                        onDismissed: (direction) {

                        },
                        confirmDismiss: (direction) async{
                          final result = await showDialog(
                              context: context,
                              builder: (context) => DeleteUser()
                          );
                          print(result);
                          return result;
                        },
                        background: Container(
                          color: Colors.brown,
                          padding: EdgeInsets.only(right: 15.0),
                          child: Align(child: Icon(Icons.delete_forever, color: Colors.white,),alignment: Alignment.centerRight,),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            _buildAvatar('${_apiResponse.data[index].avatar}'),
                            Text('${_apiResponse.data[index].firstName} ${_apiResponse.data[index].lastName}')
                          ],
                        ),)
                  ),
                );
              }
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PostRequest()
            )
          );
        },
        child: Icon(Icons.person_add),
      ),
    );
  }

   Widget _buildAvatar(String imagePath){
    return Material(
          elevation: 10.0,
          shape: CircleBorder(),
          child: CircleAvatar(
            backgroundImage: NetworkImage(imagePath,),
            radius: 40.0,
          ),
        );
  }

}
