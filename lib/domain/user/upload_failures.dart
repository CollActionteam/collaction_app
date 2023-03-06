abstract class UploadPathFailure {
  const UploadPathFailure();

  const factory UploadPathFailure.unexpected() = Unexpected;
}

class Unexpected extends UploadPathFailure {
  const Unexpected();
}

abstract class UploadFailure {
  const UploadFailure();

  const factory UploadFailure.uploadFailed() = UploadFailed;
}

class UploadFailed extends UploadFailure {
  const UploadFailed();
}
