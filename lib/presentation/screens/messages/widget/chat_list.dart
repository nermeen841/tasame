import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:zat/core/constants/colors.dart';
import 'package:zat/core/constants/constants.dart';
import 'package:zat/core/router/router.dart';
import 'package:zat/core/widgets/space_widget.dart';
import 'package:zat/presentation/screens/messages/cubit/chat_cubit.dart';
import 'package:zat/presentation/screens/messages/pages/chat_body.dart';

class ChatList extends StatefulWidget {
  const ChatList({Key? key}) : super(key: key);

  @override
  State<ChatList> createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  @override
  void initState() {
    GetIt.I<ChatCubit>().getAllChats();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatCubit, ChatState>(
      listener: (context, state) {},
      bloc: GetIt.I<ChatCubit>(),
      builder: (context, state) {
        return (GetIt.I<ChatCubit>().allChatsModel != null)
            ? ListView.separated(
                shrinkWrap: true,
                primary: false,
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth(context) * 0.04,
                ),
                itemBuilder: (context, index) =>
                    // width: double.infinity,
                    // height: screenHeight(context) * 0.09,
                    // padding: EdgeInsets.symmetric(
                    //   horizontal: screenWidth(context) * 0.03,
                    //   vertical: screenHeight(context) * 0.01,
                    // ),
                    // color: (index == 0)
                    //     ? Colors.orange.withOpacity(0.1)
                    //     : Colors.transparent,
                    InkWell(
                  onTap: () => MagicRouter.navigateTo(ChatBodyScreen(
                    recieverName:
                        GetIt.I<ChatCubit>().allChatsModel!.data![index].name!,
                    recieverImage:
                        GetIt.I<ChatCubit>().allChatsModel!.data![index].image!,
                    recieverId:
                        GetIt.I<ChatCubit>().allChatsModel!.data![index].id!,
                  )),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: screenWidth(context) * 0.08,
                            backgroundImage: NetworkImage(
                              GetIt.I<ChatCubit>()
                                  .allChatsModel!
                                  .data![index]
                                  .image!,
                            ),
                          ),
                          const HorizontalSpace(value: 1),
                          Text(
                            GetIt.I<ChatCubit>()
                                .allChatsModel!
                                .data![index]
                                .name!,
                            style: headingStyle.copyWith(
                              color: colordeepGrey,
                              fontSize: screenWidth(context) * 0.04,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ],
                      ),
                      // Text(
                      //   statuse[index],
                      //   style: headingStyle.copyWith(
                      //     color: (statuse[index] == "offline")
                      //         ? colorGrey
                      //         : colordeepGreen,
                      //     fontSize: screenWidth(context) * 0.035,
                      //     fontWeight: FontWeight.w300,
                      //   ),
                      // ),
                    ],
                  ),
                ),
                separatorBuilder: (context, index) => Divider(
                  color: colorGrey,
                ),
                itemCount: GetIt.I<ChatCubit>().allChatsModel!.data!.length,
              )
            : loading();
      },
    );
  }
}
