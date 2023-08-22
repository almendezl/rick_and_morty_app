import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty_app/styles/colors.dart';
import 'package:rick_and_morty_app/styles/textStyles.dart';

import '../../../data/homeItems.dart';
import 'bottomNavigation_controller.dart';

class BottomNavigationView extends StatelessWidget {
  const BottomNavigationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widgetOptions.elementAt(context.watch<BottomNavigationController>().selectedItem),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(color: white, border: Border(top: BorderSide(color: baseBlue, width: 1.5))),
        child: BottomNavigationBar(
          items: items,
          currentIndex: context.watch<BottomNavigationController>().selectedItem,
          onTap: context.read<BottomNavigationController>().updateIndex,
          unselectedItemColor: grey,
          selectedItemColor: baseBlue,
          showUnselectedLabels: true,
          elevation: 0.0,
          type: BottomNavigationBarType.fixed,
          selectedLabelStyle: selectedItemHome,
          unselectedLabelStyle: unselectedItemHome,
        ),
      ),
    );
  }
}
