part of 'discount_bloc.dart';

abstract class DiscountEvent extends Equatable {
  const DiscountEvent();

  @override
  List<Object> get props => [];
}

class LoadDiscounts extends DiscountEvent {
  final String vendorId;

  const LoadDiscounts({required this.vendorId});

  @override
  List<Object> get props => [vendorId];
}

class AddDiscount extends DiscountEvent {
  final String vendorId;
  final String type;
  final double value;
  final String description;
  final DateTime? startDate;
  final DateTime? endDate;
  final double? minOrderAmount;

  const AddDiscount({
    required this.vendorId,
    required this.type,
    required this.value,
    required this.description,
    this.startDate,
    this.endDate,
    this.minOrderAmount,
  });

  @override
  List<Object> get props => [
        vendorId,
        type,
        value,
        description,
        startDate ?? Object(),
        endDate ?? Object(),
        minOrderAmount ?? Object(),
      ];
}

class UpdateDiscount extends DiscountEvent {
  final String discountId;
  final String type;
  final double value;
  final String description;
  final DateTime? startDate;
  final DateTime? endDate;
  final double? minOrderAmount;
  final bool isActive;

  const UpdateDiscount({
    required this.discountId,
    required this.type,
    required this.value,
    required this.description,
    this.startDate,
    this.endDate,
    this.minOrderAmount,
    required this.isActive,
  });

  @override
  List<Object> get props => [
        discountId,
        type,
        value,
        description,
        startDate ?? Object(),
        endDate ?? Object(),
        minOrderAmount ?? Object(),
        isActive,
      ];
}

class DeleteDiscount extends DiscountEvent {
  final String discountId;

  const DeleteDiscount({required this.discountId});

  @override
  List<Object> get props => [discountId];
}

class ToggleDiscountStatus extends DiscountEvent {
  final String discountId;
  final bool isActive;

  const ToggleDiscountStatus({
    required this.discountId,
    required this.isActive,
  });

  @override
  List<Object> get props => [discountId, isActive];
}
