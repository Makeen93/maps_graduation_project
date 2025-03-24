import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maps_graduation_project/features/product/PL/screens/search_screen.dart';

import '../../../../core/widgets/subtitle_text.dart';

class CategoryRoundedWidget extends StatelessWidget {
  const CategoryRoundedWidget({
    super.key,
    required this.image,
    required this.name,
  });

  final String image, name;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => SearchScreen(), arguments: name);
      },
      child: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              image,
              height: 50,
              width: 50,
            ),
            const SizedBox(
              height: 12,
            ),
            SubtitleTextWidget(
              label: name,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            )
          ],
        ),
      ),
    );
  }
}
