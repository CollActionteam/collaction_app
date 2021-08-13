// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:http/http.dart' as _i3;
import 'package:injectable/injectable.dart' as _i2;

import '../../application/crowdaction_getter/crowdaction_getter_bloc.dart'
    as _i6;
import '../../domain/crowdaction/i_crowdaction_repository.dart' as _i4;
import '../crowdaction/crowdaction_repository.dart' as _i5;
import 'http_singleton.dart' as _i7; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final httpSingleton = _$HttpSingleton();
  gh.lazySingleton<_i3.Client>(() => httpSingleton.client);
  gh.lazySingleton<_i4.ICrowdActionRepository>(
      () => _i5.CrowdActionRepository());
  gh.factory<_i6.CrowdActionGetterBloc>(
      () => _i6.CrowdActionGetterBloc(get<_i4.ICrowdActionRepository>()));
  return get;
}

class _$HttpSingleton extends _i7.HttpSingleton {}
