import 'package:flutter/material.dart';

class SwitchPrivateInformationWidget extends StatefulWidget {
  const SwitchPrivateInformationWidget({Key? key}) : super(key: key);

  @override
  _SwitchPrivateInformationWidgetState createState() =>
      _SwitchPrivateInformationWidgetState();
}

class _SwitchPrivateInformationWidgetState
    extends State<SwitchPrivateInformationWidget> {
  bool status = true;
  String _showPrivateInformation = '';

  String _switchPrivateInformation(bool newValue) {
    if (newValue) {
      return _showPrivateInformation = 'dd'; //S.of(context).availableToEveryone
    } else {
      return _showPrivateInformation = 'cc'; //S.of(context).private
    }
  }

  @override
  void initState() {
    super.initState();
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