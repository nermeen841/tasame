part of 'blogs_cubit.dart';

@immutable
abstract class BlogsState {}

class BlogsInitial extends BlogsState {}

class GetSuccessStoriesLoadingState extends BlogsState {}

class GetSuccessStoriesSuccessState extends BlogsState {}

class GetSuccessStoriesErrorState extends BlogsState {}

class GetSuccessStoryDetailLoadingState extends BlogsState {}

class GetSuccessStoryDetailSuccessState extends BlogsState {}

class GetSuccessStoryDetailErrorState extends BlogsState {}

class GetWrittingLoadingState extends BlogsState {}

class GetWrittingSuccessState extends BlogsState {}

class GetWrittingErrorState extends BlogsState {}
