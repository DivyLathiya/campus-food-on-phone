part of 'vendor_bloc.dart';

abstract class VendorState extends Equatable {
  const VendorState();

  @override
  List<Object> get props => [];
}

class VendorInitial extends VendorState {
  const VendorInitial();
}

class VendorLoading extends VendorState {
  const VendorLoading();
}

class VendorsLoaded extends VendorState {
  final List<VendorEntity> vendors;

  const VendorsLoaded({required this.vendors});

  @override
  List<Object> get props => [vendors];
}

class VendorError extends VendorState {
  final String message;

  const VendorError({required this.message});

  @override
  List<Object> get props => [message];
}