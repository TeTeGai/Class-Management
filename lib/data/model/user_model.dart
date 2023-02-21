class UserModel{
   final String id;
   final String email;
   final String firstName;
   final String lastName;
   final String phoneNumber;
   final String sex;
   final String avatar;
   final String role;
   final String pushToken;
   Map<String, dynamic> toMap()
   {
     return{
       "id": this.id,
       "email": this.email,
       "fristName": this.firstName,
       "lastName": this.lastName,
       "phoneNumber": this.phoneNumber,
       "sex": this.sex,
       "avatar": this.avatar,
       "role": this.role,
       "pushToken": this.pushToken
     };
   }
   static UserModel fromMap(Map<String, dynamic> data) {
     return UserModel(
       id: data["id"] ?? "",
       email: data["email"] ?? "",
       firstName:  data["fristName"] ?? "",
       lastName: data["lastName"] ?? "",
       sex:  data["sex"]?? "",
       phoneNumber: data["phoneNumber"] ?? "",
       avatar: data["avatar"] ?? "",
       role: data["role"] ??"",
       pushToken: data["pushToken"]??""
     );
   }
  const UserModel({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.sex,
    required this.avatar,
    required this.role,
    required this.pushToken,
  });


   UserModel cloneWith({
      id,
      email,
      firstName,
      lastName,
      phoneNumber,
      sex,
      avatar,
      role,
     pushToken
   }) {
      return UserModel(
         id: id ?? this.id,
         email: email ?? this.email,
         firstName: firstName ?? this.firstName,
         lastName: lastName ?? this.lastName,
         phoneNumber: phoneNumber ?? this.phoneNumber,
         sex: sex?? this.sex,
         avatar: avatar ?? this.avatar,
          role: role ?? this.role,
          pushToken: pushToken?? this.pushToken
      );
   }
}