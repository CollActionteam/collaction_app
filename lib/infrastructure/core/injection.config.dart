// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:http/http.dart' as _i3;
import 'package:injectable/injectable.dart' as _i2;

import '../../application/crowdaction_getter/crowdaction_getter_bloc.dart'
    as _i8;
import '../../domain/crowdaction/i_crowdaction_repository.dart' as _i4;
import '../../domain/user/i_user_repository.dart' as _i6;
import '../crowdaction/crowdaction_repository.dart' as _i5;
import '../user/user_repository.dart' as _i7;
import 'http_singleton.dart' as _i9; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final httpSingleton = _$HttpSingleton();
  gh.lazySingleton<_i3.Client>(() => httpSingleton.client);
  gh.lazySingleton<_i4.ICrowdActionRepository>(
      () => _i5.CrowdActionRepository(get<_i3.Client>()));
  gh.lazySingleton<_i6.IUserRepository>(() => _i7.UserRepository());
  gh.factory<_i8.CrowdActionGetterBloc>(
      () => _i8.CrowdActionGetterBloc(get<_i4.ICrowdActionRepository>()));
  return get;
}

class _$HttpSingleton extends _i9.HttpSingleton {}
