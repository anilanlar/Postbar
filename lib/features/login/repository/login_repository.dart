import 'package:postbar/core/base/index.dart';

abstract class ILoginProvider {}

class LoginProvider extends BaseProvider implements ILoginProvider {}

abstract class ILoginRepository {}

class LoginRepository extends BaseRepository<LoginProvider> implements ILoginRepository {
  LoginRepository() : super(provider: LoginProvider());
}
