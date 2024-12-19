
class ApiSetting {
  static String get baseUrl => 'http://ebrahim995-001-site3.ktempurl.com/api';


  static String get getMainCategory => '${baseUrl}/Categories/GetMainCategories';
  static String get getSubCategory => '${baseUrl}/Categories/GetCategoriesByMainCategory';

  // // Auth endpoints
  // static String get login => ;
  // static String get signup => '${AppConfig.authEndpoint}/signup';
  //
  // // tags endpoints
  // static String get colleges => '${AppConfig.tagsEndpoint}/colleges';
  // static String get majors => '${AppConfig.tagsEndpoint}/majors';
  //
  //
  // //
  // // // create post
  // static String createPost = AppConfig.postsEndpoint;
  // static String getTags = AppConfig.getTagsEndpoint;
  //
  // static String get getPosts => AppConfig.postsEndpoint;
  // static String get getComments => AppConfig.postsEndpoint;
  // static String get getUserReactionByType => AppConfig.postsEndpoint;
  // static String get reactionToPost => AppConfig.postsEndpoint;
}