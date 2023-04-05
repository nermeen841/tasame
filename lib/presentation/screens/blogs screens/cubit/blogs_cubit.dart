// ignore_for_file: avoid_print, depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:zat/core/helper/functions/show_toast.dart';
import 'package:zat/presentation/screens/blogs%20screens/action/sussecc_story.dart';
import 'package:zat/presentation/screens/blogs%20screens/action/writting.dart';
import 'package:zat/presentation/screens/blogs%20screens/model/success_stories.dart';
import 'package:zat/presentation/screens/blogs%20screens/model/writting.dart';

import '../../../../core/router/router.dart';
import '../action/story_detail_action.dart';
import '../model/story_detail.dart';
import '../pages/success_story.dart';

part 'blogs_state.dart';

class BlogsCubit extends Cubit<BlogsState> {
  BlogsCubit() : super(BlogsInitial());

  SuccessStoriesModel? storiesModel;
  getSuccessStories(int isAdmin) async {
    emit(GetSuccessStoriesLoadingState());
    await GetSuccessStories(isAdmin).run().then(
          (value) => value.fold(
            (l) {
              print(l.message);
              showToast(msg: l.message, state: ToastStates.ERROR);
              emit(GetSuccessStoriesErrorState());
            },
            (r) {
              storiesModel = r;
              emit(GetSuccessStoriesSuccessState());
              MagicRouter.navigateTo(SuccessStoriesScreen(
                isAdmin: isAdmin,
              ));
              return storiesModel;
            },
          ),
        );
  }
/////////////////////////////////////////////////////////

  SuccessStoryDetailModel? successStoryDetailModel;
  getSuccessStoriesDetail(int storyId) async {
    emit(GetSuccessStoryDetailLoadingState());
    await GetSuccessStoryDetailAction(storyId).run().then(
          (value) => value.fold(
            (l) {
              print(l.message);
              showToast(msg: l.message, state: ToastStates.ERROR);
              emit(GetSuccessStoryDetailErrorState());
            },
            (r) {
              successStoryDetailModel = r;
              emit(GetSuccessStoryDetailSuccessState());
              return successStoryDetailModel;
            },
          ),
        );
  }

  //////////////////////////////////////////////////////
  WrittingModel? writtingModel;
  getWrittingdata() async {
    emit(GetWrittingLoadingState());
    await GetWrittingAction().run().then(
          (value) => value.fold(
            (l) {
              print(l.message);
              emit(GetWrittingErrorState());
            },
            (r) {
              writtingModel = r;
              emit(GetWrittingSuccessState());
              return writtingModel;
            },
          ),
        );
  }
}
