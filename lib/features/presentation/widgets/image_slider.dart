import 'package:flutter/material.dart';
import 'package:gonana/features/data/models/post_model.dart';

import '../../../../../consts.dart';

class ImageSlider extends StatefulWidget {
  final Datum imageProductModel;
  const ImageSlider({super.key, required this.imageProductModel});

  @override
  State<ImageSlider> createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {
  int _currentPage = 0;
  PageController _pageController = PageController(initialPage: 0);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Stack(
        children: [
          PageView.builder(
            itemCount: widget.imageProductModel!.product!.images!.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                  width: 115,
                  height: 103,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    // image: const DecorationImage(
                    //   image: AssetImage('assets/images/image 4.png'),
                    //   fit: BoxFit.cover,
                    // ),
                  ),
                  child:
                      widget.imageProductModel!.product!.images![index] != null
                          ? Image.network(
                              widget.imageProductModel!.product!.images![index],
                              fit: BoxFit.cover,
                            )
                          : Image.asset("assets/images/female_farmer.png"));
            },
            onPageChanged: (int page) {
              setState(() {
                _currentPage = page;
              });
            },
            controller: _pageController,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color.fromRGBO(44, 44, 44, 0.6),
                ),
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios_new_outlined,
                    color: primaryColor,
                  ),
                  onPressed: () {
                    if (_currentPage > 0) {
                      _pageController.previousPage(
                        duration: Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                      );
                      setState(() {
                        _currentPage--;
                      });
                    }
                  },
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color.fromRGBO(44, 44, 44, 0.6),
                ),
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_forward_ios_outlined,
                    color: primaryColor,
                  ),
                  onPressed: () {
                    if (_currentPage < images.length - 1) {
                      _pageController.nextPage(
                        duration: Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                      );
                      setState(() {
                        _currentPage++;
                      });
                    }
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
