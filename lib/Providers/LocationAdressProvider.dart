import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

class LocationAdressProvider with ChangeNotifier {

  LatLng _CoordDestination = LatLng(0, 0);
  LatLng _CoordSource = LatLng(0, 0);

  String _LocationAdress = '';
  String _LocationDestinationAdress = '';

  String get LocationAdress {
    return _LocationAdress;
  }

  LatLng get CoordDestination {
    return _CoordDestination;
  }

  PickCoordSource(newCoord) {
    _CoordSource = newCoord;
    notifyListeners();
    print(_CoordSource);
    return _CoordSource;
  }

  LatLng get CoordSource {
    return _CoordSource;
  }

  PickCoordDestinataion(newCoord) {
    _CoordDestination = newCoord;
    notifyListeners();
    print(_CoordDestination);
    return _CoordDestination;
  }

  String get LocationDestinationAdress {
    return _LocationDestinationAdress;
  }

  PickUpadressName(newlocation) {
    _LocationAdress = newlocation;
    print(_LocationAdress);
    notifyListeners();
    return _LocationAdress;
  }

  DestinationAdressName(newDestiantionlocation) {
    _LocationDestinationAdress = newDestiantionlocation;
    print(_LocationDestinationAdress);
    notifyListeners();
    return _LocationDestinationAdress;
  }
}
