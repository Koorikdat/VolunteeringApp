class UserRequestsModel {
  String address2;
  String id;
  String time;
  String status;
  String address1;
  double lat;
  double lng;


  UserRequestsModel({
    required this.address2,
    required this.time,
    required this.id,
    required this.status,
    required this.address1,
    required this.lat,
    required this.lng,
  });


  factory UserRequestsModel.fromMap(Map<String, dynamic> map) =>
      UserRequestsModel(
        address2: map['address2'],
        time: map['time'],
        status: map['status'],
        id: map['id'],
        address1: map['address1'],
        lat: map['lat'],
        lng: map['lng'],
      );


  toMap() =>
      {
        'address2': address2,
        'time': time,
        'id': id,
        'status': status,
        'address1': address1,
        'lat': lat,
        'lng': lng,
      };


}