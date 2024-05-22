import 'package:daily_tasks_test/core/error/failures.dart';
import 'package:daily_tasks_test/core/strings/failures.dart';
import 'package:daily_tasks_test/features/authentication/presentation/bloc/login_bloc/login_bloc.dart';
import 'package:daily_tasks_test/features/manage_user/data/models/user_model.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late LoginBloc loginBloc;
  late MockLoginUseCase mockLoginUseCase;

  setUp(() {
    mockLoginUseCase = MockLoginUseCase();

    loginBloc = LoginBloc(
      loginUseCase: mockLoginUseCase,
    );
  });

  const userExample = UserModel(
      email: 'hiba@gmail.com', password: 'Test123*', userName: 'hiba');

  group('login useCase', () {
    String email = 'hiba@gmail.com';
    String password = 'Test123*';

    test('should get data from the concrete useCase', () async* {
      //arrange
      when(mockLoginUseCase(any, any))
          .thenAnswer((_) async => const Right(userExample));

      //act
      loginBloc.add(LoginUserEvent(email: email, password: password));
      await untilCalled(mockLoginUseCase(any, any));

      //assert
      verify(mockLoginUseCase( email, password));
    });

    test(
        'should emits [Loading, Authenticated] when data is gotten successfully',
        () async* {
      //arrange
      when(mockLoginUseCase(any,  any))
          .thenAnswer((_) async => const Right(userExample));

      //assert later
      final expected = [
        const LoginState(error: '', success: false, isLoading: false),
        const LoginState(error: '', success: false, isLoading: true),
        const LoginState(error: '', success: true, isLoading: false)
      ];
      expectLater(loginBloc, emitsInOrder(expected));
      //act
      loginBloc.add(LoginUserEvent(email: email, password: password));
    });

    test('should emits [Loading, AuthError] when getting data fails',
        () async* {
      //arrange
      when(mockLoginUseCase(any,  any)).thenAnswer(
          (_) async => Left(ServerFailure(message: SERVER_FAILURE_MESSAGE)));

      //assert later
      final expected = [
        const LoginState(error: '', success: false, isLoading: false),
        const LoginState(error: '', success: false, isLoading: true),
        LoginState(
            error: SERVER_FAILURE_MESSAGE, success: false, isLoading: false)
      ];
      expectLater(loginBloc, emitsInOrder(expected));
      //act
      loginBloc.add(LoginUserEvent(email: email, password: password));
    });
  });
}
