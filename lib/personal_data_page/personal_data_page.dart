import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/*
добавить изминение авы

 */
class PersonalDataPage extends StatefulWidget {
  const PersonalDataPage({Key? key}) : super(key: key);

  @override
  _PersonalDataPageState createState() => _PersonalDataPageState();
}

class _PersonalDataPageState extends State<PersonalDataPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height / 10 * 3,
                width: double.infinity,
                color: Colors.blue,
              ),
              Container(
                height: MediaQuery.of(context).size.height / 10 * 7,
                width: double.infinity,
                color: Colors.grey[300],
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(left: 16, right: 16, top: 16),
            child: ListView(
              children: [
                HeaderPagesWidget(),
                LikesRowWidget(),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Основная информация:',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                ContactInformationWidget(),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Подробная информация:',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                DetailedInformationWidget(),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class HeaderPagesWidget extends StatelessWidget {
  const HeaderPagesWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundImage: AssetImage('images/mapOne.png'),
              radius: 40,
            ),
            SizedBox(
              width: 35,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Имя Фамилия',
                  style: TextStyle(
                      fontSize: 22,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  'Статус',
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.blue,
                      fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    Text(
                      'когда был в сети',
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold),
                    ),
                    Icon(
                      Icons.phone_android,
                      size: 14,
                      color: Colors.grey,
                    )
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class LikesRowWidget extends StatelessWidget {
  const LikesRowWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: ListView(scrollDirection: Axis.horizontal, children: [
        SizedBox(
          width: 20,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(width: 20,),
            TextButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.white),
                  foregroundColor: MaterialStateProperty.all(Colors.blue),
                  overlayColor: MaterialStateProperty.all(Colors.grey),
                  shadowColor: MaterialStateProperty.all(Colors.grey),
                  elevation: MaterialStateProperty.all(5),
                  padding: MaterialStateProperty.all(EdgeInsets.all(25)),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  )),
                  alignment: Alignment.topCenter),
              onPressed: () {},
              child: Text('Мои лайки'),
            ),
            SizedBox(width: 20,),
            TextButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.white),
                  foregroundColor: MaterialStateProperty.all(Colors.blue),
                  overlayColor: MaterialStateProperty.all(Colors.grey),
                  shadowColor: MaterialStateProperty.all(Colors.grey),
                  elevation: MaterialStateProperty.all(5),
                  padding: MaterialStateProperty.all(EdgeInsets.all(25)),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  )),
                  alignment: Alignment.topCenter),
              onPressed: () {},
              child: Text('Коментарии'),
            ),
            SizedBox(width: 20,),
            TextButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.white),
                  foregroundColor: MaterialStateProperty.all(Colors.blue),
                  overlayColor: MaterialStateProperty.all(Colors.grey),
                  shadowColor: MaterialStateProperty.all(Colors.grey),
                  elevation: MaterialStateProperty.all(5),
                  padding: MaterialStateProperty.all(EdgeInsets.all(25)),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  )),
                  alignment: Alignment.topCenter),
              onPressed: () {},
              child: Text('Мои ответы'),
            ),
          ],
        ),
        SizedBox(
          width: 20,
        ),
      ]),
    );
  }
}

