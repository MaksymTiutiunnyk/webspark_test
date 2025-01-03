import 'package:flutter_bloc/flutter_bloc.dart';

class UrlCubit extends Cubit<String> {
  UrlCubit() : super('');

  void setUrl(String url) {
    emit(url);
  }
}
