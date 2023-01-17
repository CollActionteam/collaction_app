import 'package:bloc_test/bloc_test.dart';
import 'package:collaction_app/application/user/profile_tab/profile_tab_bloc.dart';

class MockProfileTabBloc extends MockBloc<ProfileTabEvent, ProfileTabState>
    implements ProfileTabBloc {}
