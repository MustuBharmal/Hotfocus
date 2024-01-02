import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:waterfall_flow/waterfall_flow.dart';

import '../../widgets/custom_single_post.dart';
import '../core/utils/size_utils.dart';
import 'custom_build_progress_indicator_widget.dart';

class FeedPostWidget extends StatefulWidget {
  const FeedPostWidget({super.key});

  @override
  State<FeedPostWidget> createState() => _FeedPostWidgetState();
}

class _FeedPostWidgetState extends State<FeedPostWidget> {
  final _scrollController = ScrollController();
  bool _hasMore = true;
  bool _isLoading = false;
  final List<DocumentSnapshot> _data = [];
  int _perPage = 10;

  Future<void> _getData() async {
    QuerySnapshot querySnapshot;
    if (_data.isEmpty) {
      querySnapshot = await FirebaseFirestore.instance
          .collection('posts')
          .orderBy('datePublished', descending: true)
          .limit(_perPage)
          .get();
    } else {
      DocumentSnapshot lastDocument = _data[_data.length - 1];
      querySnapshot = await FirebaseFirestore.instance
          .collection('posts')
          .orderBy('datePublished', descending: true)
          .startAfterDocument(lastDocument)
          .limit(_perPage)
          .get();
    }

    // if (querySnapshot.size < _perPage) {
    //   setState(() {
    //     _hasMore = false;
    //   });
    // }

    setState(() {
      _data.addAll(querySnapshot.docs);
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _getData();
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.removeListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      // Reach the bottom of the list
      _getData();
      setState(() {
        _perPage = _perPage + 25;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
        child: SizedBox(
          height: size.height,
          child: WaterfallFlow.builder(
            controller: _scrollController,
            itemCount: _data.length + (_hasMore ? 1 : 0),
            gridDelegate:
                const SliverWaterfallFlowDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 4.0,
              crossAxisSpacing: 4.0,
            ),
            itemBuilder: (BuildContext context, int index) {
              if (index == _data.length) {
                return const CustomProgressIndicator();
              } else {
                return Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: PostItem(true, _data[index].data(), index, _data),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
