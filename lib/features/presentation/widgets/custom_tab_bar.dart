import 'package:flutter/material.dart';
import 'package:gonana/features/presentation/page/settings/settings_posts.dart';
import 'package:gonana/features/presentation/page/settings/settings_store.dart';

import '../page/settings/settings_details.dart';

class CustomTabBar extends StatelessWidget {
  const CustomTabBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 3,
      child: Container(
        // width: MediaQuery.of(context).size.width * 0.3,
        // height: MediaQuery.of(context).size.height * 0.9,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TabBar(
              indicatorColor: Color(0xff444444),
              indicatorSize: TabBarIndicatorSize.label,
              tabs: [
                Text(
                  'Post',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff444444)),
                ),
                Text(
                  'Profile',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff444444)),
                ),
                Text(
                  'The Store',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff444444)),
                ),
              ],
            ),
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.9,
              child: TabBarView(
                children: [Posts(), MyDetails(), Store()],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
