import 'package:flutter/material.dart';
import './tabs/home.dart';
import 'tabs/music.dart';
import 'tabs/more.dart';
import './tabs/user.dart';

class Tabs extends StatefulWidget {
  final int index;
  const Tabs({Key? key, this.index = 0}) : super(key: key);

  @override
  State<Tabs> createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.index;
  }

  final List<Widget> _pages = const [
    HomePage(),
    MusicPage(),
    MorePage(),
    UserPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("基尼钛镁"),
      ),
      drawer: const Drawer(
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: UserAccountsDrawerHeader(
                    accountName: Text("基尼钛镁"),
                    accountEmail: Text("jinitaimei@qq.com"),
                  ),
                )
              ],
            ),
            ListTile(
              leading: CircleAvatar(
                child: Icon(Icons.people),
              ),
              title: Text("个人中心"),
            ),
            Divider(),
            ListTile(
              leading: CircleAvatar(
                child: Icon(Icons.settings),
              ),
              title: Text("系统设置"),
            ),
            Divider(),
          ],
        ),
      ),
      body: Stack(
        children: [
          _pages[_currentIndex],
        ],
      ),
      bottomNavigationBar: Stack(
        children: [
          BottomNavigationBar(
            fixedColor: Colors.red,
            currentIndex: _currentIndex,
            type: BottomNavigationBarType.fixed,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: "首页",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.music_video),
                label: "音乐",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.more),
                label: "更多",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.people),
                label: "用户",
              )
            ],
          ),
        ],
      ),
    );
  }
}
