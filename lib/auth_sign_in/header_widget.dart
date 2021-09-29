import 'package:event_on_map/generated/l10n.dart';
import 'package:flutter/material.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 10 * 1,
          ),
          Text(S.of(context).enterTheNumber,
            style: TextStyle(fontSize: 45, color: Colors.green),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 10 * 1,
          ),
        ],
      ),
    );
  }
}