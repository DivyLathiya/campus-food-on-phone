import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:campus_food_app/domain/entities/sales_report_entity.dart';
import 'package:campus_food_app/presentation/vendor/bloc/sales_report_bloc.dart';
import 'package:intl/intl.dart';

class SalesReportsScreen extends StatefulWidget {
  final String vendorId;

  const SalesReportsScreen({
    Key? key,
    required this.vendorId,
  }) : super(key: key);

  @override
  State<SalesReportsScreen> createState() => _SalesReportsScreenState();
}

class _SalesReportsScreenState extends State<SalesReportsScreen> with TickerProviderStateMixin {
  late TabController _tabController;
  DateTime _selectedDate = DateTime.now();
  String _selectedPeriod = 'Daily';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _loadInitialData();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _loadInitialData() {
    context.read<SalesReportBloc>().add(LoadSalesSummary(vendorId: widget.vendorId));
    _loadReportData();
  }

  void _loadReportData() {
    switch (_selectedPeriod) {
      case 'Daily':
        context.read<SalesReportBloc>().add(LoadDailyReport(
          vendorId: widget.vendorId,
          date: _selectedDate,
        ));
        break;
      case 'Weekly':
        final weekStart = _selectedDate.subtract(Duration(days: _selectedDate.weekday - 1));
        context.read<SalesReportBloc>().add(LoadWeeklyReport(
          vendorId: widget.vendorId,
          weekStart: weekStart,
        ));
        break;
      case 'Monthly':
        final month = DateTime(_selectedDate.year, _selectedDate.month, 1);
        context.read<SalesReportBloc>().add(LoadMonthlyReport(
          vendorId: widget.vendorId,
          month: month,
        ));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sales Reports'),
        backgroundColor: Colors.orange,
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabs: const [
            Tab(text: 'Overview'),
            Tab(text: 'Sales'),
            Tab(text: 'Top Items'),
            Tab(text: 'Analytics'),
          ],
        ),
      ),
      body: Column(
        children: [
          _buildPeriodSelector(),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildOverviewTab(),
                _buildSalesTab(),
                _buildTopItemsTab(),
                _buildAnalyticsTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPeriodSelector() {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.grey[100],
      child: Row(
        children: [
          Expanded(
            child: DropdownButtonFormField<String>(
              value: _selectedPeriod,
              decoration: const InputDecoration(
                labelText: 'Period',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              ),
              items: ['Daily', 'Weekly', 'Monthly'].map((period) {
                return DropdownMenuItem(
                  value: period,
                  child: Text(period),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    _selectedPeriod = value;
                  });
                  _loadReportData();
                }
              },
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: InkWell(
              onTap: () async {
                final DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: _selectedDate,
                  firstDate: DateTime(2023),
                  lastDate: DateTime.now(),
                );
                if (picked != null && picked != _selectedDate) {
                  setState(() {
                    _selectedDate = picked;
                  });
                  _loadReportData();
                }
              },
              child: InputDecorator(
                decoration: const InputDecoration(
                  labelText: 'Date',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                ),
                child: Text(
                  DateFormat('MMM dd, yyyy').format(_selectedDate),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOverviewTab() {
    return BlocBuilder<SalesReportBloc, SalesReportState>(
      builder: (context, state) {
        if (state is SalesSummaryLoaded) {
          return _buildOverviewContent(state.summary);
        } else if (state is SalesReportLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is SalesReportError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  state.message,
                  style: const TextStyle(color: Colors.red),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    context.read<SalesReportBloc>().add(LoadSalesSummary(vendorId: widget.vendorId));
                  },
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }
        return const Center(child: Text('Select a period to view overview'));
      },
    );
  }

  Widget _buildOverviewContent(Map<String, dynamic> summary) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _buildSummaryCards(summary),
          const SizedBox(height: 24),
          _buildKeyMetrics(summary),
          const SizedBox(height: 24),
          _buildPerformanceIndicators(summary),
        ],
      ),
    );
  }

  Widget _buildSummaryCards(Map<String, dynamic> summary) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _buildMetricCard(
                'Total Revenue',
                '\$${summary['totalRevenue'].toStringAsFixed(2)}',
                Icons.attach_money,
                Colors.green,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildMetricCard(
                'Total Orders',
                '${summary['totalOrders'] ?? 0}',
                Icons.shopping_cart,
                Colors.blue,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildMetricCard(
                'Avg Order Value',
                '\$${summary['averageOrderValue'].toStringAsFixed(2)}',
                Icons.receipt_long,
                Colors.purple,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildMetricCard(
                'Revenue Growth',
                '${summary['revenueGrowth'] ?? 0}%',
                Icons.trending_up,
                Colors.orange,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMetricCard(String title, String value, IconData icon, Color color) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Icon(icon, color: color, size: 32),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildKeyMetrics(Map<String, dynamic> summary) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Key Metrics',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildMetricRow('Best Selling Item', summary['bestSellingItem'] ?? 'N/A', Icons.star),
            const SizedBox(height: 12),
            _buildMetricRow('Peak Hour', '${summary['peakHour'] ?? 'N/A'}:00', Icons.access_time),
            const SizedBox(height: 12),
            _buildMetricRow('Most Used Discount', summary['mostUsedDiscount'] ?? 'N/A', Icons.local_offer),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricRow(String label, String value, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: Colors.grey[600], size: 20),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildPerformanceIndicators(Map<String, dynamic> summary) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Performance Indicators',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildPerformanceIndicator(
              'Customer Satisfaction',
              85,
              Colors.green,
            ),
            const SizedBox(height: 12),
            _buildPerformanceIndicator(
              'Order Fulfillment Rate',
              92,
              Colors.blue,
            ),
            const SizedBox(height: 12),
            _buildPerformanceIndicator(
              'Menu Popularity',
              78,
              Colors.orange,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPerformanceIndicator(String label, int percentage, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              '$percentage%',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        LinearProgressIndicator(
          value: percentage / 100,
          backgroundColor: Colors.grey[200],
          valueColor: AlwaysStoppedAnimation<Color>(color),
        ),
      ],
    );
  }

  Widget _buildSalesTab() {
    return BlocBuilder<SalesReportBloc, SalesReportState>(
      builder: (context, state) {
        if (state is DailyReportLoaded || 
            state is WeeklyReportLoaded || 
            state is MonthlyReportLoaded) {
          
          final report = state is DailyReportLoaded 
              ? state.report 
              : state is WeeklyReportLoaded 
                  ? state.report 
                  : (state as MonthlyReportLoaded).report;
          
          return _buildSalesContent(report);
        } else if (state is SalesReportLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is SalesReportError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  state.message,
                  style: const TextStyle(color: Colors.red),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => _loadReportData(),
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }
        return const Center(child: Text('Select a period to view sales data'));
      },
    );
  }

  Widget _buildSalesContent(SalesReportEntity report) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _buildSalesSummary(report),
          const SizedBox(height: 24),
          _buildHourlySalesChart(report.hourlySales),
          const SizedBox(height: 24),
          _buildDiscountUsageSection(report.discountUsage),
        ],
      ),
    );
  }

  Widget _buildSalesSummary(SalesReportEntity report) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$_selectedPeriod Sales Summary',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildSalesMetric(
                    'Total Revenue',
                    '\$${report.totalRevenue.toStringAsFixed(2)}',
                    Colors.green,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildSalesMetric(
                    'Total Orders',
                    '${report.totalOrders}',
                    Colors.blue,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _buildSalesMetric(
                    'Avg Order Value',
                    '\$${report.averageOrderValue.toStringAsFixed(2)}',
                    Colors.purple,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildSalesMetric(
                    'Orders per Hour',
                    '${(report.totalOrders / 24).toStringAsFixed(1)}',
                    Colors.orange,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSalesMetric(String label, String value, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHourlySalesChart(List<HourlySalesEntity> hourlySales) {
    final maxRevenue = hourlySales.fold(0.0, (max, item) => item.revenue > max ? item.revenue : max);
    
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Hourly Sales Distribution',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 200,
              child: Row(
                children: hourlySales.map((item) {
                  final double height = maxRevenue > 0 ? (item.revenue / maxRevenue) * 160.0 : 0.0;
                  return Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          height: height,
                          decoration: BoxDecoration(
                            color: Colors.orange,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${item.hour}:00',
                          style: const TextStyle(fontSize: 10),
                        ),
                        Text(
                          '\$${item.revenue.toStringAsFixed(0)}',
                          style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDiscountUsageSection(List<DiscountUsageEntity> discountUsage) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Discount Usage',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            if (discountUsage.isEmpty)
              const Text('No discount usage data available')
            else
              Column(
                children: discountUsage.map((usage) => _buildDiscountUsageItem(usage)).toList(),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildDiscountUsageItem(DiscountUsageEntity usage) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  usage.discountName,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${usage.usageCount} uses • \$${usage.totalDiscountAmount.toStringAsFixed(2)} discount',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          Text(
            '\$${usage.revenueGenerated.toStringAsFixed(2)}',
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopItemsTab() {
    return BlocBuilder<SalesReportBloc, SalesReportState>(
      builder: (context, state) {
        if (state is TopSellingItemsLoaded) {
          return _buildTopItemsContent(state.items);
        } else if (state is SalesReportLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is SalesReportError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  state.message,
                  style: const TextStyle(color: Colors.red),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    final startDate = _selectedPeriod == 'Daily' 
                        ? _selectedDate 
                        : _selectedPeriod == 'Weekly'
                            ? _selectedDate.subtract(Duration(days: _selectedDate.weekday - 1))
                            : DateTime(_selectedDate.year, _selectedDate.month, 1);
                    final endDate = _selectedPeriod == 'Daily' 
                        ? _selectedDate 
                        : _selectedPeriod == 'Weekly'
                            ? startDate.add(const Duration(days: 6))
                            : DateTime(_selectedDate.year, _selectedDate.month + 1, 0);
                    
                    context.read<SalesReportBloc>().add(LoadTopSellingItems(
                      vendorId: widget.vendorId,
                      startDate: startDate,
                      endDate: endDate,
                      limit: 10,
                    ));
                  },
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }
        return const Center(child: Text('Select a period to view top items'));
      },
    );
  }

  Widget _buildTopItemsContent(List<SalesItemEntity> items) {
    if (items.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.fastfood, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text(
              'No sales data available',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return _buildTopItemCard(item, index + 1);
      },
    );
  }

  Widget _buildTopItemCard(SalesItemEntity item, int rank) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: _getRankColor(rank),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Text(
                  '$rank',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${item.quantitySold} sold • ${item.orderCount} orders',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '\$${item.totalRevenue.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
                Text(
                  '\$${(item.totalRevenue / item.quantitySold).toStringAsFixed(2)} each',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color _getRankColor(int rank) {
    switch (rank) {
      case 1:
        return Colors.amber;
      case 2:
        return Colors.grey[400]!;
      case 3:
        return Colors.brown[400]!;
      default:
        return Colors.blue;
    }
  }

  Widget _buildAnalyticsTab() {
    return BlocBuilder<SalesReportBloc, SalesReportState>(
      builder: (context, state) {
        if (state is HourlySalesLoaded) {
          return _buildAnalyticsContent(state.hourlySales);
        } else if (state is SalesReportLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is SalesReportError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  state.message,
                  style: const TextStyle(color: Colors.red),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    context.read<SalesReportBloc>().add(LoadHourlySales(
                      vendorId: widget.vendorId,
                      date: _selectedDate,
                    ));
                  },
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }
        return const Center(child: Text('Select a date to view analytics'));
      },
    );
  }

  Widget _buildAnalyticsContent(List<HourlySalesEntity> hourlySales) {
    final peakHour = hourlySales.fold(0, (peak, item) => 
      item.orderCount > hourlySales[peak].orderCount ? hourlySales.indexOf(item) : peak);
    
    final totalOrders = hourlySales.fold(0, (sum, item) => sum + item.orderCount);
    final totalRevenue = hourlySales.fold(0.0, (sum, item) => sum + item.revenue);
    final avgOrdersPerHour = totalOrders / 24;
    final avgRevenuePerHour = totalRevenue / 24;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _buildAnalyticsSummary(
            peakHour: peakHour,
            totalOrders: totalOrders,
            totalRevenue: totalRevenue,
            avgOrdersPerHour: avgOrdersPerHour,
            avgRevenuePerHour: avgRevenuePerHour,
          ),
          const SizedBox(height: 24),
          _buildDetailedHourlyAnalysis(hourlySales),
        ],
      ),
    );
  }

  Widget _buildAnalyticsSummary({
    required int peakHour,
    required int totalOrders,
    required double totalRevenue,
    required double avgOrdersPerHour,
    required double avgRevenuePerHour,
  }) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Analytics Summary',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildAnalyticsRow('Peak Hour', '$peakHour:00', Icons.access_time),
            const SizedBox(height: 12),
            _buildAnalyticsRow('Total Orders', '$totalOrders', Icons.shopping_cart),
            const SizedBox(height: 12),
            _buildAnalyticsRow('Total Revenue', '\$${totalRevenue.toStringAsFixed(2)}', Icons.attach_money),
            const SizedBox(height: 12),
            _buildAnalyticsRow('Avg Orders/Hour', avgOrdersPerHour.toStringAsFixed(1), Icons.bar_chart),
            const SizedBox(height: 12),
            _buildAnalyticsRow('Avg Revenue/Hour', '\$${avgRevenuePerHour.toStringAsFixed(2)}', Icons.trending_up),
          ],
        ),
      ),
    );
  }

  Widget _buildAnalyticsRow(String label, String value, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: Colors.grey[600], size: 20),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildDetailedHourlyAnalysis(List<HourlySalesEntity> hourlySales) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Detailed Hourly Analysis',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: hourlySales.length,
              itemBuilder: (context, index) {
                final item = hourlySales[index];
                return _buildHourlyAnalysisItem(item);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHourlyAnalysisItem(HourlySalesEntity item) {
    final isPeakHour = item.hour == 12 || item.hour == 13 || item.hour == 18; // Lunch and dinner hours
    final performanceColor = item.orderCount > 5 ? Colors.green : 
                             item.orderCount > 2 ? Colors.orange : Colors.red;

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isPeakHour ? Colors.orange.withOpacity(0.1) : Colors.grey[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isPeakHour ? Colors.orange.withOpacity(0.3) : Colors.grey[300]!,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            child: Text(
              '${item.hour}:00',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: isPeakHour ? Colors.orange : Colors.black,
              ),
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Icon(Icons.shopping_cart, color: performanceColor, size: 16),
                const SizedBox(width: 4),
                Text(
                  '${item.orderCount} orders',
                  style: TextStyle(
                    fontSize: 12,
                    color: performanceColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Icon(Icons.attach_money, color: Colors.green, size: 16),
                const SizedBox(width: 4),
                Text(
                  '\$${item.revenue.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
