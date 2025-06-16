import 'package:flutter/material.dart';
import 'package:flutter_application_depi/core/services/pedometer_service.dart';
import 'package:flutter_application_depi/core/services/services.dart';
import 'package:flutter_application_depi/utils/constants/color.dart';
import 'package:intl/intl.dart';
import 'package:fl_chart/fl_chart.dart';

class StepHistoryScreen extends StatefulWidget {
  const StepHistoryScreen({super.key});

  @override
  State<StepHistoryScreen> createState() => _StepHistoryScreenState();
}

class _StepHistoryScreenState extends State<StepHistoryScreen> {
  final PedometerService _pedometerService = PedometerService();
  List<MapEntry<DateTime, int>> _weeklySteps = [];
  bool _isLoading = true;
  int _totalWeeklySteps = 0;
  int _averageDailySteps = 0;
  int _bestDay = 0;

  @override
  void initState() {
    super.initState();
    _pedometerService.goal = InitServices.sharedPref.getInt("stepsGoal")??10000;
    _loadStepHistory();
  }

  Future<void> _loadStepHistory() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final history = await _pedometerService.getLast7DaysHistory();

      // Calculate statistics
      int total = 0;
      int best = 0;

      for (var entry in history) {
        total += entry.value;
        if (entry.value > best) {
          best = entry.value;
        }
      }

