class UserDM{
  static const String CollectionName="users";
  static UserDM? currentUser;
  String name;
  String ID;
  String Email;
  UserDM({required this.name,required this.ID,required this.Email});

  UserDM.fromJason(Map<String,dynamic> jason):
    ID=jason['ID'],
    name=jason['name'],
    Email=jason['Email'];


  Map<String,dynamic> toJason(){
    return {
      'ID':ID,
      'name':name,
      'Email':Email
    };
  }
}