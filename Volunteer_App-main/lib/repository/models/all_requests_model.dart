class AllRequestsModel {
  String address2;
  String id;
  String time;
  String address1;
  double lat;
  double lng;


  AllRequestsModel({
    required this.address2,
    required this.time,
    required this.id,
    required this.address1,
    required this.lat,
    required this.lng,
  });


  factory AllRequestsModel.fromMap(Map<String, dynamic> map) =>
      AllRequestsModel(
        address2: map['address2'],
        time: map['time'],
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
        'address1': address1,
        'lat': lat,
        'lng': lng,
      };


}