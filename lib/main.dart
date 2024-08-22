import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Auto Scroll in Flutter",
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'Auto Scroll Example',
            style: TextStyle(color: Colors.amberAccent),
          ),
        ),
        body: AutoScrollListView(),
      ),
    );
  }
}

class AutoScrollListView extends StatefulWidget {
  @override
  _AutoScrollListViewState createState() => _AutoScrollListViewState();
}

class _AutoScrollListViewState extends State<AutoScrollListView> {
  final ScrollController _scrollController = ScrollController();
  final int _itemCount = 40; // Number of items in the list
  final double _scrollOffset = 5.0; // Scroll offset per iteration

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
  }

  void _startAutoScroll() async {
    bool scrollingDown = true;

    while (true) {
      await Future.delayed(Duration(milliseconds: 30)); // Delay between scrolls

      if (_scrollController.hasClients) {
        double maxScrollExtent = _scrollController.position.maxScrollExtent;
        double currentOffset = _scrollController.offset;

        if (scrollingDown) {
          if (currentOffset < maxScrollExtent) {
            _scrollController.animateTo(
              currentOffset + _scrollOffset, // Scroll by 5 pixels
              duration: Duration(milliseconds: 30),
              curve: Curves.easeInOut,
            );
          } else {
            scrollingDown = false; // Start scrolling up when reaching the end
          }
        } else {
          if (currentOffset > 0) {
            _scrollController.animateTo(
              currentOffset - _scrollOffset, // Scroll up by 5 pixels
              duration: Duration(milliseconds: 30),
              curve: Curves.easeInOut,
            );
          } else {
            scrollingDown = true; // Start scrolling down when reaching the top
          }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: _scrollController,
      itemCount: _itemCount,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(
              'Lê Tú Vi dễ thương, xinh đẹp, thông minh và tài giỏi $index'),
        );
      },
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
