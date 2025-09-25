part of 'enhanced_discount_bloc.dart';

abstract class EnhancedDiscountState extends Equatable {
  const EnhancedDiscountState();

  @override
  List<Object> get props => [];
}

class EnhancedDiscountInitial extends EnhancedDiscountState {}

class EnhancedDiscountLoading extends EnhancedDiscountState {}

class EnhancedDiscountsLoaded extends EnhancedDiscountState {
  final List<EnhancedDiscountEntity> discounts;

  const EnhancedDiscountsLoaded({required this.discounts});

  @override
  List<Object> get props => [discounts];
}

class ActiveDiscountsLoaded extends EnhancedDiscountState {
  final List<EnhancedDiscountEntity> discounts;

  const ActiveDiscountsLoaded({required this.discounts});

  @override
  List<Object> get props => [discounts];
}

class ComboDealsLoaded extends EnhancedDiscountState {
  final List<EnhancedDiscountEntity> comboDeals;

  const ComboDealsLoaded({required this.comboDeals});

  @override
  List<Object> get props => [comboDeals];
}

class HappyHoursLoaded extends EnhancedDiscountState {
  final List<EnhancedDiscountEntity> happyHours;

  const HappyHoursLoaded({required this.happyHours});

  @override
  List<Object> get props => [happyHours];
}

class BestApplicableDiscountLoaded extends EnhancedDiscountState {
  final EnhancedDiscountEntity? discount;

  const BestApplicableDiscountLoaded({this.discount});

  @override
  List<Object> get props => [discount ?? Object()];
}

class EnhancedDiscountOperationSuccess extends EnhancedDiscountState {
  final String message;
  final List<EnhancedDiscountEntity> discounts;

  const EnhancedDiscountOperationSuccess({
    required this.message,
    required this.discounts,
  });

  @override
  List<Object> get props => [message, discounts];
}

class EnhancedDiscountError extends EnhancedDiscountState {
  final String message;

  const EnhancedDiscountError({required this.message});

  @override
  List<Object> get props => [message];
}
