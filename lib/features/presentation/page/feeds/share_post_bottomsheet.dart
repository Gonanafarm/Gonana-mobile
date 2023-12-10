import 'package:flutter/material.dart';
import 'package:gonana/features/presentation/widgets/widgets.dart';
import 'package:provider/provider.dart';

import '../../../../deep_link_block.dart';

sharePost(BuildContext context) {
  DeepLinkBloc _bloc = Provider.of<DeepLinkBloc>(context, listen: false);
  showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Container(
            height: MediaQuery.of(context).size.height * 0.3,
            color: const Color(0xffF1F1F1),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24.0, 0.0, 24.0, 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.close, color: Colors.black),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                  Expanded(
                    // height: MediaQuery.of(context).size.height * 0.65,
                    child: ListView(
                      children: [
                        const Text('Share Post',
                            style: TextStyle(
                              fontSize: 24,
                              color: Color(0xff000000),
                              fontWeight: FontWeight.w600,
                            ),
                            textAlign: TextAlign.left),
                        // Padding(
                        //   padding: const EdgeInsets.symmetric(
                        //       horizontal: 0.0, vertical: 10),
                        //   child: Container(
                        //     decoration: BoxDecoration(
                        //       border: Border.all(
                        //         color: Colors.grey,
                        //       ),
                        //     ),
                        //     child: Row(
                        //       children: [
                        //         Flexible(
                        //           flex: 5,
                        //           child: Padding(
                        //             padding: const EdgeInsets.only(left: 10.0),
                        //             child: TextField(
                        //               autofocus: false,
                        //               decoration: const InputDecoration(
                        //                   border: InputBorder.none,
                        //                   hintText: "Type here to search",
                        //                   hintStyle: TextStyle(
                        //                       color: Color(0xff444444),
                        //                       fontSize: 14,
                        //                       fontWeight: FontWeight.w400)),
                        //             ),
                        //           ),
                        //         ),
                        //         Flexible(
                        //             flex: 1,
                        //             child: IconButton(
                        //                 onPressed: () {},
                        //                 icon: Icon(Icons.search)))
                        //       ],
                        //     ),
                        //   ),
                        // ),
                        Divider(thickness: 1),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: ActionContainers(
                              leading: "Copy Link",
                              trailing: IconButton(
                                onPressed: () {
                                  StreamBuilder<String>(
                                    stream: _bloc.state,
                                    builder: (context, snapshot) {
                                      if (!snapshot.hasData) {
                                        return Container(
                                            child: Center(
                                                child: Text(
                                                    'Error in generating link')));
                                      } else {
                                        return Container(
                                            child: Center(
                                                child: Padding(
                                                    padding:
                                                        EdgeInsets.all(20.0),
                                                    child: Text(
                                                        'Redirected: ${snapshot.data}'))));
                                      }
                                    },
                                  );
                                },
                                icon: Icon(Icons.copy),
                              )),
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.only(bottom: 10.0),
                        //   child: ActionContainers(
                        //       leading: "Share to your story",
                        //       trailing: IconButton(
                        //         onPressed: () {},
                        //         icon: Icon(Icons.arrow_forward_ios),
                        //       )),
                        // ),
                        // Divider(thickness: 1),
                        // Container(
                        //   color: const Color(0xffFFFFFF),
                        //   height: MediaQuery.of(context).size.height * 0.3,
                        //   child: Padding(
                        //     padding: const EdgeInsets.all(8.0),
                        //     child: ListView(
                        //       // crossAxisAlignment: CrossAxisAlignment.start,
                        //       children: [
                        //         Text(
                        //           'Friends suggestions',
                        //           style: TextStyle(
                        //             fontSize: 18,
                        //             fontWeight: FontWeight.w600,
                        //           ),
                        //         ),
                        //         FriendsTile(
                        //           image: 'story_profile_photo',
                        //           title: 'Jake Doe',
                        //           subtitle: 'Poultry farmer',
                        //         ),
                        //         SizedBox(height: 10),
                        //         FriendsTile(
                        //           image: 'john_david_photo',
                        //           title: 'Madam Loe',
                        //           subtitle: 'Poultry farmer',
                        //         ),
                        //         FriendsTile(
                        //           image: 'story_profile_photo',
                        //           title: 'Jake Doe',
                        //           subtitle: 'Poultry farmer',
                        //         ),
                        //       ],
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                  // Center(
                  //     child:
                  //         LongGradientButton(title: "Share", onPressed: () {}))
                ],
              ),
            ));
      });
}

class ActionContainers extends StatelessWidget {
  final String leading;
  final IconButton trailing;
  const ActionContainers(
      {Key? key, required this.leading, required this.trailing})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: const Color(0xffFFFFFF),
        ),
        child: ListTile(
          leading: Text(leading,
              style: TextStyle(
                  color: Color(0xff000000),
                  fontSize: 18,
                  fontWeight: FontWeight.w600)),
          trailing: trailing,
        ));
  }
}

class FriendsTile extends StatelessWidget {
  final String image;
  final String title;
  final String subtitle;
  const FriendsTile(
      {Key? key,
      required this.image,
      required this.title,
      required this.subtitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Container(
              height: 14,
              width: 14,
              decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(color: Colors.black)),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.7,
            child: ListTile(
              visualDensity: VisualDensity(vertical: -4, horizontal: -4),
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                    fit: BoxFit.cover,
                    height: 30,
                    width: 30,
                    "assets/images/$image.png"),
              ),
              title: Text(title,
                  style: TextStyle(
                      color: Color(0xff000000),
                      fontSize: 16,
                      fontWeight: FontWeight.w600)),
              subtitle: Text(subtitle,
                  style: TextStyle(
                      color: Color(0xff000000),
                      fontSize: 14,
                      fontWeight: FontWeight.w400)),
            ),
          ),
        ],
      ),
    );
  }
}
