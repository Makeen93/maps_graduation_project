import 'package:get/get.dart';
import 'package:maps_graduation_project/features/home/PL/screens/search_screen.dart';

import '../../../../app_bindings.dart';
import '../../../../routes/app_routes.dart';

class SearchPage extends GetPage {
  SearchPage()
      : super(
            name: AppRouter.search,
            page: () => const SearchScreen(),
            binding: AppBinding());
}