class ContactInformationWidget extends StatelessWidget {
  const ContactInformationWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 15,
            ),
            SwitchPrivateInformationWidgetState(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 15),
                Divider(
                  height: 1,
                  color: Colors.grey,
                ),
                SizedBox(height: 15),
                Text(
                  'Родной город',
                  style: TextStyle(color: Colors.black54, fontSize: 14),
                ),
                TextButton(
                    onPressed: () {},
                    child: Text(
                      'Переменная с названием города',
                      style: TextStyle(fontSize: 15, color: Colors.black),
                    )),
                Divider(
                  height: 1,
                  color: Colors.grey,
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Контакты',
                  style: TextStyle(color: Colors.black54, fontSize: 14),
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                    SizedBox(height: 15),
                    Icon(
                      Icons.phone,
                      color: Colors.green,
                      size: 24,
                    ),
                    SizedBox(width: 15),
                    Text(
                      '8-913-432-20-00',
                      style: TextStyle(color: Colors.black, fontSize: 15),
                    ),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(height: 30),
                    Icon(
                      Icons.mail_outline,
                      color: Colors.green,
                      size: 24,
                    ),
                    SizedBox(width: 15),
                    Text(
                      'gtagaev96@mail.ru',
                      style: TextStyle(color: Colors.black, fontSize: 15),
                    ),
                  ],
                ),
                SizedBox(height: 15),
                Divider(
                  height: 1,
                  color: Colors.grey,
                ),
                SizedBox(height: 15),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class DetailedInformationWidget extends StatelessWidget {
  const DetailedInformationWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 15,
            ),
            SwitchPrivateAdditionalInformationWidget(),
            Divider(
              height: 1,
              color: Colors.grey,
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Text(
                  'Город прибывания:',
                  style: TextStyle(color: Colors.black54, fontSize: 14),
                ),
                SizedBox(width: 15),
              ],
            ),
            Row(
              children: [
                Icon(
                  Icons.home,
                  color: Colors.green,
                  size: 24,
                ),
                TextButton(
                  onPressed: () {},
                  child: Expanded(
                    child: Text(
                      'Город прибывания: название города',
                      style: TextStyle(color: Colors.black54, fontSize: 14),
                    ),
                  ),
                ),
              ],
            ),
            Divider(
              height: 1,
              color: Colors.grey,
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              children: [
                SizedBox(
                  height: 15,
                ),
                Text(
                  'Образование:',
                  style: TextStyle(color: Colors.black54, fontSize: 14),
                ),
                SizedBox(width: 15),
              ],
            ),
            Row(
              children: [
                Icon(
                  Icons.home_work_outlined,
                  color: Colors.green,
                  size: 24,
                ),
                TextButton(
                  onPressed: () {},
                  child: Expanded(
                    child: Text(
                      'Название учебного заведения',
                      style: TextStyle(color: Colors.black54, fontSize: 14),
                    ),
                  ),
                ),
              ],
            ),
            Divider(
              height: 1,
              color: Colors.grey,
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              children: [
                SizedBox(
                  height: 15,
                ),
                Text(
                  'О себе:',
                  style: TextStyle(color: Colors.black54, fontSize: 14),
                ),
                SizedBox(width: 15),
              ],
            ),
            Row(
              children: [
                Icon(
                  Icons.home,
                  color: Colors.green,
                  size: 24,
                ),
                TextButton(
                  onPressed: () {},
                  child: Expanded(
                    child: Text(
                      'Информация о себе в свободной форме',
                      style: TextStyle(color: Colors.black54, fontSize: 14),
                    ),
                  ),
                ),
              ],
            ),
            Divider(
              height: 1,
              color: Colors.grey,
            ),
            SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }
}

class SwitchPrivateInformationWidgetState extends StatefulWidget {
  const SwitchPrivateInformationWidgetState({Key? key}) : super(key: key);

  @override
  _SwitchPrivateInformationWidgetState createState() =>
      _SwitchPrivateInformationWidgetState();
}

class _SwitchPrivateInformationWidgetState
    extends State<SwitchPrivateInformationWidgetState> {
  bool status = true;
  String _showPrivateInformation = '';

  String _switchPrivateInformation(bool newValue) {
    if (newValue == true) {
      return _showPrivateInformation = 'Доступна всем';
    } else {
      return _showPrivateInformation = 'Приватна';
    }
  }

  @override
  // что то не так
  void initState() {
    _switchPrivateInformation(status);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '$_showPrivateInformation',
          style: TextStyle(fontSize: 15, color: Colors.black),
        ),
        Switch(
          activeColor: Colors.blue,
          splashRadius: 20,
          value: status,
          onChanged: (bool newValue) {
            _switchPrivateInformation(newValue);
            setState(() {
              status = newValue;
            });
          },
        ),
      ],
    );
  }
}

class SwitchPrivateAdditionalInformationWidget extends StatefulWidget {
  const SwitchPrivateAdditionalInformationWidget({Key? key}) : super(key: key);

  @override
  _SwitchPrivateAdditionalInformationWidgetState createState() =>
      _SwitchPrivateAdditionalInformationWidgetState();
}

class _SwitchPrivateAdditionalInformationWidgetState
    extends State<SwitchPrivateAdditionalInformationWidget> {
  bool _status = true;
  String _showPrivateInformation = '';

  String _switchPrivateInformation(bool newValue) {
    if (newValue == true) {
      return _showPrivateInformation = 'Доступна всем';
    } else {
      return _showPrivateInformation = 'Приватна';
    }
  }

  @override
  // что то не так
  void initState() {
    _switchPrivateInformation(_status);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '$_showPrivateInformation',
          style: TextStyle(fontSize: 15, color: Colors.black),
        ),
        Switch(
          activeColor: Colors.blue,
          splashRadius: 20,
          value: _status,
          onChanged: (bool newValue) {
            _switchPrivateInformation(newValue);
            setState(() {
              _status = newValue;
            });
          },
        ),
      ],
    );
  }
}
