import 'package:get_it/get_it.dart';
import 'package:zat/presentation/screens/blogs%20screens/cubit/blogs_cubit.dart';
import 'package:zat/presentation/screens/contactus/cubit/setting_cubit.dart';
import 'package:zat/presentation/screens/home/cubit/home_cubit.dart';
import 'package:zat/presentation/screens/messages/cubit/chat_cubit.dart';
import 'package:zat/presentation/screens/myaccount/cubit/profile_cubit.dart';
import 'package:zat/presentation/screens/orders/cubit/orders_cubit.dart';
import 'package:zat/presentation/screens/qustionare/cubit/quastionaire_cubit.dart';
import '../../presentation/screens/auth/bloc/Auth_cubit/auth_cubit.dart';

Future<void> init() async {
  GetIt.instance.registerLazySingleton<AuthCubit>(() => AuthCubit());
  GetIt.instance.registerSingleton<ProfileCubit>(ProfileCubit());
  // GetIt.instance
  //     .registerSingleton<ConferenceCubitCubit>(ConferenceCubitCubit());
  GetIt.instance.registerSingleton<ChatCubit>(ChatCubit());
  GetIt.instance.registerSingleton<HomeCubit>(HomeCubit());
  GetIt.instance.registerSingleton<SettingCubit>(SettingCubit());
  GetIt.instance.registerSingleton<QuastionaireCubit>(QuastionaireCubit());
  GetIt.instance.registerSingleton<BlogsCubit>(BlogsCubit());
  GetIt.instance.registerSingleton<OrdersCubit>(OrdersCubit());
}
