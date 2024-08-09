import 'package:ecom_app/core/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

/*
TODO пофиксить баг с диспоузем мап контроллера
*/
class MapWidget extends StatefulWidget {
  final Position currentPosition;
  const MapWidget({
    super.key,
    required this.currentPosition,
  });

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  YandexMapController? _mapController;
  CameraPosition? _userLocation;
  var _mapZoom = 0.0;

  @override
  void initState() {
    super.initState();
    _initUserLocation();
  }

  @override
  void dispose() {
    _mapController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      width: 180,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: YandexMap(
          onMapCreated: (controller) async {
            _mapController = controller;
            if (_userLocation != null) {
              await _moveCameraToUserLocation();
            }
          },
          onMapTap: (argument) => _initLocationLayer(),
          onCameraPositionChanged: (cameraPosition, _, __) {
            setState(() {
              _mapZoom = cameraPosition.zoom;
            });
          },
          onUserLocationAdded: (view) async {
            _userLocation = await _mapController?.getUserCameraPosition();
            if (_userLocation != null) {
              await _moveCameraToUserLocation();
            }
            return view.copyWith(
              pin: view.pin.copyWith(
                opacity: 1,
              ),
            );
          },
        ),
      ),
    );
  }

  Future<void> _initLocationLayer() async {
    final locationPermissionIsGranted =
        await Permission.location.request().isGranted;

    if (locationPermissionIsGranted && _mapController != null) {
      await _mapController!.toggleUserLayer(visible: true);
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(TTextConstants.locationError),
          ),
        );
      });
    }
  }

  Future<void> _moveCameraToUserLocation() async {
    if (_mapController != null && _userLocation != null) {
      await _mapController!.moveCamera(
        CameraUpdate.newCameraPosition(
          _userLocation!.copyWith(zoom: 20.0),
        ),
        animation: const MapAnimation(
          type: MapAnimationType.linear,
          duration: 0.3,
        ),
      );
    }
  }

  void _initUserLocation() {
    _userLocation = CameraPosition(
      target: Point(
        latitude: widget.currentPosition.latitude,
        longitude: widget.currentPosition.longitude,
      ),
      zoom: 14.0,
    );
  }
}
