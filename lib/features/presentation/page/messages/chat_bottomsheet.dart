import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

chat(BuildContext context) {
  showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Container(
          color: Color(0xffF1F1F1),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              height: 280,
              child: Column(
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
                  SheetItems(
                    image: 'camera',
                    text: 'Camera',
                  ),
                  SheetItems(
                    image: 'add_image',
                    text: 'Image',
                  ),
                  SheetItems(
                    image: 'add_contacts',
                    text: 'Contacts',
                  ),
                  SheetItems(
                    image: 'feed',
                    text: 'Documents',
                  ),
                ],
              ),
            ),
          ),
        );
      });
}

class SheetItems extends StatelessWidget {
  final String image;
  final String text;
  const SheetItems({Key? key, required this.image, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SvgPicture.asset("assets/svgs/$image.svg"),
                  SizedBox(width: 20),
                  Text(
                    text,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontFamily: 'Proxima Nova',
                      fontWeight: FontWeight.w400,
                    ),
                  )
                ],
              ),
            ),
            Divider(
              thickness: 1,
            )
          ],
        ),
      ),
    );
  }
}
