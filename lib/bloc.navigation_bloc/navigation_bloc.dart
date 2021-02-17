import 'package:bloc/bloc.dart';
import 'package:swiftdynamics/myScreen/myCalculator.dart';
import 'package:swiftdynamics/myScreen/myTodolist.dart';
import 'package:swiftdynamics/myScreen/myUserslist.dart';

enum NavigationEvents {
  MyUserListClickedEvent,
  MyCalculatorClickedEvent,
  MyTodoListClickedEvent,
}

abstract class NavigationStates {}

class NavigationBloc extends Bloc<NavigationEvents, NavigationStates> {
  @override
  NavigationStates get initialState => MyUserList();

  @override
  Stream<NavigationStates> mapEventToState(NavigationEvents event) async* {
    switch (event) {
      case NavigationEvents.MyUserListClickedEvent:
        yield MyUserList();
        break;
      case NavigationEvents.MyCalculatorClickedEvent:
        yield MyCalculator();
        break;
      case NavigationEvents.MyTodoListClickedEvent:
        yield MyTodoList();
        break;
    }
  }
}
