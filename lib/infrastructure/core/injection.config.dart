// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:firebase_auth/firebase_auth.dart' as _i4;
import 'package:get_it/get_it.dart' as _i1;
import 'package:http/http.dart' as _i3;
import 'package:injectable/injectable.dart' as _i2;

import '../../application/crowdaction_getter/crowdaction_getter_bloc.dart'
    as _i9;
import '../../domain/crowdaction/i_crowdaction_repository.dart' as _i5;
import '../../domain/user/i_user_repository.dart' as _i7;
import '../crowdaction/crowdaction_repository.dart' as _i6;
import '../user/user_repository.dart' as _i8;
import 'firebase_auth_singleton.dart' as _i11;
import 'http_singleton.dart' as _i10; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final httpSingleton = _$HttpSingleton();
  final firebaseAuthSingleton = _$FirebaseAuthSingleton();
  gh.lazySingleton<_i3.Client>(() => httpSingleton.client);
  gh.lazySingleton<_i4.FirebaseAuth>(() => firebaseAuthSingleton.firebaseAuth);
  gh.lazySingleton<_i5.ICrowdActionRepository>(
      () => _i6.CrowdActionRepository(get<_i3.Client>()));
  gh.lazySingleton<_i7.IUserRepository>(
      () => _i8.UserRepository(firebaseAuth: get<_i4.FirebaseAuth>()));
  gh.factory<_i9.CrowdActionGetterBloc>(
      () => _i9.CrowdActionGetterBloc(get<_i5.ICrowdActionRepository>()));
  return get;
}

class _$HttpSingleton extends _i10.HttpSingleton {}

class _$FirebaseAuthSingleton extends _i11.FirebaseAuthSingleton {}
