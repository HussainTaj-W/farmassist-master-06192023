import 'dart:async';

import 'package:farmassist/data/farm/resources/repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'nEvent.dart';
import 'nState.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final Repository repository;

  NewsBloc({required this.repository}) : super(Loading());

  NewsState get initialState => Loading();

  Stream<NewsState> mapEventToState(NewsEvent event) async* {
    if (event is Fetch) {
      try {
        yield Loading();
        final items = await repository.fetchAllNews(category: event.category);
        yield Loaded(items: items, type: event.category);
      } catch (_) {
        yield Failure();
      }
    }
  }
}
