import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewsWidget extends StatelessWidget {
  const NewsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      itemCount: 10,
      itemExtent: 600,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          decoration: BoxDecoration(
              color: Colors.transparent,
              border: Border.all(color: Colors.black.withOpacity(0.9))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              HeaderButtonWidget(),
              TextBodyWidget(),
              EndWidget(),
            ],
          ),
        );
      },
    );
  }
}

class HeaderButtonWidget extends StatelessWidget {
  const HeaderButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              color: Colors.transparent,
              width: MediaQuery.of(context).size.width / 10 * 8,
              height: MediaQuery.of(context).size.height / 10 * 1,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  splashColor: Colors.red,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                      color: Colors.transparent,
                    ),
                    clipBehavior: Clip.hardEdge,
                    child: Center(
                      child: Row(
                        children: [
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CircleAvatar(
                                backgroundImage: AssetImage('images/mapOne.png'),
                                radius: 27,
                              ),
                            ),
                          ),
                          Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Ник пользователя',
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  '48 минут назад',
                                  style: TextStyle(fontSize: 12, color: Colors.grey),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 14),
              width: MediaQuery.of(context).size.width / 10 * 1,
              child: IconButton(
                  splashRadius: 20,
                  // радиус сплеша
                  highlightColor: Colors.grey,
                  // цвет который сразу появляется по нажатии кнопки
                  color: Colors.green,
                  // цвет иконки
                  splashColor: Colors.grey,
                  // цвет сплеша быстрого
                  iconSize: 30,
                  padding: EdgeInsets.all(0),
                  // регулирует обрасть splash
                  onPressed: () {
                    print('Правое меню');
                  },
                  icon: Icon(Icons.menu)),
            )
          ],
        ),
      ],
    );
  }
}

class TextBodyWidget extends StatelessWidget {
  const TextBodyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image(image: AssetImage('images/mapOne.png')),
    );
  }
}

class EndWidget extends StatelessWidget {
  const EndWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
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
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.all(
                        Radius.circular(25))
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Icon(Icons.volunteer_activism, color: Colors.black38,),
                    ),
                    Text(' 25  ', style: TextStyle(color: Colors.black38),),
                  ],
                ),
                clipBehavior: Clip.hardEdge,
              ),
              onTap: () => print('cc'),
              splashColor: Colors.green[300],
              borderRadius: BorderRadius.all(Radius.circular(25)),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              child: Container(
                height: 30,
                decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.all(
                        Radius.circular(25))
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Icon(Icons.messenger_outline, color: Colors.black38,),
                    ),
                    Text(' 25  ', style: TextStyle(color: Colors.black38),),
                  ],
                ),
                clipBehavior: Clip.hardEdge,
              ),
              onTap: () => print('cc'),
              splashColor: Colors.green[300],
              borderRadius: BorderRadius.all(Radius.circular(25)),
            ),
          ),
        ),
        SizedBox(width: 20,),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              child: Container(
                height: 30,
                decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.all(
                        Radius.circular(25))
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Icon(Icons.share, color: Colors.black38,),
                    ),
                    Text(' 25  ', style: TextStyle(color: Colors.black38),),
                  ],
                ),
                clipBehavior: Clip.hardEdge,
              ),
              onTap: () => print('cc'),
              splashColor: Colors.green[300],
              borderRadius: BorderRadius.all(Radius.circular(25)),
            ),
          ),
        ),
      ],
    );
  }
}
