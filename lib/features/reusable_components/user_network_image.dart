import 'package:flutter/material.dart';
import 'package:flutter_projects/core/extensions/theme_helper.dart';

class UserNetworkImage extends StatelessWidget {
  final String imageUrl;
  const UserNetworkImage(this.imageUrl,{Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //todo:error,loading,caching handle

    return ClipOval(
      child: imageUrl.isEmpty
          ? ColoredBox(color: context.theme.lightGrey,)
          : Image.network( imageUrl,
              errorBuilder: (context, error, stackTrace) {
                return ColoredBox(color: context.theme.lightGrey,);
              },
              loadingBuilder: (context, child, loadingProgress) {
                return ColoredBox(color: context.theme.lightGrey,);
              },
      ),
    );
  }
}
