import 'package:event_on_map/generated/l10n.dart';
import 'package:event_on_map/main_screen/main_screen_widget.dart';
import 'package:event_on_map/userProfile/services/user_profile__image_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'bloc/change_personal_data_page_bloc.dart';
import 'bloc/change_personal_data_page_state.dart';

class ChangePersonalDataPage extends StatefulWidget {
  ChangePersonalDataPage({Key? key}) : super(key: key);

  @override
  State<ChangePersonalDataPage> createState() => _ChangePersonalDataPageState();
}

class _ChangePersonalDataPageState extends State<ChangePersonalDataPage> {
  late ChangePersonalDataBloc _bloc;

  TextEditingController _nameController = TextEditingController();
  TextEditingController _surNameController = TextEditingController();
  TextEditingController _userCityController = TextEditingController();
  TextEditingController _aboutMeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _bloc = ChangePersonalDataBloc();
    _bloc.loadUserDataBloc();
  }

  @override
  void dispose() {
    super.dispose();
    _bloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MainScreen(
              indexPage: 2,
            ),
          ),
        );
        return false;
      },
      child: Scaffold(
        body: StreamBuilder(
            stream: _bloc.streamChangePersonalData,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              Map<String, String?> _userDataFromSharedPreferences = {};
              if (snapshot.data is LoadUserDataState) {
                final _data = snapshot.data as LoadUserDataState;
                _userDataFromSharedPreferences =
                    _data.userDataFromSharedPreferences;
                _nameController = TextEditingController(
                    text: _userDataFromSharedPreferences['userName']);
                _surNameController = TextEditingController(
                    text: _userDataFromSharedPreferences['userSurname']);
                _userCityController = TextEditingController(
                    text: _userDataFromSharedPreferences['userCity']);
                _aboutMeController = TextEditingController(
                    text: _userDataFromSharedPreferences['aboutMe']);
              }
              return Container(
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 16.0, right: 16.0, top: 20.0),
                  child: ListView(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5.0),
                            child: Text(S.of(context).name),
                          ),
                          TextField(
                            controller: _nameController,
                            maxLength: 50,
                            decoration: InputDecoration(
                              hintText: 'Ведите имя',
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5.0),
                            child: Text(S.of(context).surname),
                          ),
                          TextField(
                            maxLength: 50,
                            controller: _surNameController,
                            decoration: InputDecoration(
                              hintText: 'Ведите фамилию',
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5.0),
                            child: Text(S.of(context).city),
                          ),
                          TextField(
                            maxLength: 50,
                            controller: _userCityController,
                            decoration: InputDecoration(
                              hintText: 'Город',
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5.0),
                            child: Text(S.of(context).aboutMe),
                          ),
                          TextField(
                            maxLines: DefaultTextStyle.of(context).maxLines,
                            minLines: 10,
                            maxLength: 1500,
                            controller: _aboutMeController,
                            decoration: InputDecoration(
                              hintText: 'Расскажите о себе',
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              onPressed: () {
                UserProfileProvider().saveUserDataInSharedPreferences(
                    name: _nameController.text,
                    surName: _surNameController.text,
                    city: _userCityController.text,
                    aboutMe: _aboutMeController.text);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MainScreen(
                      indexPage: 2,
                    ),
                  ),
                );
              },
              child: Text(
                S.of(context).save,
                style: const TextStyle(fontSize: 17),
              ),
            ),
            SizedBox(
              width: 20,
            ),
            TextButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MainScreen(
                    indexPage: 2,
                  ),
                ),
              ),
              child: Text(
                S.of(context).back,
                style: const TextStyle(fontSize: 17),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
