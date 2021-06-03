import 'package:geocoder/geocoder.dart';

class LocationHelper {

  // Get coordinates from address
  Future<Coordinates> getGeoFromAddress (String query) async {
    var addresses = await Geocoder.local.findAddressesFromQuery(query);
    var first = addresses.first;
    return first.coordinates;
  }

  Future<String> getAddressFromGeo (Coordinates coordinates) async {
    var addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = addresses.first;
    return first.featureName;
  }

}