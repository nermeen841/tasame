import 'package:flutter/material.dart';
import 'package:zat/core/constants/constants.dart';
import 'package:zat/presentation/screens/blogs%20screens/widget/story_detail_body.dart';

class StoryDetailScreen extends StatefulWidget {
  final String videoId;
  final String name;
  const StoryDetailScreen(
      {super.key, required this.videoId, required this.name});

  @override
  State<StoryDetailScreen> createState() => _StoryDetailScreenState();
}

class _StoryDetailScreenState extends State<StoryDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(title: "", context: context),
      body: StoryDetailBody(
        videoId: widget.videoId,
        name: widget.name,
      ),
    );
  }
}
