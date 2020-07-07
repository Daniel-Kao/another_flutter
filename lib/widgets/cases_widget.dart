import 'package:another_flutter/widgets/post_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:another_flutter/bloc/post/post_bloc.dart';

import 'bottom_loader.dart';

class CasesWidget extends StatefulWidget {
  const CasesWidget({Key key}) : super(key: key);

  @override
  _CasesWidgetState createState() => _CasesWidgetState();
}

class _CasesWidgetState extends State<CasesWidget> {
  final _scrollController = ScrollController();
  final _scrollThreshold = 200.0;
  PostBloc _postBloc;
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);

    _postBloc = BlocProvider.of<PostBloc>(context)..add(PostFetched());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostBloc, PostState>(
      builder: (context, state) {
        print(state);
        if (state is PostInitial) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is PostFailure) {
          return Center(
            child: Text('failed to fetch posts'),
          );
        }
        if (state is PostSuccess) {
          if (state.posts.isEmpty) {
            return Center(
              child: Text('no posts'),
            );
          }
          return ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return index >= state.posts.length
                  ? BottomLoader()
                  : PostWidget(post: state.posts[index]);
            },
            itemCount: state.hasReachedMax
                ? state.posts.length
                : state.posts.length + 1,
            controller: _scrollController,
          );
        }
        return null;
      },
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      _postBloc.add(PostFetched());
    }
  }
}
