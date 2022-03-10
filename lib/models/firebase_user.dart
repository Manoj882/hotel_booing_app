class Firebaseuser{
  late String? displayName;
  late String? email;
  late String? photoUrl;
  late String? uuid;

  Firebaseuser({
    required this.displayName,
    required this.email,
    required this.photoUrl,
    required this.uuid,

  });

  Map toJson(){
    final map = {};
    map["uuid"] = uuid;
    map["name"] = displayName;
    map["email"] = email;
    map["photoUrl"] = photoUrl;
    return map;
    
  }


}