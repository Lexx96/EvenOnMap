
import 'package:event_on_map/userProfile/widgets/header_widget.dart';
import 'package:event_on_map/userProfile/widgets/horizontal_listview_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../main_drawer.dart';
import 'bloc/user_profile_image_bloc.dart';
import 'widgets/main_information.dart';

/*
сделать разные геттеры???
 */

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({Key? key}) : super(key: key);

  @override
  UserProfilePageState createState() => UserProfilePageState();
}

class UserProfilePageState extends State<UserProfilePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: MainDrawer(),
      body: Container(
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            Column(
              children: [
                UserProfileHeaderWidget(),
                // Padding(
                //   padding: const EdgeInsets.only(
                //       left: 16, right: 16, bottom: 10),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceAround,
                //     children: [
                //       Column(
                //         children: [
                //           IconButton(
                //             onPressed: () {},
                //             icon: Icon(
                //               Icons.photo_camera,
                //               size: 45,
                //               color: Colors.blue[200],
                //             ),
                //           ),
                //           Text(
                //             '   ' + S.of(context).history,
                //             style: TextStyle(
                //                 color: Colors.blue, fontSize: 16),
                //           )
                //         ],
                //       ),
                //       Column(
                //         children: [
                //           IconButton(
                //             onPressed: () {},
                //             icon: Icon(
                //               Icons.photo_camera,
                //               size: 45,
                //               color: Colors.blue[200],
                //             ),
                //           ),
                //           Text(
                //             '   ' + S.of(context).record,
                //             style: const TextStyle(
                //                 color: Colors.blue, fontSize: 16),
                //           )
                //         ],
                //       ),
                //       Column(
                //         children: [
                //           IconButton(
                //             onPressed: () {},
                //             icon: Icon(
                //               Icons.photo_camera,
                //               size: 45,
                //               color: Colors.blue[200],
                //             ),
                //           ),
                //           Text(
                //             '   ' + S.of(context).photo,
                //             style: const TextStyle(
                //                 color: Colors.blue, fontSize: 16),
                //           )
                //         ],
                //       ),
                //       Column(
                //         children: [
                //           IconButton(
                //             onPressed: () {},
                //             icon: Icon(
                //               Icons.photo_camera,
                //               size: 45,
                //               color: Colors.blue[200],
                //             ),
                //           ),
                //           Text(
                //             '   ' + S.of(context).history,
                //             style: const TextStyle(
                //                 color: Colors.blue, fontSize: 16),
                //           )
                //         ],
                //       ),
                //     ],
                //   ),
                // ),
                MainInformationWidget(),
                HorizontalListViewWidget(),
                // SizedBox(
                //   child: Container(
                //     decoration: BoxDecoration(
                //         color: Colors.transparent,
                //         border: Border.all(
                //             color: Colors.black.withOpacity(0.9))),
                //     child: Column(
                //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //       children: [
                //         //const HeaderButtonWidget(),
                //         //TextBodyWidget(),
                //         const EndWidget(),
                //       ],
                //     ),
                //   ),
                // )
              ],
            ),
          ],
        ),
      ),
    );
  }
}








