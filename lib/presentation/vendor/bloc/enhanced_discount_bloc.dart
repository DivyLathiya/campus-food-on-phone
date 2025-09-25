import 'package:bloc/bloc.dart';
import 'package:campus_food_app/domain/entities/enhanced_discount_entity.dart';
import 'package:campus_food_app/domain/repositories/enhanced_discount_repository.dart';
import 'package:equatable/equatable.dart';

part 'enhanced_discount_event.dart';
part 'enhanced_discount_state.dart';

class EnhancedDiscountBloc extends Bloc<EnhancedDiscountEvent, EnhancedDiscountState> {
  final EnhancedDiscountRepository enhancedDiscountRepository;

  EnhancedDiscountBloc({required this.enhancedDiscountRepository}) : super(EnhancedDiscountInitial()) {
    on<LoadEnhancedDiscounts>(_onLoadEnhancedDiscounts);
    on<LoadActiveDiscounts>(_onLoadActiveDiscounts);
    on<LoadComboDeals>(_onLoadComboDeals);
    on<LoadHappyHours>(_onLoadHappyHours);
    on<AddEnhancedDiscount>(_onAddEnhancedDiscount);
    on<UpdateEnhancedDiscount>(_onUpdateEnhancedDiscount);
    on<DeleteEnhancedDiscount>(_onDeleteEnhancedDiscount);
    on<ToggleEnhancedDiscountStatus>(_onToggleEnhancedDiscountStatus);
    on<GetBestApplicableDiscount>(_onGetBestApplicableDiscount);
  }

  Future<void> _onLoadEnhancedDiscounts(
    LoadEnhancedDiscounts event,
    Emitter<EnhancedDiscountState> emit,
  ) async {
    emit(EnhancedDiscountLoading());
    try {
      final discounts = await enhancedDiscountRepository.getDiscountsByVendor(event.vendorId);
      emit(EnhancedDiscountsLoaded(discounts: discounts));
    } catch (e) {
      emit(EnhancedDiscountError(message: 'Failed to load discounts: ${e.toString()}'));
    }
  }

  Future<void> _onLoadActiveDiscounts(
    LoadActiveDiscounts event,
    Emitter<EnhancedDiscountState> emit,
  ) async {
    emit(EnhancedDiscountLoading());
    try {
      final discounts = await enhancedDiscountRepository.getActiveDiscounts(event.vendorId);
      emit(ActiveDiscountsLoaded(discounts: discounts));
    } catch (e) {
      emit(EnhancedDiscountError(message: 'Failed to load active discounts: ${e.toString()}'));
    }
  }

  Future<void> _onLoadComboDeals(
    LoadComboDeals event,
    Emitter<EnhancedDiscountState> emit,
  ) async {
    emit(EnhancedDiscountLoading());
    try {
      final comboDeals = await enhancedDiscountRepository.getComboDeals(event.vendorId);
      emit(ComboDealsLoaded(comboDeals: comboDeals));
    } catch (e) {
      emit(EnhancedDiscountError(message: 'Failed to load combo deals: ${e.toString()}'));
    }
  }

  Future<void> _onLoadHappyHours(
    LoadHappyHours event,
    Emitter<EnhancedDiscountState> emit,
  ) async {
    emit(EnhancedDiscountLoading());
    try {
      final happyHours = await enhancedDiscountRepository.getHappyHours(event.vendorId);
      emit(HappyHoursLoaded(happyHours: happyHours));
    } catch (e) {
      emit(EnhancedDiscountError(message: 'Failed to load happy hours: ${e.toString()}'));
    }
  }

  Future<void> _onAddEnhancedDiscount(
    AddEnhancedDiscount event,
    Emitter<EnhancedDiscountState> emit,
  ) async {
    try {
      final newDiscount = EnhancedDiscountEntity(
        discountId: '',
        vendorId: event.vendorId,
        type: event.type,
        value: event.value,
        description: event.description,
        startDate: event.startDate,
        endDate: event.endDate,
        minOrderAmount: event.minOrderAmount,
        isActive: true,
        requiredMenuItemIds: event.requiredMenuItemIds,
        comboPrice: event.comboPrice,
        comboName: event.comboName,
        happyHourDays: event.happyHourDays,
        happyHourStartTime: event.happyHourStartTime,
        happyHourEndTime: event.happyHourEndTime,
        happyHourDiscountRate: event.happyHourDiscountRate,
        maxUsageCount: event.maxUsageCount,
        currentUsageCount: 0,
        applicableCategories: event.applicableCategories,
      );

      final validationError = newDiscount.validate();
      if (validationError != null) {
        emit(EnhancedDiscountError(message: validationError));
        return;
      }

      final addedDiscount = await enhancedDiscountRepository.addDiscount(newDiscount);
      final updatedDiscounts = await enhancedDiscountRepository.getDiscountsByVendor(event.vendorId);
      
      emit(EnhancedDiscountOperationSuccess(
        message: 'Discount added successfully',
        discounts: updatedDiscounts,
      ));
    } catch (e) {
      emit(EnhancedDiscountError(message: 'Failed to add discount: ${e.toString()}'));
    }
  }

