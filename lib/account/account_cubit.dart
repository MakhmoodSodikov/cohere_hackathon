import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:video_club/account/account_states.dart';

class AccountCubit extends Cubit<AccountState> {
  AccountCubit() : super(InitState());

  Future<bool> verifyTwitterAccount(String username) async {
    emit(LoadingState(account: username));
    try {
      final response =
          await http.get(Uri.parse('https://twitter.com/$username'));
      print(response.body);
      final exists = response.statusCode == 200;
      if (exists) {
        print('$username exists');
      } else {
        print('$username does not exists');
      }
      emit(LoadedState(success: exists));
      return exists;
    } catch (e) {
      print('Something went wrong while checking twitter account: $e');
      return false;
    }
  }
}
