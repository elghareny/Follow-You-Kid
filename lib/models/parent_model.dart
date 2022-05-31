class ParentModel 
{
  String name;
  String email;
  String phone;
  String uId;
  String image;
  String childId;
  bool isEmailVerified;

  ParentModel({
    this.name,
    this.email,
    this.phone,
    this.uId,
    this.image,
    this.childId,
    this.isEmailVerified,
  });

  ParentModel.fromJson(Map<String,dynamic> json)
  {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    uId = json['uId'];
    image = json['image'];
    childId = json['childId'];
    isEmailVerified = json['isEmailVerified'];
  }


  Map<String,dynamic> toMap()
  {
    return {
      'name':name,
      'email':email,
      'phone':phone,
      'uId':uId,
      'childId':childId,
      'isEmailVerified':isEmailVerified,
    };
  }

}



//////////////////////////////////////////////////////////////////////////////




class HomeModel 
{
  double latitude;
  double longitude;
  String addressLine;
  String countryName;
  String postalCode;

  HomeModel({
    this.latitude,
    this.longitude,
    this.addressLine,
    this.countryName,
    this.postalCode,
  
  });

  HomeModel.fromJson(Map<String,dynamic> json)
  {
    latitude = json['latitude'];
    longitude = json['longitude'];
    addressLine = json['Address'];
    countryName = json['country'];
    postalCode = json['postalcode'];
  
  }


  Map<String,dynamic> toMap()
  {
    return {
      'latitude':latitude,
      'longitude':longitude,
      'Address':addressLine,
      'country':countryName,
      'postalcode':postalCode, 
    };
  }

}