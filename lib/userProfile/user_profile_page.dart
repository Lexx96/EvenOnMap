
import 'package:event_on_map/bottom_navigation_bar/bottom_navigation_bar_widget.dart';
import 'package:event_on_map/generated/l10n.dart';
import 'package:event_on_map/navigation/main_navigation.dart';
import 'package:event_on_map/userProfile/widgets/header_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../main_driwer/main_drawer.dart';

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
                Padding(
                  padding:
                  const EdgeInsets.only(left: 16, right: 16, top: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextButton(
                          style: ButtonStyle(
                            minimumSize: MaterialStateProperty.all(Size(MediaQuery.of(context).size.width, 35)),
                          ),
                          onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil(
                              MainNavigationRouteName.changePersonalDataPage,  (route) => false),
                          child: Text(
                            S.of(context).edit,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 15),
                            Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.home,
                                      size: 24,
                                    ),
                                    SizedBox(width: 15),
                                    Text(S.of(context).city,
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ],
                                ),
                                Text(S.of(context).novokuznetsk,
                                  style: TextStyle(fontSize: 15),
                                ),
                              ],
                            ),
                            Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.phone,
                                      size: 24,
                                    ),
                                    SizedBox(width: 15),
                                    Text(S.of(context).phoneNumber,
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ],
                                ),
                                SizedBox(width: 15),
                                Text(
                                  '8-913-432-20-00',
                                  style: TextStyle(fontSize: 15),
                                ),
                              ],
                            ),
                            Divider(),
                            Row(
                              children: [
                                const Icon(
                                  Icons.work_outline,
                                  size: 24,
                                ),
                                const SizedBox(width: 15),
                                Text('О себе',
                                  style: TextStyle(fontSize: 14),
                                )
                              ],
                            ),
                            Divider(),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                              child: Text('Мои события'),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 360,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 10,
                    itemBuilder: (BuildContext context, int index) {
                      return Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0, left: 8.0, top: 8.0, bottom: 16.0,),
                            child: Column(
                              children: [
                                Container(
                                  height: 195,
                                  width: 90,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).scaffoldBackgroundColor,
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black,
                                          blurRadius: 8,
                                          offset: Offset(0, 2))
                                    ],
                                  ),
                                  clipBehavior: Clip.hardEdge,
                                  child: Stack(
                                    children: [
                                      Center(
                                        child: FlutterLogo(
                                          size: 100,
                                        ),
                                      ),
                                      Material(
                                        color: Colors.transparent,
                                        child: InkWell(
                                            borderRadius: BorderRadius.all(Radius.circular(10)),
                                            onTap: () {} //_showActions(context, index),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      // bottomNavigationBar: BottomNavigationBarWidget(),
    );
  }
}








