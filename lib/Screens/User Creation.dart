import 'package:flutter/material.dart';

enum Mode{
  Adding,Editing
}

class CreateUser extends StatefulWidget {
  final Mode mode;
  final String avatar;
  final int empId;
  final String firstName;
  final String lastName;
  final String email;

  CreateUser({@required this.mode, this.avatar, this.empId, this.email,this.firstName, this.lastName});

  @override
  _CreateUserState createState() => _CreateUserState();
}

class _CreateUserState extends State<CreateUser> {

  TextEditingController _firstName = new TextEditingController();
  TextEditingController _lastName = new TextEditingController();
  TextEditingController _email = new TextEditingController();
  TextEditingController _id = new TextEditingController();

  final _formKey = GlobalKey<FormState>();

//  FocusNode _fName = new FocusNode();
//  FocusNode _lName = new FocusNode();
//  FocusNode _mail = new FocusNode();

@override
  void initState() {
    if(widget.firstName != null){
      _firstName.text = "${widget.firstName}";
    _lastName.text = "${widget.lastName}";
    _email.text = "${widget.email}";
    _id.text = "${widget.empId}";
    }
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.mode == Mode.Adding ? 'Create New User' : 'Edit User'
        ),
      ),

      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          children: <Widget>[
            SizedBox(height: 20.0,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: 100.0,
                  width: 100.0,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    // image: NetworkImage(),
                    borderRadius: BorderRadius.circular(50.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black,
                        spreadRadius: 1
                      )
                    ]
                  ),
                  child: _buildAvatar(widget.avatar),
                )
              ],
            ),
            SizedBox(height: 20.0,),
            _buildTextField('ID', _id),
            SizedBox(height: 10.0,),
            _buildTextField('First Name', _firstName),
            SizedBox(height: 10.0,),
            _buildTextField('Last Name', _lastName),
            SizedBox(height: 10.0,),
            _buildTextField('Email', _email),
            SizedBox(height: 10.0,),
            _buildButton('Done'),
            SizedBox(height: 10.0,),
          ],
        ),
      )
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

  Widget _buildButton(String title) {
    return RaisedButton(
      color: Colors.teal,
      onPressed: () {
        _formKey.currentState.validate()?
            Navigator.pop(context)
            :
        print("Oops Something not right here");

        print('add');
      },
//      padding: EdgeInsets.all(15.0),
      child: Text(title,),
    );
  }

  Widget _buildTextField(String title, TextEditingController controller) {
    return TextFormField(
      validator: (value){
        if(value.isEmpty){
          return "Cannot be empty";
        }

        return null;
      },
      controller: controller,
      decoration: InputDecoration(
          labelText: title,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0)
        )
      ),
    );
  }
}
