import 'package:flutter/foundation.dart';

class BottomNavigationController with ChangeNotifier, DiagnosticableTreeMixin {
  int selectedItem = 0;
  bool isNavigable = true;

  updateNavigable(bool state) {
    isNavigable = state;
    notifyListeners();
  }

  updateIndex(int index) {
    if (isNavigable) {
      selectedItem = index;
      notifyListeners();
    }
  }
}
