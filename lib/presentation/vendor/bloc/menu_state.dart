part of 'menu_bloc.dart';

abstract class MenuState extends Equatable {
  const MenuState();

  @override
  List<Object> get props => [];
}

class MenuInitial extends MenuState {}

class MenuLoading extends MenuState {}

class MenuLoaded extends MenuState {
  final List<MenuItemEntity> menuItems;

  const MenuLoaded({required this.menuItems});

  @override
  List<Object> get props => [menuItems];
}

class MenuOperationSuccess extends MenuState {
  final String message;
  final List<MenuItemEntity> menuItems;

  const MenuOperationSuccess({
    required this.message,
    required this.menuItems,
  });

  @override
  List<Object> get props => [message, menuItems];
}

class MenuError extends MenuState {
  final String message;

  const MenuError({required this.message});

  @override
  List<Object> get props => [message];
}
