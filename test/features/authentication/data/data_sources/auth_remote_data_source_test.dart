import 'package:daily_tasks_test/features/manage_user/data/models/user_model.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../../../helpers/test_helper.mocks.dart';

void main() {
  group('AuthRemoteDataSource', () {
    late MockAuthRemoteDataSource dataSource;
    const email = 'hiba@gmail.com';
    const password = 'Test123*';
    const userName = 'hiba';

    setUp(() {
      dataSource = MockAuthRemoteDataSource();
    });

    const userExample = UserModel(
        email: 'hiba@gmail.com', password: 'Test123*', userName: 'hiba');

    test('login should return unit', () async {
      when(dataSource.login(email, password))
          .thenAnswer((_) async => userExample);
      final result = await dataSource.login(email, password);
      expect(result, userExample);
    });

    test('create account should complete without errors', () async {
      when(dataSource.signUp(
              email: email, password: password, userName: userName))
          .thenAnswer((_) async => unit);

      final result = await dataSource.signUp(
          email: email, password: password, userName: userName);

      expect(result, unit);
    });
  });
}
