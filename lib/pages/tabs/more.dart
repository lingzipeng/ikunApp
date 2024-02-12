import 'package:flutter/material.dart';

class MorePage extends StatefulWidget {
  const MorePage({Key? key}) : super(key: key);

  @override
  State<MorePage> createState() => _MorePageState();
}

class _MorePageState extends State<MorePage> {
  final List<String> imageUrls = [
    // 添加你想展示的照片的URL
    'picture/1.jpg',
    'picture/2.jpg',
    'picture/3.jpg',
    'picture/4.jpg',
    'picture/5.jpg',
    'picture/6.jpg',
    'picture/7.jpg',
    'picture/8.jpg',
    'picture/9.jpg',
    'picture/10.jpg',
    'picture/11.jpg',
    'picture/12.jpg',
    'picture/13.jpg',
    'picture/14.jpg',
    'picture/15.jpg',
    'picture/16.jpg',
    'picture/17.jpg',
    'picture/18.jpg',
    'picture/20.jpg',
    'picture/21.jpg',
    'picture/22.jpg',
    'picture/23.jpg',
    'picture/24.jpg',
    'picture/25.jpg',
  ];


  int _currentIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentIndex);
  }

  void _previousImage() {
    setState(() {
      _currentIndex = (_currentIndex - 1).clamp(0, imageUrls.length - 1);
      _pageController.previousPage(duration: Duration(milliseconds: 300), curve: Curves.ease);
    });
  }

  void _nextImage() {
    setState(() {
      _currentIndex = (_currentIndex + 1) % imageUrls.length;
      _pageController.nextPage(duration: Duration(milliseconds: 300), curve: Curves.ease);
    });
  }

  void _onDotClicked(int index) {
    setState(() {
      _currentIndex = index;
    });
    _pageController.animateToPage(
      index,
      duration: Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('坤坤美照'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                PageView.builder(
                  controller: _pageController,
                  itemCount: imageUrls.length,
                  onPageChanged: (index) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.symmetric(horizontal: 20.0), // 添加左右边距
                      child: Image.asset(
                        imageUrls[index],
                        fit: BoxFit.contain, // 保持图片长宽比，适应最大尺寸
                        width: MediaQuery.of(context).size.width - 40.0, // 图片宽度为屏幕宽度减去左右边距
                      ),
                    );
                  },
                ),
                Positioned(
                  left: 0,
                  top: 0,
                  bottom: 0,
                  child: IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: _previousImage,
                  ),
                ),
                Positioned(
                  right: 0,
                  top: 0,
                  bottom: 0,
                  child: IconButton(
                    icon: Icon(Icons.arrow_forward),
                    onPressed: _nextImage,
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(imageUrls.length, (index) {
              return GestureDetector(
                onTap: () => _onDotClicked(index),
                child: Container(
                  width: 10,
                  height: 10,
                  margin: EdgeInsets.symmetric(horizontal: 2),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentIndex == index ? Colors.blue : Colors.grey,
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
