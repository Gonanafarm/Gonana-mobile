import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gonana/features/presentation/widgets/posts_container.dart';

class Posts extends StatefulWidget {
  Posts({super.key});

  @override
  State<Posts> createState() => _PostsState();
}

class _PostsState extends State<Posts> {
  String imageLink =
      'https://www.google.com/url?sa=i&url=https%3A%2F%2Funsplash.com%2Fs%2Fphotos%2Fperson&psig=AOvVaw3_M9M0NF9N5tFroGTjleh2&ust=1683126565044000&source=images&cd=vfe&ved=0CBEQjRxqFwoTCJCT05r11v4CFQAAAAAdAAAAABAE';

  String imageFarmer =
      'https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.dreamstime.com%2Fphotos-images%2Fafrican-farmer.html&psig=AOvVaw1wEJCXi43o1rY42MdDrU8T&ust=1683282245984000&source=images&cd=vfe&ved=0CBEQjRxqFwoTCODM75a52_4CFQAAAAAdAAAAABAE';

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: PostsContainer(shareFunction: (){}),
          ),
          // PostsContainer(),
          // SizedBox(height: 200),
        ],
      ),
    );
  }
}
