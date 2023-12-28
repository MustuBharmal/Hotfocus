import 'package:get/get.dart';
import '../presentation/app_intro_screen/app_intro_screen.dart';
import '../presentation/app_intro_screen/binding/app_intro_binding.dart';

import '../presentation/app_navigation_screen/app_navigation_screen.dart';
import '../presentation/app_navigation_screen/binding/app_navigation_binding.dart';
import '../presentation/edit_profile_screen/binding/edit_profile_binding.dart';
import '../presentation/edit_profile_screen/edit_profile_screen.dart';
import '../presentation/enable_disable_notification_screen/binding/enable_disable_notification_binding.dart';
import '../presentation/enable_disable_notification_screen/enable_disable_notification_screen.dart';
import '../presentation/forgot_password_screen/binding/forgot_password_binding.dart';
import '../presentation/forgot_password_screen/forgot_password_screen.dart';
import '../presentation/login_screen/binding/login_binding.dart';
import '../presentation/login_screen/login_screen.dart';
import '../presentation/messages_search_screen/binding/messages_search_binding.dart';
import '../presentation/messages_search_screen/messages_search_screen.dart';
import '../presentation/news_feed_main_screen/binding/news_feed_main_binding.dart';
import '../presentation/news_feed_main_screen/news_feed_main_screen.dart';
import '../presentation/notifications_screen/binding/notifications_binding.dart';
import '../presentation/notifications_screen/notifications_screen.dart';
import '../presentation/post_full_screen/binding/post_full_binding.dart';
import '../presentation/post_full_screen/post_full_screen.dart';
import '../presentation/profile_settings_blocked_users_screen/binding/profile_settings_blocked_users_binding.dart';
import '../presentation/profile_settings_blocked_users_screen/profile_settings_blocked_users_screen.dart';
import '../presentation/profile_settings_screen/binding/profile_settings_binding.dart';
import '../presentation/profile_settings_screen/profile_settings_screen.dart';
import '../presentation/search_feed_screen/binding/search_feed_binding.dart';
import '../presentation/search_feed_screen/search_feed_screen.dart';
import '../presentation/search_user_screen/search_user_screen.dart';
import '../presentation/sign_up_screen/binding/sign_up_binding.dart';
import '../presentation/sign_up_screen/sign_up_screen.dart';
import '../presentation/single_post_screen/binding/single_post_binding.dart';
import '../presentation/single_post_screen/single_post_screen.dart';
import '../presentation/video_trim_screen/video_trim_binding_binding.dart';
import '../presentation/video_trim_screen/video_trim_view.dart';
import '../presentation/welcome_screen/binding/welcome_binding.dart';
import '../presentation/welcome_screen/welcome_screen.dart';

class AppRoutes {
  static const String welcomeScreen = '/welcome_screen';

  static const String profileSettingsScreen = '/profile_settings_screen';

  static const String profileSettingsBlockedUsersScreen =
      '/profile_settings_blocked_users_screen';

  static const String appIntroScreen = '/app_intro_screen';
  static const String openCamera = '/openCameraScreen';

  static const String loginScreen = '/login_screen';

  static const String forgotPasswordScreen = '/forgot_password_screen';

  static const String signUpScreen = '/sign_up_screen';

  static const String enableDisableNotificationScreen =
      '/enable_disable_notification_screen';

  static const String newsFeedMainScreen = '/news_feed_main_screen';

  static const String singlePostScreen = '/single_post_screen';

  static const String myProfileAboutScreen = '/my_profile_about_screen';
  static const String videoTrim = '/video_trim_view';

  static const String editProfileScreen = '/edit_profile_screen';

  static const String notificationsScreen = '/notifications_screen';

  static const String searchFeedScreen = '/search_feed_screen';

  static const String messagesSearchScreen = '/messages_search_screen';

  static const String messagesChatBoxScreen = '/messages_chat_box_screen';

  static const String followersScreen = '/followers_screen';

  static const String subMenuScreen = '/sub_menu_screen';

  static const String postFullScreen = '/post_full_screen';

  static const String storyCameraTypeScreen = '/story_camera_type_screen';

  static const String storyViewsPersonalScreen = '/story_views_personal_screen';

  static const String commentSectionScreen = '/comment_section_screen';

  static const String getCameraScreen = '/camera_screens';
  static const String appNavigationScreen = '/app_navigation_screen';
  static const String searchUserScreen = '/search_user_screen';

  static String initialRoute = '/initialRoute';

  static List<GetPage> pages = [
    GetPage(
      name: welcomeScreen,
      page: () => const WelcomeScreen(),
      bindings: [
        WelcomeBinding(),
      ],
    ),
    GetPage(
      name: profileSettingsScreen,
      page: () => ProfileSettingsScreen(),
      bindings: [
        ProfileSettingsBinding(),
      ],
    ),
    GetPage(
      name: videoTrim,
      page: () => const VideoTrimView(),
      bindings: [
        VideoTrimBinding(),
      ],
    ),
    GetPage(
      name: searchUserScreen,
      page: () => const SearchScreen(),
    ),
    GetPage(
      name: profileSettingsBlockedUsersScreen,
      page: () => ProfileSettingsBlockedUsersScreen(),
      bindings: [
        ProfileSettingsBlockedUsersBinding(),
      ],
    ),
    GetPage(
      name: appIntroScreen,
      page: () => const AppIntroScreen(),
      bindings: [
        AppIntroBinding(),
      ],
    ),
    GetPage(
      name: loginScreen,
      page: () => const LoginScreen(),
      bindings: [
        LoginBinding(),
      ],
    ),
    GetPage(
      name: forgotPasswordScreen,
      page: () => ForgotPasswordScreen(),
      bindings: [
        ForgotPasswordBinding(),
      ],
    ),
    GetPage(
      name: signUpScreen,
      page: () => const SignUpScreen(),
      bindings: [
        SignUpBinding(),
      ],
    ),
    GetPage(
      name: enableDisableNotificationScreen,
      page: () => EnableDisableNotificationScreen(),
      bindings: [
        EnableDisableNotificationBinding(),
      ],
    ),
    GetPage(
      name: newsFeedMainScreen,
      page: () => const NewsFeedMainScreen(),
      bindings: [
        NewsFeedMainBinding(),
      ],
    ),
    GetPage(
      name: singlePostScreen,
      page: () => const SinglePostScreen(),
      bindings: [
        SinglePostBinding(),
      ],
    ),
    GetPage(
      name: editProfileScreen,
      page: () => const EditProfileScreen(),
      bindings: [
        EditProfileBinding(),
      ],
    ),
    GetPage(
      name: notificationsScreen,
      page: () => NotificationsScreen(),
      bindings: [
        NotificationsBinding(),
      ],
    ),
    GetPage(
      name: searchFeedScreen,
      page: () => const SearchFeedScreen(),
      bindings: [
        SearchFeedBinding(),
      ],
    ),
    GetPage(
      name: messagesSearchScreen,
      page: () => MessagesSearchScreen(),
      bindings: [
        MessagesSearchBinding(),
      ],
    ),
    GetPage(
      name: postFullScreen,
      page: () => const PostFullScreen(),
      bindings: [
        PostFullBinding(),
      ],
    ),
    GetPage(
      name: appNavigationScreen,
      page: () => AppNavigationScreen(),
      bindings: [
        AppNavigationBinding(),
      ],
    ),
    GetPage(
      name: initialRoute,
      page: () => const WelcomeScreen(),
      bindings: [
        WelcomeBinding(),
      ],
    )
  ];
}
