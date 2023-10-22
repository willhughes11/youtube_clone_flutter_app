import 'package:flutter/material.dart';
import 'package:youtube_clone_flutter_app/utils/colors.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  
  const HomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: customBlack.shade900,
      leading: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: const EdgeInsets.all(12.0),
            child: Image.asset(
              'assets/images/youtube-logo-white-text.png',
              width: 100,
            ),
          )
        ],
      ),
      leadingWidth: 200,
      actions: <Widget>[
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.search),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.account_circle),
        )
      ],
    );
  }
}
