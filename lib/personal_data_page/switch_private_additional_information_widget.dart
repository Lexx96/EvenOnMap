import 'package:flutter/material.dart';

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
