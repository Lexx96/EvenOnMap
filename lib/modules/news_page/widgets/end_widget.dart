import 'package:event_on_map/modules/news_page/models/news.dart';
import 'package:event_on_map/utils/custom_icons/custom_icons.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class EndWidget extends StatelessWidget {
  final GetNewsFromServerModel _newsResponse;
   EndWidget(this._newsResponse);

  @override
  Widget build(BuildContext context) {
    final lengthDescription = _newsResponse.description.length/2;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  child: Container(
                    height: 30,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Icon(
                            CustomIcons.heart_1,
                          ),
                        ),
                        Text(
                          ' 0   ',
                        ),
                      ],
                    ),
                    clipBehavior: Clip.hardEdge,
                  ),
                  onTap: () => _showMessage(context),
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                  splashColor: Theme.of(context).splashColor,
                ),
              ),
            ),
            TextButton(
              onPressed: () => Share.share(''''${_newsResponse.title}...\n
${_newsResponse.description.substring(0, lengthDescription.toInt())  }...\n\nПодробнее в приложении Event On Map'''),  //https://www.youtube.com/watch?v=-PmUFbbA-Fs
              child: Icon(Icons.share, color: Theme.of(context).iconTheme.color,),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.transparent),
                elevation: MaterialStateProperty.all(0),
                padding: MaterialStateProperty.all(EdgeInsets.zero),
                minimumSize: MaterialStateProperty.all(Size(60, 30)),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                      side: BorderSide(color: Colors.transparent)
                  ),
                ),
              ),
            ),
          ],
        ),
        Divider()
      ],
    );
  }


  void _showMessage (BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Center(
                child: Text(
                  '''Лайки находятся в разработке. 
        
И в настоящее время не доступны. \n\nПриносим извинения за неудоства.''',
                )),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text('ОК')),
                ],
              ),
            ],
          );
        }
    );
  }
}