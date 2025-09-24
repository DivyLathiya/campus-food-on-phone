class AppConstants {
  static const String appName = 'Campus Food App';
  static const String appVersion = '1.0.0';
  
  // User Roles
  static const String roleStudent = 'student';
  static const String roleVendor = 'vendor';
  static const String roleAdmin = 'admin';
  
  // Order Status
  static const String orderPending = 'pending';
  static const String orderAccepted = 'accepted';
  static const String orderPreparing = 'preparing';
  static const String orderReady = 'ready';
  static const String orderCompleted = 'completed';
  static const String orderCancelled = 'cancelled';
  
  // Vendor Status
  static const String vendorOpen = 'open';
  static const String vendorClosed = 'closed';
  static const String vendorPendingApproval = 'pending_approval';
  
  // Transaction Types
  static const String transactionCredit = 'credit';
  static const String transactionDebit = 'debit';
  
  // Transaction Status
  static const String transactionSuccess = 'success';
  static const String transactionFailed = 'failed';
  static const String transactionPending = 'pending';
  
  // Discount Types
  static const String discountPercentage = 'percentage';
  static const String discountFixed = 'fixed';
}
