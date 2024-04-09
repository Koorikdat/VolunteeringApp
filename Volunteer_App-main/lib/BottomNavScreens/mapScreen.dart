import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:volunteer_application/AppConstants/AppConstants.dart';
import 'package:volunteer_application/BottomNavScreens/mapCustomWidgets.dart';
import 'dart:ui' as ui;
import '../repository/get_marker.dart';
import '../repository/models/all_requests_model.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key, this.cameraPosition, this.id});
  final CameraPosition? cameraPosition;
  final String? id;

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {

  String selectedMarker = '';
  late GoogleMapController _googleController;
  final Completer<GoogleMapController> _controller = Completer();
  CameraPosition kCameraPosition = const CameraPosition(
    target: LatLng(43.119013, -79.250826),
    zoom: 14.4746,
  );
  List<Marker> markers = [];
  BitmapDescriptor icon = BitmapDescriptor.defaultMarker;


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showBottomSheet(widget.id);
    });
    getMarkers();
  }

  getMarkers() async {
    await getMarkerIcon();
    final value = await GetMarker().getMarkers();
    for(final result in value) {
      final model = AllRequestsModel.fromMap(result.data());
      final marker = Marker(
        markerId: MarkerId(model.id),
        position: LatLng(model.lat, model.lng),
        icon: icon,
        onTap: (){
          _showBottomSheet(model.id);
        },
        infoWindow: InfoWindow(
          title: model.address1,
        ),
      );
      markers.add(marker);
      setState(() {});
    }
  }// Get markers

  getMarkerIcon() async {
    Future<Uint8List?> getBytesFromAsset(String path, int width) async {
      ByteData data = await rootBundle.load(path);
      ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
      ui.FrameInfo fi = await codec.getNextFrame();
      return (await fi.image.toByteData(format: ui.ImageByteFormat.png))?.buffer.asUint8List();
    }

    final Uint8List? markerIcon = await getBytesFromAsset('assets/images/pp.png', 100);
    var mIcon= BitmapDescriptor.fromBytes(markerIcon!);
    setState(() {
      icon = mIcon;
    });

  }


  void _showBottomSheet(String? id) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return  MapRequestTile(id: id);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.small(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.r)
        ),
        backgroundColor: kColorWhite,
          onPressed: (){
          _showBottomSheet('');
          },
        child: const Icon(Icons.open_in_full_outlined),
      ),
        body: SafeArea(
      child: Stack(
        children: [
              GoogleMap(
                zoomControlsEnabled: false,
                compassEnabled: false,
                initialCameraPosition: kCameraPosition,
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                  _googleController = controller;
                  widget.cameraPosition != null ? _googleController.animateCamera(CameraUpdate.newCameraPosition(widget.cameraPosition!)): null;
                },
                markers:Set<Marker>.of(markers) ,
              ),


          Positioned(
            top: 0,
            left: 0,
            child: Container(
              height: 69.h,
              width: 397.w,
              color: kColorPrimary,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 18.w),
                child: Text("Map", style: kStyleWhite22600),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
