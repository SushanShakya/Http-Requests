class UserInsert {
  String name;
  String job;

  UserInsert({ 
     this.name, 
     this.job
    }
    );

  Map<String,dynamic> toJson() {
    return {
        "name"  : name,
        "job"   : job
    };
  }
}