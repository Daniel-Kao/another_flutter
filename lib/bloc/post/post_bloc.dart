import 'dart:async';

import 'package:another_flutter/models/post.dart';
import 'package:another_flutter/repositories/post_respository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc() : super(PostInitial());

  @override
  Stream<Transition<PostEvent, PostState>> transformEvents(
    Stream<PostEvent> events,
    TransitionFunction<PostEvent, PostState> transitionFn,
  ) {
    return super.transformEvents(
      events.debounceTime(const Duration(milliseconds: 500)),
      transitionFn,
    );
  }

  @override
  Stream<PostState> mapEventToState(PostEvent event) async* {
    final currentState = state;

    if (event is PostFetched && !_hasReachedMax(currentState)) {
      try {
        if (currentState is PostInitial) {
          final posts = await PostRepository.getPosts(0, 20);
          print(posts);
          yield PostSuccess(posts: posts, hasReachedMax: false);
          return;
        }
        if (currentState is PostSuccess) {
          final posts =
              await PostRepository.getPosts(currentState.posts.length, 20);
          yield posts.isEmpty
              ? currentState.copyWith(
                  hasReachedMax: true,
                )
              : PostSuccess(
                  posts: currentState.posts + posts,
                  hasReachedMax: false,
                );
        }
      } catch (_) {
        yield PostFailure();
      }
    }
  }

  bool _hasReachedMax(PostState state) =>
      state is PostSuccess && state.hasReachedMax;
}
