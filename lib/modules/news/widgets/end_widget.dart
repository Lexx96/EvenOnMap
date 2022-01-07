import 'package:event_on_map/generated/l10n.dart';
import 'package:event_on_map/modules/news/models/news.dart';
import 'package:event_on_map/utils/custom_icons/custom_icons.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

/// Виджет вывода в карточку события нижней панели и кнопки 'Like', 'Share'
class EndWidget extends StatelessWidget {
  final GetNewsFromServerModel _newsResponse;

  EndWidget(this._newsResponse);

  @override
  Widget build(BuildContext context) {
    final _lengthDescription = _newsResponse.description.length / 2;

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
                    height: 30.0,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: const Icon(
                            CustomIcons.heart_1,
                          ),
                        ),
                        const Text(' 0   '),
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
${_newsResponse.description.substring(0, _lengthDescription.toInt())}...\n\n${S.of(context).moreInformationEventOnMap}'''),
              child: Icon(
                Icons.share,
                color: Theme.of(context).iconTheme.color,
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.transparent),
                elevation: MaterialStateProperty.all(0),
                padding: MaterialStateProperty.all(EdgeInsets.zero),
                minimumSize: MaterialStateProperty.all(Size(60, 30)),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                      side: BorderSide(color: Colors.transparent)),
                ),
              ),
            ),
          ],
        ),
        Divider()
      ],
    );
  }

  void _showMessage(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Center(
              child: Text(
            '''Функция оценки событий находится в разработке. 
        
И в настоящее время не доступна. \n\nПриносим извинения за неудоства.''',
          )),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text(S.of(context).ok)),
              ],
            ),
          ],
        );
      },
    );
  }
}
