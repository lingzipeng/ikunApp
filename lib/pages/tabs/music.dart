import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class MusicPage extends StatelessWidget {
  const MusicPage({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('坤坤神曲'),
      ),
      body: Column(
        children: [
          Expanded(
            child: MusicPlayerGrid(),
          ),
          Container(
            padding: EdgeInsets.all(16.0),
            alignment: Alignment.center,
            child: const Text(
              '点击任意按钮播发音乐，另外有点小bug',
              style: TextStyle(
                fontSize: 8.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MusicPlayerGrid extends StatefulWidget {
  @override
  _MusicPlayerGridState createState() => _MusicPlayerGridState();
}

class _MusicPlayerGridState extends State<MusicPlayerGrid> {
  final List<String> songs = [
    
    '啊啊鸡.mp3',
    '波波鸡.mp3',
    '不变鸡.mp3',
    "Alone鸡.mp3",
    "rap鸡.mp3",
    '电音鸡.mp3',
    '发财鸡.mp3',
    '防空鸡.mp3',
    '干嘛鸡.mp3',
    '各种鸡.mp3',
    '果宝鸡.mp3',
    '好看鸡.mp3',
    '鸡出没.mp3',
    '鸡纲目.mp3',
    '鸡进村.mp3',
    '鸡路里.mp3',
    '鸡太踊.mp3',
    '江南鸡.mp3',
    '结婚鸡.mp3',
    '惊魂鸡.mp3',
    '荔枝鸡.mp3',
    '铃声鸡.mp3',
    '猫鼠鸡.mp3',
    '美国鸡.mp3',
    '蜜雪鸡.mp3',
    '民族鸡.mp3',
    '某人鸡.mp3',
    '噢力鸡.mp3',
    '噢泡鸡.mp3',
    '澎湖鸡.mp3',
    '青蛙鸡.mp3',
    '荣耀鸡.mp3',
    '栓Q鸡.mp3',
    '拖拉鸡.mp3',
    '西游鸡.mp3',
    '仙剑鸡.mp3',
    '小母鸡.mp3',
    '新年鸡.mp3',
    '新闻鸡.mp3',
    '阳光鸡.mp3',
    '耶耶鸡.mp3',
    '夜的鸡.mp3',
    '印度鸡.mp3',
    // 添加更多歌曲文件名

  ];

  late List<bool> isPlayingList;
  int? currentPlayingIndex;
  late AudioPlayer audioPlayer;

  @override
  void initState() {
    super.initState();
    isPlayingList = List.filled(songs.length, false);
    audioPlayer = AudioPlayer();
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
      ),
      itemCount: songs.length,
      itemBuilder: (context, index) {
        String songName = songs[index].split('.').first;
        return MusicPlayerButton(
          audioUrl: 'assets/music/${songs[index]}',
          songName: songName,
          isPlaying: isPlayingList[index],
          onPressed: () {
            setState(() {
              if (currentPlayingIndex != null && currentPlayingIndex != index) {
                isPlayingList[currentPlayingIndex!] = false;
              }
              isPlayingList[index] = !isPlayingList[index];
              currentPlayingIndex = isPlayingList[index] ? index : null;
            });
          },
          audioPlayer: audioPlayer,
        );
      },
    );
  }
}

class MusicPlayerButton extends StatefulWidget {
  final String audioUrl;
  final String songName;
  final bool isPlaying;
  final VoidCallback onPressed;
  final AudioPlayer audioPlayer;

  const MusicPlayerButton({
    Key? key,
    required this.audioUrl,
    required this.songName,
    required this.isPlaying,
    required this.onPressed,
    required this.audioPlayer,
  }) : super(key: key);

  @override
  _MusicPlayerButtonState createState() => _MusicPlayerButtonState();
}

class _MusicPlayerButtonState extends State<MusicPlayerButton> {
  late bool isPlaying;

  @override
void initState() {
  super.initState();
  isPlaying = widget.isPlaying;
  widget.audioPlayer.onPlayerStateChanged.listen((state) {
    if (mounted) { // Check if the component is mounted before calling setState
      if (state == PlayerState.PLAYING) {
        setState(() {
          isPlaying = true;
        });
      } else {
        setState(() {
          isPlaying = false;
        });
      }
    }
  });
}


  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        if (isPlaying) {
          await widget.audioPlayer.pause();
          setState(() {
            isPlaying = false;
          });
        } else {
          await widget.audioPlayer.play(widget.audioUrl);
          setState(() {
            isPlaying = true;
          });
        }
      },
      child: Text(widget.songName),
    );
  }
}
