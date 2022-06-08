import 'package:flutter/material.dart';

import 'add_project.dart';
import 'edit_profile.dart';
import 'home.dart';

class TabBarView1 extends StatefulWidget {
  const TabBarView1({ Key? key }) : super(key: key);

  @override
  State<TabBarView1> createState() => _TabBarView1State();
}

class _TabBarView1State extends State<TabBarView1> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        children: const <Widget>[
          HomePage(),
          AddProjectPage(),
          EditProfilePage(),
        ],
        controller: _tabController,
      ),
      bottomNavigationBar: Container(
        height: 100,
        color: Colors.transparent,
        // padding: EdgeInsets.all(16),
        padding: const EdgeInsets.all(15),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(50)),
          child: Container(
            decoration: const BoxDecoration(
                color: Color.fromARGB(255, 222, 240, 255),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                  )
                ]),
            child: TabBar(
              indicatorSize: TabBarIndicatorSize.tab,
              // indicator: CircleTabIndicator(color: Color.fromARGB(255, 28, 84, 157), radius: 4),
              labelColor: const Color.fromARGB(255, 28, 84, 157),
              unselectedLabelColor: const Color.fromRGBO(0, 0, 0, 0.6),
              tabs: [
                const Tab(
                  icon: Icon(Icons.home_rounded),
                ),
                Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment(0, 0),
                        end: Alignment(-1.0, 1.0),
                        colors: [
                          Color.fromARGB(255, 28, 84, 157),
                          Color.fromARGB(255, 105, 165, 243)
                        ]),
                    shape: BoxShape.circle,
                  ),
                  child: FloatingActionButton(
                    onPressed: () {
                      chooseAddOption();
                    },
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    child: const Icon(Icons.add),
                  ),
                ),
                const Tab(
                  icon: Icon(Icons.person),
                ),
              ],
              controller: _tabController,
            ),
          ),
        ),
      ),
    );
  }

  void chooseAddOption() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            color: Color(0xFF737373),
            height: 140,
            child: Container(
              padding:
                  EdgeInsets.only(top: 20, left: 30, right: 30, bottom: 20),
              decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 222, 240, 255),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  )),
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.task_alt_rounded),
                    title: Text('To do'),
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.rocket_launch_rounded),
                    title: Text('Project'),
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddProjectPage()));
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }
}