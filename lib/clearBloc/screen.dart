import 'package:event_on_map/clearBloc/bloc.dart';
import 'package:event_on_map/clearBloc/repository.dart';
import 'package:event_on_map/clearBloc/states.dart';
import 'package:flutter/material.dart';

class ClearBloc extends StatefulWidget {
  const ClearBloc({Key? key}) : super(key: key);

  @override
  _ClearBlocState createState() => _ClearBlocState(ClearRepository());
}

class _ClearBlocState extends State<ClearBloc> {
  _ClearBlocState(this._clearRepository);

  late ServiceClearBloc _clearBloc;
  late ClearRepository _clearRepository;

  @override
  void initState() {
    _clearBloc = ServiceClearBloc(_clearRepository);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 100),
          ElevatedButton(
            onPressed: () {
              _clearBloc.loading('79132948017', '12345');
            },
            child: Text('Загрузить')
          ),
          StreamBuilder(
            stream: _clearBloc.streamGetter,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.data is ClearBlocLoading) {
                return Text('ЗАГРУЗКА...');
              }
              if (snapshot.data is ClearBlocLoaded) {
                return Text('Данные успешно загружены...');
              }
              if (snapshot.data is ClearBlocError) {
                return Text('Ошибка регистрации');
              }
              if (snapshot.data is ClearBlocResponse) {
                var response = snapshot.data as ClearBlocResponse;
                return Text(response.responseText);
              }
              return Text('Нет состояния');
            },
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _clearBloc.dispose();
    super.dispose();
  }
}
