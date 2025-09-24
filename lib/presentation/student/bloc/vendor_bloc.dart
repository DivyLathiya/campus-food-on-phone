import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:campus_food_app/domain/entities/vendor_entity.dart';
import 'package:campus_food_app/domain/repositories/vendor_repository.dart';

part 'vendor_event.dart';
part 'vendor_state.dart';

class VendorBloc extends Bloc<VendorEvent, VendorState> {
  final VendorRepository vendorRepository;

  VendorBloc({required this.vendorRepository}) : super(const VendorInitial()) {
    on<LoadVendors>(_onLoadVendors);
  }

  Future<void> _onLoadVendors(
      LoadVendors event,
      Emitter<VendorState> emit,
      ) async {
    emit(const VendorLoading());
    try {
      final vendors = await vendorRepository.getVendors();
      emit(VendorsLoaded(vendors: vendors));
    } catch (e) {
      emit(VendorError(message: e.toString()));
    }
  }
}