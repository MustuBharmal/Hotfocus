import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../widgets/custom_single_post.dart';
import '/core/app_export.dart';

bool _visibility = false;
var uid;

class SubMenuScreen extends StatefulWidget {
  final prevSnap;
  final int index;

  const SubMenuScreen(this.prevSnap, this.index, {super.key});

  @override
  State<SubMenuScreen> createState() => _SubMenuScreenState();
}

class _SubMenuScreenState extends State<SubMenuScreen> {
  dynamic argumentData = Get.arguments;
  final PageController _controller = PageController();
  final List<DocumentSnapshot> _snapData = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _retrieveData();
    _controller.addListener(_onPageChanged);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.jumpToPage(widget.index);
    });
  }

  void _onPageChanged() {
    if (_controller.page == _snapData.length - 1 && !_isLoading) {
      _retrieveMoreData();
    }
  }

  Future<void> _retrieveData() async {
    setState(() {
      _snapData.addAll(widget.prevSnap);
    });
  }

  Future<void> _retrieveMoreData() async {
    setState(() => _isLoading = true);

    final snapshot = await FirebaseFirestore.instance
        .collection('posts')
        .orderBy('datePublished', descending: true)
        .startAfterDocument(_snapData.last)
        .limit(10)
        .get();

    setState(() {
      _snapData.addAll(snapshot.docs);
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            PageView.builder(
                controller: _controller,
                itemCount: _snapData.length + (_isLoading ? 1 : 0),
                scrollDirection: Axis.vertical,
                itemBuilder: (BuildContext context, int index) {
                  if (index == _snapData.length - 1 && _isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    return PostItem(
                        _visibility, _snapData[index].data(), index, _snapData);
                  }
                }),
            Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  'Posts',
                  style: AppStyle.txtInterSemiBold25,
                )),
          ],
        ),
      ),
    );
  }
}
