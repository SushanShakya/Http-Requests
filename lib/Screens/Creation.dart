import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:req_res/DemoData/UserInsert.dart';
import 'package:req_res/Services/user_data_service.dart';

class PostRequest extends StatefulWidget {
  @override
  _PostRequestState createState() => _PostRequestState();
}

class _PostRequestState extends State<PostRequest> {
  
  final _formKey = GlobalKey<FormState>();

  UserDataService get service => GetIt.I<UserDataService>();

  TextEditingController _name = TextEditingController();
  TextEditingController _job = TextEditingController();
  
  @override
  void dispose() {
    _name.dispose();
    _job.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Create a User", style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: GestureDetector(onTap: () {Navigator.of(context).pop();}, child: Icon(Icons.arrow_back_ios, color: Colors.black,),),
        elevation: 0.0,
      ),

      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          children: <Widget>[
            SizedBox(height: 20.0,),
            _buildTextField("Name", _name),
            SizedBox(height: 20.0,),
            _buildTextField("Job", _job),
            SizedBox(height: 10.0,),
            _buildButton('Done'),
            SizedBox(height: 10.0,),
          ],
        ),
      )
    );
  }

  Widget _buildButton(String title) {
    return RaisedButton(
      color: Colors.teal,
      padding: EdgeInsets.all(20.0),
      onPressed: () async{
      
          if(_formKey.currentState.validate()){

//            setState(() {
//            });

            final user = UserInsert(
              name: _name.text,
              job: _job.text
          );

          final result = await service.createUser(user);

          final text = result.error ? result.errorMessage : "Yay !! You Successfully created it";

          showDialog(
              context: context,
            builder: (_) => AlertDialog(
              title: Text("Done"),
              content: Text(text),
              actions: <Widget>[
                FlatButton(
                  child: Text("OK"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            )
          )
            .then((data){
              if(result.data) {
                Navigator.of(context).pop();
              }
          });
        }

      },
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