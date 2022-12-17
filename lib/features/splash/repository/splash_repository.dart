import 'package:postbar/core/base/index.dart';

abstract class ISplashProvider {}

class SplashProvider extends BaseProvider implements ISplashProvider {}

abstract class ISplashRepository {}

class SplashRepository extends BaseRepository<SplashProvider> implements ISplashRepository {
  SplashRepository() : super(provider: SplashProvider());
}
