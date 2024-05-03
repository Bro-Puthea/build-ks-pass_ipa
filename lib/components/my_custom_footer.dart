import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:igt_e_pass_app/styles/my_text.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
class MyCustomFooter extends StatelessWidget {
  const MyCustomFooter({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
          textTheme: const TextTheme(bodyMedium: TextStyle(fontSize: 16))),
      child: CustomFooter(
        builder: (context, mode) {
          Widget body;
          if (mode == LoadStatus.idle) {
            body = const Text("Pull up load");
            body = Container();
          } else if (mode == LoadStatus.loading) {
            body = Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children:const  [
                 CupertinoActivityIndicator(
                  radius: 10,
                  color: Colors.white,
                ),
              ],
            );
          } else if (mode == LoadStatus.failed) {
            body = Text("Load failed!",style: MyText.body1(context));
          } else if (mode == LoadStatus.canLoading) {
            body = Text("Release to load more", style: MyText.body1(context));
          }else {
            body = Text('No more data', style: MyText.body1(context));
            body = Container();
          }
          return SizedBox(
            height: 55.0,
            child: Center(child: body),
          );
        },
      ),
    );
  }
}