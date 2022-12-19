import 'package:bloc_test/bloc_test.dart';
import 'package:collaction_app/application/username/username_bloc.dart';

class MockUsernameBloc extends MockBloc<UsernameEvent, UsernameState>
    implements UsernameBloc {}
