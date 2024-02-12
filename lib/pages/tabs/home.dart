import 'package:flutter/material.dart';
import 'dart:async';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> imagePaths = [
    'picture/1.jpg',
    'picture/2.jpg',
    'picture/3.jpg',
    'picture/4.jpg',
    'picture/5.jpg',
  ];

  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: 0,
      viewportFraction: 1.0,
    );
    // 启动定时器，每五秒切换一次图片
    Timer.periodic(const Duration(seconds: 5), (Timer timer) {
      if (_pageController.hasClients) {
        _pageController.nextPage(
          duration: const Duration(milliseconds: 500),
          curve: Curves.ease,
        );
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 250.0,
            child: Stack(
              children: [
                PageView.builder(
                  controller: _pageController,
                  itemCount: imagePaths.length + 1,
                  itemBuilder: (context, index) {
                    if (index == imagePaths.length) {
                      return Image.asset(
                        imagePaths[0],
                        fit: BoxFit.cover,
                      );
                    } else {
                      return Image.asset(
                        imagePaths[index],
                        fit: BoxFit.cover,
                      );
                    }
                  },
                  onPageChanged: (index) {
                    if (index == imagePaths.length) {
                      Timer(const Duration(milliseconds: 500), () {
                        _pageController.jumpToPage(0);
                      });
                    }
                  },
                ),
                Positioned(
                  top: 20.0, // 调整按钮位置
                  left: 20.0,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_pageController.page != null &&
                          _pageController.page! > 0) {
                        _pageController.previousPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.ease,
                        );
                      } else {
                        _pageController.jumpToPage(imagePaths.length - 1);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.transparent, // 背景色透明
                    ),
                    child: const Text(
                      '上一张',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Positioned(
                  top: 20.0, // 调整按钮位置
                  right: 20.0,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_pageController.page != null &&
                          _pageController.page! < imagePaths.length) {
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.ease,
                        );
                      } else {
                        _pageController.jumpToPage(0);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.transparent, // 背景色透明
                    ),
                    child: const Text(
                      '下一张',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20), // 添加一些垂直间距
          const Text(
            '更多内容敬请期待...',
            style: TextStyle(fontSize: 10),
          ),
        ],
      ),
    );
  }
}
