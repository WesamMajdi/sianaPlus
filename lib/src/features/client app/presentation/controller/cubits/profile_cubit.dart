import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maintenance_app/src/features/client%20app/domain/usecases/profile/fetch_profile_useCase.dart';
import '../states/profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final FetchProfileUseCase profileUseCase;

  ProfileCubit(this.profileUseCase) : super(ProfileState());

  Future<void> getUserProfile() async {
    emit(state.copyWith(profileStatus: ProfileStatus.loading));

    final result = await profileUseCase.call();

    result.fold(
      (failure) => emit(state.copyWith(
          profileStatus: ProfileStatus.failure, errorMessage: failure.message)),
      (profile) => emit(state.copyWith(
        profileStatus: ProfileStatus.success,
        name: profile.fullName,
        email: profile.email,
        phone: profile.phoneNumber,
        errorMessage: null,
        orderMaintenancesCount: profile.orderMaintenancesCount,
        orderShopCount: profile.orderShopCount,
        orderShopNewCount: profile.orderShopNewCount,
        orderMaintenancesNewCount: profile.orderMaintenancesNewCount,
      )),
    );
  }

  Future<void> createProblem(String text) async {
    emit(state.copyWith(problemStatus: ProblemStatus.loading));

    final result = await profileUseCase.createProblem(text);

    result.fold(
      (failure) => emit(state.copyWith(
        problemStatus: ProblemStatus.failure,
        errorMessage: failure.message,
      )),
      (_) => emit(state.copyWith(
        problemStatus: ProblemStatus.success,
      )),
    );
  }
}
