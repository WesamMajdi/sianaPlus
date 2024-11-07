import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maintenance_app/src/features/client%20app/privacy%20and%20settings/support%20&%20about%20us%20pages/concat%20info%20page/data.dart';
import 'domain.dart';

class ContactUsCubit extends Cubit<ContactUsState> {
  final ApiContactUsService apiService;

  ContactUsCubit(this.apiService) : super(ContactUsInitial());

  Future<void> createContactUs(
      String fullName, String email, String phoneNumber, String message) async {
    try {
      emit(ContactUsLoading());
      final response = await apiService.createContactUs(
          fullName, email, phoneNumber, message);
      emit(ContactUsSuccess(response));
    } catch (e) {
      emit(ContactUsFailure(e.toString()));
    }
  }
}

abstract class ContactUsState {}

class ContactUsInitial extends ContactUsState {}

class ContactUsLoading extends ContactUsState {}

class ContactUsSuccess extends ContactUsState {
  final ContactUsResponse response;
  ContactUsSuccess(this.response);
}

class ContactUsFailure extends ContactUsState {
  final String error;
  ContactUsFailure(this.error);
}
