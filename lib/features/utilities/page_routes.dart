import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:gonana/features/presentation/page/home.dart';

class Routes {
  static String feeds = '/feeds';
}

final getPages = [
  GetPage(name: Routes.feeds, page: () => HomePage(navIndex: 2)),
];
