import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YouTubePlayerScreen extends StatefulWidget {
  final String videoUrl;
  String? title;

  YouTubePlayerScreen({super.key, this.title, required this.videoUrl});

  @override
  _YouTubePlayerScreenState createState() => _YouTubePlayerScreenState();
}

class _YouTubePlayerScreenState extends State<YouTubePlayerScreen> {
  late YoutubePlayerController _controller;
  late String _videoId;
  late PlayerState _playerState;
  bool _isPlayerReady = false;

  @override
  void initState() {
    super.initState();
    _videoId = YoutubePlayer.convertUrlToId(widget.videoUrl) ?? '';

    _controller = YoutubePlayerController(
      initialVideoId: _videoId,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
        hideControls: false,
        enableCaption: true,
      ),
    );
    _playerState = PlayerState.unknown;
  }

  @override
  void deactivate() {
    _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _skipForward(int seconds) {
    if (_isPlayerReady) {
      final position = _controller.value.position;
      final newPosition = position + Duration(seconds: seconds);
      _controller.seekTo(newPosition);
    }
  }

  void _skipBackward(int seconds) {
    if (_isPlayerReady) {
      final position = _controller.value.position;
      final newPosition = Duration(
        seconds: (position.inSeconds - seconds)
            .clamp(0, _controller.metadata.duration.inSeconds),
      );
      _controller.seekTo(newPosition);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: widget.title == null
              ? const Text("YouTube Video")
              : Text(widget.title!),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Center(
              child: _videoId.isNotEmpty
                  ? YoutubePlayer(
                      controller: _controller,
                      showVideoProgressIndicator: true,
                      progressIndicatorColor: Colors.red,
                      progressColors: const ProgressBarColors(
                        playedColor: Colors.red,
                        handleColor: Colors.redAccent,
                      ),
                       onReady: () {
            setState(() {
              _isPlayerReady = true;
            });
          },
                  ) : const Text('Invalid YouTube URL'),
                  ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _skipButton(-30, "⏪ 30s"),
                  _skipButton(-10, "⏪ 10s"),
                  _playPauseButton(),
                  _skipButton(10, "10s ⏩"),
                  _skipButton(30, "30s ⏩"),
                ],
              ),
            ),
          ],
        ));
  }

  Widget _skipButton(int seconds, String label) {
    return ElevatedButton(
      onPressed: () {
        if (seconds < 0) {
          _skipBackward(seconds.abs());
        } else {
          _skipForward(seconds);
        }
      },
      child: Text(label),
    );
  }

  Widget _playPauseButton() {
    return IconButton(
      icon: Icon(
        _playerState == PlayerState.playing ? Icons.pause : Icons.play_arrow,
        size: 30,
      ),
      onPressed: _isPlayerReady
          ? () {
              setState(() {
                if (_playerState == PlayerState.playing) {
                _controller.pause();
              } else {
                _controller.play();
              }
              });
            }
          : null,
    );
  }
}

// Example of a video list page where you can manage your YouTube URLs
class VideoListPage extends StatefulWidget {
  const VideoListPage({super.key});

  @override
  _VideoListPageState createState() => _VideoListPageState();
}

class _VideoListPageState extends State<VideoListPage> {
  final _formKey = GlobalKey<FormState>();
  final _urlController = TextEditingController();

  // This would typically come from your database or API
  final List<Map<String, String>> _videos = [
    {
      'title': 'Sample Video 1',
      'url': 'https://youtu.be/_Wo4V3JTbW8?si=aU3gWcaNUEA3UlRG',
    },
    // Add more videos as needed
  ];

  void _addVideo() {
    if (_formKey.currentState!.validate()) {
      final url = _urlController.text;
      final videoId = YoutubePlayer.convertUrlToId(url);

      if (videoId != null) {
        setState(() {
          _videos.add({
            'title':
                'New Video', // You might want to add a title field to your form
            'url': url,
          });
        });
        _urlController.clear();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My YouTube Videos'),
      ),
      body: Column(
        children: [
          // Form to add new video URLs
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _urlController,
                      decoration: const InputDecoration(
                        labelText: 'YouTube URL',
                        hintText: 'https://www.youtube.com/watch?v=...',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a URL';
                        }
                        if (YoutubePlayer.convertUrlToId(value) == null) {
                          return 'Invalid YouTube URL';
                        }
                        return null;
                      },
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: _addVideo,
                  ),
                ],
              ),
            ),
          ),

          // List of videos
          Expanded(
            child: ListView.builder(
              itemCount: _videos.length,
              itemBuilder: (context, index) {
                final video = _videos[index];
                return ListTile(
                  title: Text(video['title']!),
                  subtitle: Text(
                    video['url']!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => YouTubePlayerScreen(
                          videoUrl: video['url']!,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _urlController.dispose();
    super.dispose();
  }
}