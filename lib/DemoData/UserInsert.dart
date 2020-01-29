
import 'package:flutter/foundation.dart';

class UserInsert {
  String name;
  String job;

  UserInsert({ 
     @required this.name,
     @required this.job
    }
    );

  Map<String,dynamic> toJson() {
    return {
        "name"  : name,
        "job"   : job
    };
  }
}