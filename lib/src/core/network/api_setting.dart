class ApiSetting {
  static String get baseUrl => 'http://ebrahim995-001-site3.ktempurl.com/api';

  static String get getMainCategory => '$baseUrl/Categories/GetMainCategories';
  static String get getSubCategory =>
      '$baseUrl/Categories/GetCategoriesByMainCategory';
  static String get getProductByCategory =>
      '$baseUrl/Products/GetProductsByCategory';

  static String get getNotifications =>
      '$baseUrl/Announcement/GetNotificationByUser';
  static String get createFavorite => '$baseUrl/Products/CreateFavorite';

  static String get deleteFavorite => '$baseUrl/Products/DeleteFavorite';
  static String get deleteAllFavorite => '$baseUrl/Products/DeleteAllFavorite';
  static String get createOrder => '$baseUrl/Orders/CreateOrder';

  static String get getColorList => '$baseUrl/List/GetColorList';

  static String get getItemList => '$baseUrl/List/GetItemList';

  static String get getCompaniesList => '$baseUrl/List/GetCompanyList';

  static String get createOrderMaintenance =>
      '$baseUrl/OrderMaintenances/CreateOrderMaintenance';

  static String get getOrderMaintenanceByUser =>
      '$baseUrl/OrderMaintenances/GetOrderMaintenanceByUser';

  static String get getOrderMaintenanceItem =>
      '$baseUrl/OrderMaintenances/GetOrderMaintenanceItem';

  static String get getOrderMaintenanceByUserNew =>
      '$baseUrl/OrderMaintenances/GetOrderMaintenanceByUserNew';
  static String get getOrderMaintenanceByUserOld =>
      '$baseUrl/OrderMaintenances/getOrderMaintenanceByUserOld';

  static String get getAllHandReceiptItems =>
      '$baseUrl/Maintenances/GetAllHandReceiptItems';

  static String get updateStatusForHandReceiptItem =>
      '$baseUrl/Maintenances/UpdateStatusForHandReceiptItem';
  static String get defineMalfunctionForHandReceiptItem =>
      '$baseUrl/Maintenances/DefineMalfunctionForHandReceiptItem';

  static String get createContactUs => "$baseUrl/Communication/CreateContactUs";
  static String get getUserProfile => "$baseUrl/Pages/GetProfilePage";
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
