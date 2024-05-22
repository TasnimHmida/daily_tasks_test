import 'package:daily_tasks_test/core/error/exception.dart';
import 'package:daily_tasks_test/core/error/failures.dart';
import 'package:daily_tasks_test/features/authentication/data/repositories/auth_repository_impl.dart';
import 'package:daily_tasks_test/features/manage_user/data/models/user_model.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late AuthRepositoryImpl repository;
  late MockAuthRemoteDataSource mockRemoteDataSource;
  late MockNetworkInfo mockNetworkInfo;
  const email = 'hiba@gmail.com';
  const password = 'Test123*';
  const userName = 'hiba';
  const userExample = UserModel(
      email: 'hiba@gmail.com', password: 'Test123*', userName: 'hiba');

  setUp(() {
    mockRemoteDataSource = MockAuthRemoteDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = AuthRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  void runTestsOnline(Function body) {
    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });
      body();
    });
  }

  ////////////////////////////////////////////////////////////////////////////////////////////////
  group('login', () {
    test('should check if the device is online', () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);

      when(mockRemoteDataSource.login(
        email,
        password,
      )).thenAnswer((_) async => userExample);

      // act
      await repository.login(
        email,
        password,
      );

      // assert
      verify(mockNetworkInfo.isConnected);
      verify(mockRemoteDataSource.login(
        email,
        password,
      ));
    });

    runTestsOnline(() {
      test(
          'should return remote data when the call to remote data source is successful',
          () async {
        /// arrange
        when(mockRemoteDataSource.login(
          email,
          password,
        )).thenAnswer((_) async => userExample);

        /// act
        final result = await repository.login(
          email,
          password,
        );

        /// assert
        verify(mockRemoteDataSource.login(
          email,
          password,
        ));
        expect(result, equals(const Right(userExample)));
      });

      test(
          'should return server failure when the call to remote data source is unsuccessful',
          () async {
        /// arrange
        when(mockRemoteDataSource.login(
          email,
          password,
        )).thenThrow(ServerException(message: 'server exception'));

        /// act
        final result = await repository.login(
          email,
          password,
        );

        /// assert
        verify(mockRemoteDataSource.login(
          email,
          password,
        ));

        expect(
            result, equals(Left(ServerFailure(message: 'server exception'))));
      });
    });
  }); ////////////////////////////////////////////////////////////////////////////////////////////////
  group('get createAccount response', () {
    test('should check if the device is online', () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);

      when(mockRemoteDataSource.signUp(
              email: email, userName: userName, password: password))
          .thenAnswer((_) async => unit);

      // act
      await repository.register(
          email: email, userName: userName, password: password);

      // assert
      verify(mockNetworkInfo.isConnected);
      verify(mockRemoteDataSource.signUp(
          email: email, userName: userName, password: password));
    });

    runTestsOnline(() {
      test(
          'should return remote data when the call to remote data source is successful',
          () async {
        /// arrange
        when(mockRemoteDataSource.signUp(
                email: email, userName: userName, password: password))
            .thenAnswer((_) async => unit);

        /// act
        final result = await repository.register(
            email: email, userName: userName, password: password);

        /// assert
        verify(mockRemoteDataSource.signUp(
            email: email, userName: userName, password: password));
        expect(result, equals(const Right(unit)));
      });

      test(
          'should return server failure when the call to remote data source is unsuccessful',
          () async {
        /// arrange
        when(mockRemoteDataSource.signUp(
                email: email, userName: userName, password: password))
            .thenThrow(ServerException(message: 'server exception'));

        /// act
        final result = await repository.register(
            email: email, userName: userName, password: password);

        /// assert
        verify(mockRemoteDataSource.signUp(
            email: email, userName: userName, password: password));

        expect(
            result, equals(Left(ServerFailure(message: 'server exception'))));
      });
    });
  });
}
