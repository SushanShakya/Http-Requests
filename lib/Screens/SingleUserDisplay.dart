import 'package:flutter/material.dart';

class SingleUserView extends StatelessWidget {

  final String name;
  final String email;
  final String avatar;
  final int empId;

  SingleUserView({@required this.name, this.email, this.avatar, this.empId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        title: Text('User Details'),
        leading: GestureDetector(onTap: () {Navigator.pop(context);},child: Icon(Icons.arrow_back_ios),),
      ),
      body: Stack(
          children: <Widget>[
            Container(
              height: 250,
              color: Colors.teal,
            ),

           SingleChildScrollView(
             child: Column(
                children: <Widget>[
                  SizedBox(height: 20.0,),
                  _buildAvatar(avatar),
                  SizedBox(height: 10.0,),
                  _buildUserDetail(context,'$name','$email','$empId'),
                ],
              ),
           ),

          ],
        ),
    );
  }

  Widget _buildAvatar(String imagePath){
    return Material(
          elevation: 10.0,
          shape: CircleBorder(),
          child: CircleAvatar(
            backgroundImage: NetworkImage(imagePath,),
            radius: 80.0,
          ),
        );
  }

  Widget _buildUserDetail(context,String name, String email, String empId) {
    return Container(
      height: 150.0,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(horizontal: 40.0,vertical: 10.0),
      padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            blurRadius: 10.0
          )
        ]
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Text("Employee id : $empId"),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(name, style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),),
              Text(email),
            ],
          ),
        ],
      ),
    );
  }
}
