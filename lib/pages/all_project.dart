import 'dart:io';

import 'package:flutter/material.dart';

class AllProjectsPage extends StatefulWidget {
  const AllProjectsPage({Key? key}) : super(key: key);

  @override
  State<AllProjectsPage> createState() => _AllProjectsPageState();
}

class _AllProjectsPageState extends State<AllProjectsPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Projects',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              child: Align(
                alignment: Alignment.centerLeft,
                child: TabBar(
                  controller: _tabController,
                  labelColor: const Color.fromARGB(255, 28, 84, 157),
                  unselectedLabelColor: Colors.blueGrey,
                  labelPadding: const EdgeInsets.only(left: 20, right: 20),
                  isScrollable: true,
                  indicator: CircularTabIndicator(
                      color: Color.fromARGB(255, 28, 84, 157), radius: 4),
                  tabs: const [
                    Tab(
                      text: "On going",
                    ),
                    Tab(
                      text: "Done",
                    ),
                    Tab(
                      text: "All",
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: double.maxFinite,
              height: 300,
              child: TabBarView(controller: _tabController, children: const [
                Text("hi"),
                Text("hi1"),
                Text("hi2"),
              ]),
            )
          ],
        ),
      ),
    );
  }
}

class CircularTabIndicator extends Decoration {
  final Color color;
  double radius;

  CircularTabIndicator({required this.color, required this.radius});

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _CirclePainter(color: color, radius: radius);
  }
}

class _CirclePainter extends BoxPainter {
  final double radius;
  late Color color;
  _CirclePainter({required this.color, required this.radius});

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration cfg) {
    late Paint _paint;
    _paint = Paint()..color = color;
    _paint = _paint..isAntiAlias = true;
    final Offset circleOffset =
        offset + Offset(cfg.size!.width / 2, cfg.size!.height - radius);
    canvas.drawCircle(circleOffset, radius, _paint);
  }
}
