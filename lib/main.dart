import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:req_res/DemoData/demo_data.dart';
import 'package:req_res/Screens/Creation.dart';
import 'package:req_res/Services/api_response.dart';
import 'package:req_res/Services/user_data_service.dart';

void setupLocator() {
  GetIt.instance.registerLazySingleton(() => UserDataService());
}

void main() {
  setupLocator();
  runApp(MaterialApp(
    title: "Req_Res",
    debugShowCheckedModeBanner: false,
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

class _HomeState extends State<Home> {
  UserDataService get service => GetIt.I<UserDataService>();

  APIResponse<List<UserInfo>> _usersList;
  APIResponse<List<UserInfo>> _user;

  APIResponse<List<UserInfo>> _apiResponse;

  bool _isLoading;

  int _currentPage = 0;

  final PageController ctrl = new PageController(viewportFraction: 0.8);

  bool isSingle = false;

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  fetchData() async {
    setState(() {
      _isLoading = true;
    });

    _usersList = await service.getUserList();
    _apiResponse = _usersList;
    _user = await service.getUser();

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "REST API",
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          elevation: 0.0,
          backgroundColor: Colors.transparent,
        ),
        body: Builder(
          builder: (_) {
            if (_isLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            if (_user.error || _usersList.error) {
              return Center(
                child: Text(_user.errorMessage??_usersList.errorMessage),
              );
            }

            return PageView.builder(
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                controller: ctrl,
                itemCount: _apiResponse.data.length + 1,
                itemBuilder: (context, index) {
                  bool active = index == _currentPage;

                  return (index == 0)
                      ? _buildOptions(context)
                      : _buildBody(
                          active: active,
                          avatar: _apiResponse.data[index - 1].avatar,
                          empId: _apiResponse.data[index - 1].userId,
                          firstName: _apiResponse.data[index - 1].firstName,
                          lastName: _apiResponse.data[index - 1].lastName,
                          email: _apiResponse.data[index - 1].email);
                });
          },
        ));
  }

  Widget _buildOptions(context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _buildButton('team', "Users", () {
            setState(() {
              isSingle = false;
              _apiResponse = _usersList;
            });
            showSnackBar(context, "Swipe left to see changes");
          }, isSingle ? Colors.transparent : Colors.teal),
          SizedBox(
            height: 10.0,
          ),
          _buildButton('single', "SingleUser", () {
            setState(() {
              isSingle = true;
              _apiResponse = _user;
            });
            showSnackBar(context, "Swipe left to see changes");
          }, isSingle ? Colors.teal : Colors.transparent),
          SizedBox(
            height: 10.0,
          ),
          _buildButton('create', "CreateUser", () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => PostRequest()));
          }, Colors.transparent),
        ],
      ),
    );
  }

  Widget _buildButton(String image, String title, onPressed, color) {
    return RaisedButton(
      onPressed: onPressed,
      color: color,
      padding: EdgeInsets.all(8.0),
      child: Row(
        children: <Widget>[
          Image.asset(
            'images/$image.png',
            height: 70,
            width: 70,
          ),
          Text('#$title')
        ],
      ),
    );
  }

  Widget _buildBody(
      {bool active,
      String avatar = "",
      int empId = 0,
      String firstName = "",
      String lastName = "",
      String email = ""}) {
    // final double blur = active? 10:0;
    // final double offset = active?3:0;
    final double top = active ? 50 : 120;
    final double bottom = active ? 50 : 120;

    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      curve: Curves.easeOutQuint,
      margin: EdgeInsets.only(top: top, bottom: bottom, right: 20),
      decoration: BoxDecoration(
        
        // border: Border.all(),
      ),
      child: Card(
        elevation: 10.0,
        // color: Colors.blue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0)
        ),
        // padding: EdgeInsets.all(10.0),
        // decoration: BoxDecoration(
        //     borderRadius: BorderRadius.circular(10.0), color: Colors.white),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _buildAvatar(avatar),
            _buildUserDetail("$firstName $lastName", "$email", empId)
          ],
        ),
      ),
    );
  }

  Widget _buildAvatar(String imagePath) {
    return Material(
      elevation: 10.0,
      shape: CircleBorder(),
      child: CircleAvatar(
        backgroundImage: NetworkImage(
          imagePath,
        ),
        radius: 80.0,
      ),
    );
  }

  Widget _buildUserDetail(String name, String email, int empId) {
    return Container(
      height: 100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Text("Employee id : $empId"),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                name,
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              Text(email),
            ],
          ),
        ],
      ),
    );
  }

  void showSnackBar(context, text) {
    final snackBar = SnackBar(
      content: Text(text),
      duration: Duration(milliseconds: 500),
    );
    Scaffold.of(context).showSnackBar(snackBar);
  }
}