  Future<void> _onUpdateEnhancedDiscount(
    UpdateEnhancedDiscount event,
    Emitter<EnhancedDiscountState> emit,
  ) async {
    try {
      final existingDiscount = await enhancedDiscountRepository.getDiscountById(event.discountId);
      if (existingDiscount != null) {
        final updatedDiscount = EnhancedDiscountEntity(
          discountId: event.discountId,
          vendorId: existingDiscount.vendorId,
          type: event.type,
          value: event.value,
          description: event.description,
          startDate: event.startDate,
          endDate: event.endDate,
          minOrderAmount: event.minOrderAmount,
          isActive: existingDiscount.isActive,
          requiredMenuItemIds: event.requiredMenuItemIds,
          comboPrice: event.comboPrice,
          comboName: event.comboName,
          happyHourDays: event.happyHourDays,
          happyHourStartTime: event.happyHourStartTime,
          happyHourEndTime: event.happyHourEndTime,
          happyHourDiscountRate: event.happyHourDiscountRate,
          maxUsageCount: event.maxUsageCount,
          currentUsageCount: existingDiscount.currentUsageCount,
          applicableCategories: event.applicableCategories,
        );

        final validationError = updatedDiscount.validate();
        if (validationError != null) {
          emit(EnhancedDiscountError(message: validationError));
          return;
        }

        await enhancedDiscountRepository.updateDiscount(updatedDiscount);
        final updatedDiscounts = await enhancedDiscountRepository.getDiscountsByVendor(existingDiscount.vendorId);
        
        emit(EnhancedDiscountOperationSuccess(
          message: 'Discount updated successfully',
          discounts: updatedDiscounts,
        ));
      } else {
        emit(const EnhancedDiscountError(message: 'Discount not found'));
      }
    } catch (e) {
      emit(EnhancedDiscountError(message: 'Failed to update discount: ${e.toString()}'));
    }
  }

  Future<void> _onDeleteEnhancedDiscount(
    DeleteEnhancedDiscount event,
    Emitter<EnhancedDiscountState> emit,
  ) async {
    try {
      final existingDiscount = await enhancedDiscountRepository.getDiscountById(event.discountId);
      if (existingDiscount != null) {
        await enhancedDiscountRepository.deleteDiscount(event.discountId);
        final updatedDiscounts = await enhancedDiscountRepository.getDiscountsByVendor(existingDiscount.vendorId);
        
        emit(EnhancedDiscountOperationSuccess(
          message: 'Discount deleted successfully',
          discounts: updatedDiscounts,
        ));
      } else {
        emit(const EnhancedDiscountError(message: 'Discount not found'));
      }
    } catch (e) {
      emit(EnhancedDiscountError(message: 'Failed to delete discount: ${e.toString()}'));
    }
  }

  Future<void> _onToggleEnhancedDiscountStatus(
    ToggleEnhancedDiscountStatus event,
    Emitter<EnhancedDiscountState> emit,
  ) async {
    try {
      final existingDiscount = await enhancedDiscountRepository.getDiscountById(event.discountId);
      if (existingDiscount != null) {
        final updatedDiscount = EnhancedDiscountEntity(
          discountId: event.discountId,
          vendorId: existingDiscount.vendorId,
          type: existingDiscount.type,
          value: existingDiscount.value,
          description: existingDiscount.description,
          startDate: existingDiscount.startDate,
          endDate: existingDiscount.endDate,
          minOrderAmount: existingDiscount.minOrderAmount,
          isActive: event.isActive,
          requiredMenuItemIds: existingDiscount.requiredMenuItemIds,
          comboPrice: existingDiscount.comboPrice,
          comboName: existingDiscount.comboName,
          happyHourDays: existingDiscount.happyHourDays,
          happyHourStartTime: existingDiscount.happyHourStartTime,
          happyHourEndTime: existingDiscount.happyHourEndTime,
          happyHourDiscountRate: existingDiscount.happyHourDiscountRate,
          maxUsageCount: existingDiscount.maxUsageCount,
          currentUsageCount: existingDiscount.currentUsageCount,
          applicableCategories: existingDiscount.applicableCategories,
        );

        await enhancedDiscountRepository.updateDiscount(updatedDiscount);
        final updatedDiscounts = await enhancedDiscountRepository.getDiscountsByVendor(existingDiscount.vendorId);
        
        emit(EnhancedDiscountOperationSuccess(
          message: 'Discount status updated successfully',
          discounts: updatedDiscounts,
        ));
      } else {
        emit(const EnhancedDiscountError(message: 'Discount not found'));
      }
    } catch (e) {
      emit(EnhancedDiscountError(message: 'Failed to toggle discount status: ${e.toString()}'));
    }
  }

  Future<void> _onGetBestApplicableDiscount(
    GetBestApplicableDiscount event,
    Emitter<EnhancedDiscountState> emit,
  ) async {
    try {
      final bestDiscount = await enhancedDiscountRepository.getBestApplicableDiscount(
        event.vendorId,
        event.orderAmount,
        event.menuItemIds,
        event.categories,
      );
      emit(BestApplicableDiscountLoaded(discount: bestDiscount));
    } catch (e) {
      emit(EnhancedDiscountError(message: 'Failed to get best applicable discount: ${e.toString()}'));
    }
  }
}
