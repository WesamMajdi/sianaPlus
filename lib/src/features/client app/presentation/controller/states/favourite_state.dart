import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:maintenance_app/src/features/client%20app/domain/entities/product/product_entity.dart';
class FavouriteState extends Equatable {
  List<Product> favouriteProducts;


  FavouriteState({
    this.favouriteProducts = const <Product>[],
  });

  FavouriteState copyWith(
      {
        List<Product>? favouriteProducts
}) {
    return FavouriteState(
      favouriteProducts: favouriteProducts?? this.favouriteProducts

    );
  }

  @override
  List<Object?> get props => [
    favouriteProducts
  ];
}
