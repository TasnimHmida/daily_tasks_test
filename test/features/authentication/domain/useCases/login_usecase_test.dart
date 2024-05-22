import 'package:daily_tasks_test/features/authentication/domain/use_cases/login_usecase.dart';
import 'package:daily_tasks_test/features/manage_user/data/models/user_model.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late MockAuthRepository mockAuthRepository;
  late LoginUseCase loginUseCase;
  const loginParams =
  {'email': 'hiba@gmail.com', 'password': 'Test123*'};

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    loginUseCase = LoginUseCase(repository: mockAuthRepository);
  });

  const userExample = UserModel(email: 'hiba@gmail.com', password: 'Test123*', userName: 'hiba');

  test("should get login from the repository", () async {
    /// arrange
    when(mockAuthRepository.login(loginParams['email'], loginParams['password']))
        .thenAnswer((_) async => const Right(userExample));

    /// act
    final result = await loginUseCase.call(loginParams['email']!, loginParams['password']!);

    /// assert
    expect(result, equals(const Right(userExample)));
  });
}
