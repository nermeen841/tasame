// ignore_for_file: prefer_interpolation_to_compose_strings, avoid_print, depend_on_referenced_packages
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:zat/core/constants/colors.dart';
import 'package:zat/core/constants/constants.dart';
import 'package:zat/presentation/screens/messages/widget/my_message.dart';
import 'package:zat/presentation/screens/messages/widget/reciver_message.dart';
import 'package:http/http.dart' as http;
import 'package:zat/presentation/screens/myaccount/cubit/profile_cubit.dart';
import '../../../../core/utiles/size_config.dart';
import '../../../../core/widgets/space_widget.dart';
import '../cubit/chat_cubit.dart';
import '../model/all_message.dart';

class ChatView extends StatefulWidget {
  final int recieverId;
  const ChatView({
    super.key,
    required this.recieverId,
  });

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  ScrollController? scrollController;
  int page = 0;
  bool hasNextPage = true;
  bool isFirstLoadRunning = false;
  bool isLoadMoreRunning = false;
  List messages = [];
  TextEditingController message = TextEditingController();
  void firstLoad() async {
    messages.clear();
    setState(() {
      isFirstLoadRunning = true;
    });
    try {
      Map<String, String> headers = {
        "Authorization": "Bearer ${prefs.getString('token').toString()}",
      };
      var response = await http.get(
        Uri.parse(
            "https://thaatty.com/api/user-message?id=${widget.recieverId}&offset=0&limit=200"),
        headers: headers,
      );
      var data = jsonDecode(response.body);
      print(data);
      if (response.statusCode == 200) {
        AllMessagesModel allMessagesModel = AllMessagesModel.fromJson(data);
        setState(() {
          messages = allMessagesModel.data!;
        });
      }
    } catch (error) {
      print("chat messages error ----------------------" + error.toString());
    }
    setState(() {
      isFirstLoadRunning = false;
    });
  }

  void loadMore() async {
    if (hasNextPage == true &&
        isFirstLoadRunning == false &&
        isLoadMoreRunning == false &&
        scrollController!.position.extentAfter < 15) {
      setState(() {
        isLoadMoreRunning = true;
        page++;
      });
      List fetchedPosts = [];
      try {
        Map<String, String> headers = {
          "Authorization": "Bearer ${prefs.getString('token').toString()}",
        };
        var response = await http.get(
          Uri.parse(
              "https://thaatty.com/api/user-message?id=${widget.recieverId}&offset=0&limit=200"),
          headers: headers,
        );
        var data = jsonDecode(response.body);

        if (response.statusCode == 200) {
          AllMessagesModel allMessagesModel = AllMessagesModel.fromJson(data);
          setState(() {
            fetchedPosts = allMessagesModel.data!;
          });
        }
        if (fetchedPosts.isNotEmpty) {
          setState(() {
            messages.addAll(fetchedPosts);
          });
        } else {
          setState(() {
            hasNextPage = false;
          });
        }
      } catch (error) {
        print("chat messages error ----------------------" + error.toString());
      }
      setState(() {
        isLoadMoreRunning = false;
      });
    }
  }

  @override
  void initState() {
    GetIt.I<ProfileCubit>().getUserProfile();
    firstLoad();
    scrollController = ScrollController()..addListener(loadMore);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return isFirstLoadRunning
        ? const SizedBox()
        : Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    reverse: true,
                    controller: scrollController,
                    itemBuilder: (context, index) {
                      {
                        if (prefs.getString("user_id") ==
                            messages[index].senderId!.toString()) {
                          return MyMessages(
                            message: messages[index].message ?? "",
                          );
                        } else {
                          return RecieverMessage(
                            message: messages[index].message ?? "",
                          );
                        }
                      }
                    },
                    separatorBuilder: (context, index) =>
                        const VerticalSpace(value: 2),
                    itemCount: messages.length,
                  ),
                ),
              ),

              if (isLoadMoreRunning == true)
                Padding(
                  padding: EdgeInsets.only(
                      top: screenHeight(context) * 0.01,
                      bottom: screenHeight(context) * 0.01),
                  child: Center(
                    child: CircularProgressIndicator(
                      color: kMainColor,
                    ),
                  ),
                ),

              // When nothing else to load
              if (hasNextPage == false)
                Container(
                  padding: EdgeInsets.only(
                      top: screenHeight(context) * 0.01,
                      bottom: screenHeight(context) * 0.01),
                  color: Colors.white,
                ),
              customTextFieldWithButtonChat(
                recieverId: widget.recieverId,
              ),
            ],
          );
  }

  ///////////////////////////////////////////////////////////////////////////

  Widget customTextFieldWithButtonChat({required int recieverId}) {
    SizeConfig().init(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: kMainColor, width: 2),
          color: Colors.white,
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Row(
          children: [
            Expanded(
              child: TextFormField(
                minLines: 1,
                maxLines: 5,
                controller: message,
                onChanged: (value) {},
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 20),
                  border: InputBorder.none,
                  hintText: 'Enter your message',
                ),
              ),
            ),
            Row(
              children: [
                BlocConsumer<ChatCubit, ChatState>(
                  listener: (context, state) {
                    if (state is SendMessageSuccessState) {
                      firstLoad();
                      message.clear();
                    }
                  },
                  bloc: GetIt.I<ChatCubit>(),
                  builder: (context, state) {
                    return Container(
                      color: Colors.transparent,
                      child: MaterialButton(
                        onPressed: () {
                          if (message.text.isNotEmpty) {
                            GetIt.I<ChatCubit>().sendMessage(
                                recieverId: widget.recieverId,
                                message: message.text);
                          }
                        },
                        minWidth: 1,
                        child: SizedBox(
                          height: SizeConfig.defaultSize! * 3.5,
                          child: Icon(
                            Icons.send,
                            color: kMainColor,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
