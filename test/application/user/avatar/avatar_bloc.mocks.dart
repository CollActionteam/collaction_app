import 'package:bloc_test/bloc_test.dart';
import 'package:collaction_app/application/user/avatar/avatar_bloc.dart';

class MockAvatarBloc extends MockBloc<AvatarEvent, AvatarState>
    implements AvatarBloc {}
