import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:gonana/consts.dart';
import 'package:gonana/features/controllers/auth/notification_controller.dart';

class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  late Future<bool> fetchData;
  NotificationController notificationController =
      Get.put(NotificationController());

  @override
  void initState() {
    fetchData = notificationController.fetchNotification();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: fetchData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              color: Colors.white,
              child: Center(
                child: Container(
                  height: 75,
                  width: 75,
                  child: CircularProgressIndicator(
                    color: Color.fromRGBO(41, 132, 75, 1),
                  ),
                ),
              ),
            );
            // Show a loading indicator while waiting
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (!snapshot.data!) {
            return Container(
              color: Colors.white,
              child: const Center(
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    'No network connection. Please check your internet connection.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            );
          } else {
            return Scaffold(
                backgroundColor: const Color(0xffF1F1F1),
                appBar: AppBar(
                  backgroundColor: const Color(0xffF1F1F1),
                  elevation: 0,
                  leading: IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                        size: 20,
                        color: Color(0xff292D32),
                      )),
                ),
                body: SafeArea(
                    child: ListView(children: [
                  const Padding(
                    padding: EdgeInsets.all(20.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: Text(
                        'Notifications',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  Container(
                      height: MediaQuery.of(context).size.height * 0.8,
                      child: notificationController
                                      .notificationModel.value.data ==
                                  null ||
                              notificationController
                                  .notificationModel.value.data!.isEmpty
                          ? Padding(
                              padding: EdgeInsets.only(
                                  bottom:
                                      MediaQuery.of(context).size.height * 0.3),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  sizeVer(
                                      MediaQuery.of(context).size.height * 0.1),
                                  SvgPicture.asset(
                                    "assets/svgs/empty_product.svg",
                                    width: 189.71,
                                    height: 156.03,
                                  ),
                                  const Text(
                                    'Sorry! no notifications yet',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 24,
                                      fontFamily: 'Proxima Nova',
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const Text(
                                    'All notifications will be visible here',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontFamily: 'Proxima Nova',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : ListView.builder(
                              itemCount: notificationController
                                      .notificationModel.value.data?.length ??
                                  0,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 8, 20, 8),
                                  child: ListTile(
                                    tileColor: Colors.white,
                                    leading: const Icon(
                                      Icons.notifications_outlined,
                                      size: 40,
                                      color: greenColor,
                                    ),
                                    title: Text(
                                      notificationController.notificationModel
                                              .value.data?[index].body ??
                                          "N/a",
                                      style: const TextStyle(
                                        color: greenColor,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    // subtitle: const Text(
                                    //   '500,000 GNX bought with NGN 500,000',
                                    //   style: TextStyle(
                                    //     fontSize: 10,
                                    //     fontWeight: FontWeight.w400,
                                    //   ),
                                    // ),
                                    // trailing: const Text('Jan 25')
                                  ),
                                );
                              }))
                ])));
          }
        });
  }
}
