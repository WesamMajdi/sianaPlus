//
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:maintenance_app/src/features/client%20app/data/model/orders/color_entery.dart';
// import 'package:maintenance_app/src/features/client%20app/data/model/orders/orders_model_request.dart';
// import 'package:maintenance_app/src/features/client%20app/domain/usecases/orders/fetch_orders_useCase.dart';
// import 'package:maintenance_app/src/features/client%20app/presentation/controller/states/favourite_state.dart';
//
// import '../../../../../core/pagination/pagination_params.dart';
// import '../../../domain/entities/orders/orders_entity.dart';
// import '../../../domain/entities/product/product_entity.dart';
// import '../states/order_state.dart';
//
// class FavouriteCubit extends Cubit<FavouriteState> {
//
//   FavouriteCubit()
//       : super(FavouriteState());
//
//   void toggleFavorite(int productId) {
//     state.favouriteProducts = state.favouriteProducts.map((product) {
//       if (product.id == productId) {
//         return Product(
//           isFavorite: !product.isFavorite,
//         );
//       }
//       return product;
//     }).toList();
//
//     emit(FavoriteLoaded(products)); // Emit updated state
//   }
//   }
//
//
// }
