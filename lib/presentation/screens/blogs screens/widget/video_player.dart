import 'package:flutter/material.dart';
import 'package:pod_player/pod_player.dart';

class VideoStoryPlayer extends StatefulWidget {
  final String videoUrl;
  const VideoStoryPlayer({super.key, required this.videoUrl});

  @override
  State<VideoStoryPlayer> createState() => _VideoStoryPlayerState();
}

class _VideoStoryPlayerState extends State<VideoStoryPlayer> {
  PodPlayerController? controller;

  @override
  void initState() {
    controller = PodPlayerController(
        playVideoFrom: PlayVideoFrom.youtube(widget.videoUrl),
        podPlayerConfig: const PodPlayerConfig(
          autoPlay: false,
          isLooping: false,
        ))
      ..initialise();
    super.initState();
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: PodVideoPlayer(
        controller: controller!,
      ),
    );
  }
}
