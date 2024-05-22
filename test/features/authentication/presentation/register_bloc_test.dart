import 'package:daily_tasks_test/core/error/failures.dart';
import 'package:daily_tasks_test/core/strings/failures.dart';
import 'package:daily_tasks_test/features/authentication/presentation/bloc/register_bloc/register_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  late RegisterBloc registerBloc;
  late MockRegisterUseCase mockRegisterUseCase;

  setUp(() {
    mockRegisterUseCase = MockRegisterUseCase();

    registerBloc = RegisterBloc(registerUseCase: mockRegisterUseCase);
  });
  String email = 'hiba@gmail.com';
  String password = 'Test123*';
  String userName = 'hiba';

  group('register useCase', () {
    test('should get data from the concrete useCase', () async* {
      //arrange
      when(mockRegisterUseCase(email: any, userName: any, password: any))
          .thenAnswer((_) async => const Right(unit));

      //act
      registerBloc.add(RegisterUserEvent(
          email: email, userName: userName, password: password));
      await untilCalled(
          mockRegisterUseCase(email: any, userName: any, password: any));

      //assert
      verify(mockRegisterUseCase(
          email: email, userName: userName, password: password));
    });

    test(
        'should emits [Loading, Authenticated] when data is gotten successfully',
        () async* {
      //arrange
      when(mockRegisterUseCase(email: any, userName: any, password: any))
          .thenAnswer((_) async => const Right(unit));

      //assert later
      final expected = [
        const RegisterState(error: '', success: false, isLoading: false),
        const RegisterState(error: '', success: false, isLoading: true),
        const RegisterState(error: '', success: true, isLoading: false)
      ];
      expectLater(registerBloc, emitsInOrder(expected));
      //act
      registerBloc.add(RegisterUserEvent(
          email: email, userName: userName, password: password));
    });

    test('should emits [Loading, AuthError] when getting data fails',
        () async* {
      //arrange
      when(mockRegisterUseCase(email: any, userName: any, password: any))
          .thenAnswer((_) async =>
              Left(ServerFailure(message: SERVER_FAILURE_MESSAGE)));

      //assert later
      final expected = [
        const RegisterState(error: '', success: false, isLoading: false),
        const RegisterState(error: '', success: false, isLoading: true),
        RegisterState(
            error: SERVER_FAILURE_MESSAGE, success: false, isLoading: false)
      ];
      expectLater(registerBloc, emitsInOrder(expected));
      //act
      registerBloc.add(RegisterUserEvent(
          email: email, userName: userName, password: password));
    });
  });
}
