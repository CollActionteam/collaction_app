import 'package:bloc_test/bloc_test.dart';
import 'package:collaction_app/application/user/profile/profile_bloc.dart';

class MockProfileBloc extends MockBloc<ProfileEvent, ProfileState>
    implements ProfileBloc {}
