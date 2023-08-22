import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty_app/models.dart/location_model.dart';
import 'package:rick_and_morty_app/views/locationInformation/locationInformation_controller.dart';

import '../../services/services.dart';
import '../../utils/generateLength.dart';

class LocationsController with ChangeNotifier, DiagnosticableTreeMixin {
  List<LocationModel> locations = [];
  List<LocationModel> locationsFinder = [];
  int locationsLength = 126;
  int start = 1;
  int end = 5;
  bool enableShowMoreButton = true;

  Future<List<LocationModel>> consultLocations() async {
    String length = generateLength(start, end);
    locations = await Services().getLocations(length);

    return locations;
  }

  Future<List<LocationModel>> consultFinder() async {
    String length = generateLength(start, end);
    locationsFinder = await Services().getLocations(length);

    return locationsFinder;
  }

  Future showMore() async {
    if (end + 5 <= locationsLength - 5) {
      start = end + 1;
      end = start + 4;
    } else {
      start = end + 1;
      end = locationsLength - end;
      enableShowMoreButton = false;
    }
    String length = generateLength(start, end);
    List<LocationModel> locationsList = await Services().getLocations(length);

    locations.addAll(locationsList);
    notifyListeners();
  }

  openLocationInformation(BuildContext context, LocationModel location) {
    context.read<LocationInformationController>().updateLocation(location);
    //go to screen
    Navigator.pushNamed(context, '/locationInformation');
  }

  restartVariables() {
    start = 0;
    end = 5;
  }
}
