import 'package:dio/dio.dart';
import 'package:latlong2/latlong.dart';
import 'package:monlivreur/Providers/dio_exceptions.dart';

Future<Map> getDirectionsAPIResponse(
    LatLng sourceLatLng, LatLng destinationLatLng) async {
  final response = await getCyclingRouteUsingMapbox(sourceLatLng, destinationLatLng);
  Map geometry = response['routes'][0]['geometry'];
  num duration = response['routes'][0]['duration'];
  num distance = response['routes'][0]['distance'];

  Map modifiedResponse = {
    "geometry": geometry,
    "duration": duration,
    "distance": distance,
  };
  print(modifiedResponse);
  return modifiedResponse;
}

String baseUrl = 'https://api.mapbox.com/directions/v5/mapbox';
String accessToken =
    'sk.eyJ1IjoiaGF6ZW1obyIsImEiOiJjbGJwd3NnNDUwYmxmM3Vtdnl6NGh5OWh4In0.pGkNgbea_lA2O2DPQpE6oA';
String navType = 'driving';
Dio _dio = Dio();
Future getCyclingRouteUsingMapbox(LatLng source, LatLng destination) async {
  String url =
      '$baseUrl/$navType/${source.longitude},${source.latitude};${destination.longitude},${destination.latitude}?alternatives=true&continue_straight=true&geometries=geojson&language=en&overview=full&steps=true&access_token=$accessToken';
  print(url);
  try {
    _dio.options.contentType = Headers.jsonContentType;
    final responseData = await _dio.get(url);
    return responseData.data;
  } catch (e) {
    final errorMessage = DioExceptions.fromDioError(e as DioError).toString();
    print(errorMessage);
  }
}
