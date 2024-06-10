import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomBar extends StatelessWidget {
  final int selected;
  final Function(int) onTap;
  const BottomBar({
    required this.onTap,
    required this.selected,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
            currentIndex: selected,
            onTap: onTap,
            items: [
              // BottomNavigationBarItem(
              //     icon: const Icon(Icons.edit),
              //     label: 'edit'.tr,
              //     tooltip: 'edit current month'.tr),
              BottomNavigationBarItem(
                  icon: const Icon(Icons.home),
                  label: 'home'.tr,
                  tooltip: 'home page'.tr),
              BottomNavigationBarItem(
                  icon: const Icon(Icons.feed_outlined),
                  label: 'history'.tr,
                  tooltip: 'data history'.tr)
            ],
          );
  }
}