      setState(() {
        _weeklySteps = history;
        _totalWeeklySteps = total;
        _averageDailySteps =
            history.isNotEmpty ? (total / history.length).round() : 0;
        _bestDay = best;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print('Error loading step history: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1D2A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A1D2A),
        elevation: 0,
        title: ShaderMask(
          shaderCallback: (bounds) =>
              AppColor.customGradient.createShader(bounds),
          child: const Text(
            "Steps History",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.white),
            onPressed: _loadStepHistory,
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _loadStepHistory,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Weekly stats cards
                      _buildWeeklyStatsCards(),

                      const SizedBox(height: 24),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Last 7 Days',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Goal: ${_pedometerService.goal} steps',
                            style: TextStyle(
                              color: Colors.green.shade400,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // Chart for the last 7 days
                      Container(
                        height: 250,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: const Color(0xFF222533),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: _buildChart(),
                      ),

                      const SizedBox(height: 24),

                      // Daily breakdown
                      const Text(
                        'Daily Breakdown',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),

                      ..._weeklySteps
                          .map((entry) =>
                              _buildDailyStepCard(entry.key, entry.value))
                          .toList(),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  Widget _buildWeeklyStatsCards() {
    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            title: 'Weekly Steps',
            value: _formatNumber(_totalWeeklySteps),
            icon: Icons.directions_walk,
            color: Colors.blue,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildStatCard(
            title: 'Daily Average',
            value: _formatNumber(_averageDailySteps),
            icon: Icons.calendar_today,
            color: Colors.orange,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildStatCard(
            title: 'Best Day',
            value: _formatNumber(_bestDay),
            icon: Icons.emoji_events,
            color: Colors.green,
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF222533),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 14),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  String _formatNumber(int number) {
    if (number >= 10000) {
      return '${(number / 1000).toStringAsFixed(1)}k';
    }
    return number.toString();
  }

  Widget _buildChart() {
    if (_weeklySteps.isEmpty) {
      return const Center(
        child: Text(
          'No step data available',
          style: TextStyle(color: Colors.white70),
        ),
      );
    }

    // Find the maximum step count for scaling
    final maxSteps =
        _weeklySteps.map((e) => e.value).reduce((a, b) => a > b ? a : b);
    final goalLine = _pedometerService.goal??10000;

    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        maxY: maxSteps > goalLine ? maxSteps * 1.1 : goalLine * 1.1,
        barTouchData: BarTouchData(
          enabled: true,
          touchTooltipData: BarTouchTooltipData(
            tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              return BarTooltipItem(
                '${_weeklySteps[groupIndex].value} steps\n',
                const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
                children: [
                  TextSpan(
                    text: DateFormat('MMM d')
                        .format(_weeklySteps[groupIndex].key),
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ],
              );
            },
          ),
        ),
        titlesData: FlTitlesData(
          show: true,
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                if (value < 0 || value >= _weeklySteps.length)
                  return const Text('');
                return Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    DateFormat('E').format(_weeklySteps[value.toInt()].key),
                    style: const TextStyle(
                      color: Colors.white70,
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                    ),
                  ),
                );
              },
              reservedSize: 28,
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                if (value == 0) return const Text('');
                String text = '';
                if (value >= 1000) {
                  text = '${(value / 1000).toStringAsFixed(1)}k';
                } else {
                  text = value.toInt().toString();
                }
                return Text(
                  text,
                  style: const TextStyle(color: Colors.white70, fontSize: 10),
                );
              },
              reservedSize: 40,
            ),
          ),
          rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        borderData: FlBorderData(show: false),
        barGroups: List.generate(
          _weeklySteps.length,
          (index) {
            final steps = _weeklySteps[index].value;
            Color barColor = Colors.blue.shade300;

            // Change bar color based on goal achievement
            if (steps >= _pedometerService.goal) {
              barColor = Colors.green.shade400;
            } else if (steps >= _pedometerService.goal * 0.7) {
              barColor = Colors.orange.shade400;
            }

            return BarChartGroupData(
              x: index,
              barRods: [
                BarChartRodData(
                  toY: steps.toDouble(),
                  color: barColor,
                  width: 20,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(6),
                    topRight: Radius.circular(6),
                  ),
                ),
              ],
            );
          },
        ),
        gridData: FlGridData(
          show: true,
          horizontalInterval: goalLine / 4,
          getDrawingHorizontalLine: (value) {
            // Add a special line for the goal
            if (value == _pedometerService.goal.toDouble()) {
              return const FlLine(
                color: Colors.green,
                strokeWidth: 1.5,
                dashArray: [5, 5],
              );
            }
            return FlLine(
              color: Colors.white.withOpacity(0.1),
              strokeWidth: 0.5,
            );
          },
        ),
      ),
    );
  }

  Widget _buildDailyStepCard(DateTime date, int steps) {
    final isToday = date.year == DateTime.now().year &&
        date.month == DateTime.now().month &&
        date.day == DateTime.now().day;

    // Calculate progress towards goal
    final progress = steps / _pedometerService.goal;
    final formattedProgress = (progress * 100).toStringAsFixed(0);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isToday ? const Color(0xFF2E3245) : const Color(0xFF222533),
        borderRadius: BorderRadius.circular(12),
        border: isToday
            ? Border.all(color: Colors.blue.withOpacity(0.5), width: 1.5)
            : null,
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    DateFormat('d').format(date),
                    style: TextStyle(
                      color: isToday ? Colors.blue : Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    DateFormat('MMM').format(date),
                    style: TextStyle(
                      color: isToday ? Colors.blue.shade300 : Colors.white70,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      isToday ? 'Today' : DateFormat('EEEE').format(date),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      '$steps steps',
                      style: TextStyle(
                        color: progress >= 1.0 ? Colors.green : Colors.white70,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                LinearProgressIndicator(
                  value: progress.clamp(0.0, 1.0),
                  backgroundColor: Colors.grey.shade800,
                  valueColor: AlwaysStoppedAnimation<Color>(progress >= 1.0
                      ? Colors.green
                      : progress >= 0.7
                          ? Colors.orange
                          : Colors.blue),
                ),
                const SizedBox(height: 4),
                Text(
                  progress >= 1.0
                      ? 'Daily goal achieved! ($formattedProgress%)'
                      : 'Daily goal: $formattedProgress% completed',
                  style: TextStyle(
                    color: progress >= 1.0 ? Colors.green : Colors.grey,
                    fontSize: 12,
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
