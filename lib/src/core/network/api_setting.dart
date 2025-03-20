class ApiSetting {
  static String get baseUrl => 'http://ebrahim995-001-site3.ktempurl.com/api';

// authentication
  static String get login => '$baseUrl/account/login';
  static String get signup => '$baseUrl/account/registerCustomer';
  static String get updatePassword => '$baseUrl/account/ChangePassword';
  static String get updateEmail => '$baseUrl/account/ChangeEmail';
  static String get forgotPassword => '$baseUrl/account/SendVerificationCode';
  static String get resetPassword => '$baseUrl/account/VerifyCode';

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

  static String get getOrderMaintenanceByUserNew =>
      '$baseUrl/OrderMaintenances/GetOrderMaintenanceByUserNew';
  static String get getOrderMaintenanceByUserOld =>
      '$baseUrl/OrderMaintenances/getOrderMaintenanceByUserOld';

  static String get getAllHandReceiptItems =>
      '$baseUrl/Maintenances/GetAllHandReceiptItems';

  static String get getHandReceiptItem =>
      '$baseUrl/Maintenances/GetHandReceiptItem';

  static String get updateStatusForHandReceiptItem =>
      '$baseUrl/Maintenances/UpdateStatusForHandReceiptItem';

  static String get defineMalfunctionForHandReceiptItem =>
      '$baseUrl/Maintenances/DefineMalfunctionForHandReceiptItem';

  static String get enterMaintenanceCostForHandReceiptItem =>
      '$baseUrl/Maintenances/EnterMaintenanceCostForHandReceiptItem';

  static String get suspendMaintenanceForHandReceiptItem =>
      "$baseUrl/Maintenances/SuspenseMaintenanceForHandReceiptItem";

  static String get reOpenMaintenanceForHandReceiptItem =>
      "$baseUrl/Maintenances/ReOpenMaintenanceForHandReceiptItem";
  ///////////////////////////////////////////////////
  static String get getAllReturnHandReceiptItems =>
      '$baseUrl/Maintenances/GetAllReturnHandReceiptItems';

  static String get getReturnHandReceiptItem =>
      '$baseUrl/Maintenances/GetReturnHandReceiptItem';

  static String get updateStatusForReturnHandReceiptItem =>
      '$baseUrl/Maintenances/UpdateStatusForReturnHandReceiptItem';

  static String get customerRefuseMaintenanceForReturnHandReceiptItem =>
      '$baseUrl/Maintenances/CustomerRefuseMaintenanceForReturnHandReceiptItem';

  static String get suspenseMaintenanceForReturnHandReceiptItem =>
      '$baseUrl/Maintenances/SuspenseMaintenanceForReturnHandReceiptItem';

  static String get reOpenMaintenanceForReturnHandReceiptItem =>
      '$baseUrl/Maintenances/ReOpenMaintenanceForReturnHandReceiptItem';

  static String get enterMaintenanceCostForReturnHandReceiptItem =>
      '$baseUrl/Maintenances/EnterMaintenanceCostForReturnHandReceiptItem';

  static String get defineMalfunctionForReturnHandReceiptItem =>
      '$baseUrl/Maintenances/DefineMalfunctionForReturnHandReceiptItem';

  static String get createContactUs => "$baseUrl/Communication/CreateContactUs";

  static String get getUserProfile => "$baseUrl/Pages/GetProfilePage";

  static String get getAllForAllDelivery =>
      "$baseUrl/Orders/GetAllForAllDelivery";
  static String get getAllItemByOrder => "$baseUrl/Orders/GetAllItemByOrder";
  static String get takeOrder => "$baseUrl/Orders/TakeOrder";
  static String get getAllTakeDelivery => "$baseUrl/Orders/GetAllTakeDelivery";

  static String get getAllTakePerviousOrder =>
      "$baseUrl/Orders/GetAllForDelivery";

  static String get updateStatusForOrder =>
      "$baseUrl/Orders/UpdateStatusForOrder";

  static String get getAllForAllDeliveryMaintenance =>
      "$baseUrl/OrderMaintenances/GetAllForAllDelivery";
  static String get getAllTakeDeliveryMaintenance =>
      "$baseUrl/OrderMaintenances/GetAllTakeDelivery";

  static String get getAllTakePerviousMaintenanceOrder =>
      "$baseUrl/OrderMaintenances/GetAllForDelivery";
  static String get takeOrderMaintenance =>
      "$baseUrl/OrderMaintenances/TakeOrderMaintenance";

  static String get updateOrderMaintenance =>
      "$baseUrl/OrderMaintenances/UpdateOrderMaintenance";

  static String get getOrderMaintenanceItem =>
      '$baseUrl/OrderMaintenances/GetOrderMaintenanceItem';

  static String get getBranchList => '$baseUrl/List/GetBranchList';
  static String get updateBranch => '$baseUrl/OrderMaintenances/SelectBranch';

  static String get getAllOnlineItems =>
      '$baseUrl/Maintenances/GetAllHandReceiptItemsOnline';
  static String get getOnlineItem => '$baseUrl/Maintenances/GetHandReceiptItem';
  static String get updateStatusForOnlineItem =>
      '$baseUrl/Maintenances/UpdateStatusForOnlineItem';
  static String get defineMalfunctionForOnlineItem =>
      '$baseUrl/Maintenances/DefineMalfunctionForOnlineItem';

  static String get enterMaintenanceCostForOnlineItem =>
      '$baseUrl/Maintenances/EnterMaintenanceCostForOnlineItem';
  static String get getAllForAllDeliveryTransfer =>
      '$baseUrl/Convert/GetAllForAllDelivery';
  static String get updateOrderTransfer =>
      "$baseUrl/Convert/UpdateOrderMaintenance";
  static String get takeOrderTransfer =>
      "$baseUrl/Convert/TakeOrderMaintenance";
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
