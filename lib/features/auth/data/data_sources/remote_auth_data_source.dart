abstract class RemoteAuthDataSource {
  Future<bool> loggedIn();
}

class RemoteAuthDataSourceImpl implements RemoteAuthDataSource {
  RemoteAuthDataSourceImpl();

  @override
  Future<bool> loggedIn() {
    throw UnimplementedError();
  }
}
