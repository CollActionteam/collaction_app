abstract class ProfileFailure {
  const ProfileFailure();

  const factory ProfileFailure.unexpected() = Unexpected;
  const factory ProfileFailure.noUser() = NoUser;
}

class Unexpected extends ProfileFailure {
  const Unexpected();
}

class NoUser extends ProfileFailure {
  const NoUser();
}
