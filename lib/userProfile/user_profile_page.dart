
import 'package:event_on_map/userProfile/widgets/header_widget.dart';
import 'package:event_on_map/userProfile/widgets/horizontal_listview_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../main_driwer/main_drawer.dart';
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
                MainInformationWidget(),
                HorizontalListViewWidget(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}








