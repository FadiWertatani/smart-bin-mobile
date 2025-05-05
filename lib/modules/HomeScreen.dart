import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:smar_bin/modules/QrScreen.dart';
import 'package:smar_bin/modules/Stats.dart';
import 'package:smar_bin/modules/stats/Co2LinearGaugeScreen.dart';
import 'package:smar_bin/modules/stats/DailyStreakScreen.dart';
import 'package:smar_bin/modules/stats/GiftPointsScreen.dart';
import 'package:smar_bin/modules/stats/RecyclablePieScreen.dart';
import 'package:smar_bin/modules/stats/TopRankGaugeScreen.dart';
import 'package:smar_bin/modules/stats/TrashBarChartScreen.dart';
import 'package:smar_bin/services/api_service.dart';
import 'package:smar_bin/shared/components/StatGauge.dart';
import 'package:smar_bin/shared/components/StatsCard.dart';
import 'package:smar_bin/shared/components/navigator.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Map<String, dynamic>>> _futureUsers;

  @override
  void initState() {
    super.initState();
    _futureUsers = ApiService().fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // App header with title and icons
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Earn Rewards for\nGoing Green!',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: GestureDetector(
                          child: const Icon(Icons.qr_code_scanner_rounded,
                              size: 22),
                          onTap: () => normalPush(
                              context: context, direction: QrCodeScreen()),
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Icon(Icons.notifications_outlined, size: 24),
                    ],
                  ),
                ],
              ),
            ),

            // Search bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.search, color: Colors.grey),
                    SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Search doctor, articles...',
                          hintStyle: TextStyle(color: Colors.grey),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Rewards banner
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Color(0xffD6E4FF),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    // Left text section
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Dispose smart.',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Get rewarded.',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 12),
                          ElevatedButton(
                            onPressed: null,
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll(Color(0xff015ff3)),
                              padding: MaterialStatePropertyAll(
                                EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 8),
                              ),
                            ),
                            child: Text(
                              'Get QR Code',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Doctor image
                    Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        image: const DecorationImage(
                          image: AssetImage('assets/images/doctor.jpg'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Top Staff section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Top Staff',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text('See all',
                        style: TextStyle(color: Colors.blue)),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 8),

            // SizedBox(
            //   height: 140,
            //   child: ListView(
            //     scrollDirection: Axis.horizontal,
            //     padding: const EdgeInsets.symmetric(horizontal: 12),
            //     children: [
            //       _buildDoctorCard(
            //         'Dr. Med Aziz Beja',
            //         'Surgeon',
            //         'assets/images/doctor.jpg',
            //       ),
            //       _buildDoctorCard(
            //         'Amira Isabldi',
            //         'Nurse',
            //         'https://via.placeholder.com/80',
            //       ),
            //       _buildDoctorCard(
            //         'Samar Rezgui',
            //         'Orthopedics',
            //         'https://via.placeholder.com/80',
            //       ),
            //       _buildDoctorCard(
            //         'Samar Rezgui',
            //         'Orthopedics',
            //         'https://via.placeholder.com/80',
            //       ),
            //     ],
            //   ),
            // ),

            // Stats section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Statistics',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      normalPush(context: context, direction: Stats());
                    },
                    child: const Text('See all',
                        style: TextStyle(color: Colors.blue)),
                  ),
                ],
              ),
            ),

            // SingleChildScrollView(
            //   scrollDirection: Axis.horizontal,
            //   padding: const EdgeInsets.symmetric(horizontal: 16),
            //   child: Row(
            //     children: [
            //       StatInfoCard(
            //         title: 'Gift Points',
            //         summary: 'You earned 45 points today.',
            //         date: 'Today',
            //         time: '08:00 AM',
            //         status: 'On track',
            //         backgroundColor: const Color(0xFF4A148C), // Deep Purple
            //         textColor: Colors.white,
            //         onTap: () {}, // Will be used later for navigation
            //       ),
            //       const SizedBox(width: 16),
            //       StatInfoCard(
            //         title: 'Trash Stats',
            //         summary: 'You threw 2.4kg of trash.',
            //         date: 'Today',
            //         time: '10:15 AM',
            //         status: 'Moderate',
            //         backgroundColor: const Color(0xFF1B5E20), // Dark Green
            //         textColor: Colors.white,
            //         onTap: () {},
            //       ),
            //       const SizedBox(width: 16),
            //       StatInfoCard(
            //         title: 'Recyclables',
            //         summary: '60% of your waste is recyclable.',
            //         date: 'This Week',
            //         time: '02:00 PM',
            //         status: 'Good job!',
            //         backgroundColor: const Color(0xFF01579B), // Blue dark
            //         textColor: Colors.white,
            //         onTap: () {},
            //       ),
            //       const SizedBox(width: 16),
            //       StatInfoCard(
            //         title: 'CO₂ Emission',
            //         summary: 'Your CO₂ level is below average.',
            //         date: 'Today',
            //         time: '09:10 AM',
            //         status: 'Eco-friendly',
            //         backgroundColor: const Color(0xFF00695C), // Teal dark
            //         textColor: Colors.white,
            //         onTap: () {},
            //       ),
            //       const SizedBox(width: 16),
            //       StatInfoCard(
            //         title: 'Daily Streak',
            //         summary: '5-day eco streak maintained.',
            //         date: 'This Week',
            //         time: '07:00 AM',
            //         status: 'Keep it up!',
            //         backgroundColor: const Color(0xFFEF6C00), // Orange dark
            //         textColor: Colors.white,
            //         onTap: () {},
            //       ),
            //       const SizedBox(width: 16),
            //       StatInfoCard(
            //         title: 'Top Rank',
            //         summary: 'You’re currently ranked #2.',
            //         date: 'This Month',
            //         time: '05:00 PM',
            //         status: 'Awesome!',
            //         backgroundColor: const Color(0xFF3E2723), // Brown dark
            //         textColor: Colors.white,
            //         onTap: () {},
            //       ),
            //     ],
            //   ),
            // ),

            // Stats-style cards (instead of doctor cards)

            //Stats cards
            SizedBox(
              height: 160,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  StatInfoCard(
                    title: 'Gift Points',
                    summary: 'You earned 45 points today.',
                    date: 'Today',
                    time: '08:00 AM',
                    status: 'On track',
                    backgroundColor: Colors.indigo.shade900, // Deep Purple
                    textColor: Colors.white,
                    onTap: () => normalPush(context: context, direction: GiftPointsScreen()),
                  ),
                  const SizedBox(width: 16),
                  StatInfoCard(
                    title: 'Trash Stats',
                    summary: 'You threw 2.4kg of trash.',
                    date: 'Today',
                    time: '10:15 AM',
                    status: 'Moderate',
                    backgroundColor: Colors.indigo.shade500, // Dark Green
                    textColor: Colors.white,
                    onTap: () => normalPush(context: context, direction: TrashBarChartScreen()),
                  ),
                  const SizedBox(width: 16),
                  StatInfoCard(
                    title: 'Recyclables',
                    summary: '60% of your waste is recyclable.',
                    date: 'This Week',
                    time: '02:00 PM',
                    status: 'Good job!',
                    backgroundColor: Colors.indigo.shade900, // Blue dark
                    textColor: Colors.white,
                    onTap: () => normalPush(context: context, direction: RecyclablePieScreen()),
                  ),
                  const SizedBox(width: 16),
                  StatInfoCard(
                    title: 'CO₂ Emission',
                    summary: 'Your CO₂ level is below average.',
                    date: 'Today',
                    time: '09:10 AM',
                    status: 'Eco-friendly',
                    backgroundColor: Colors.indigo.shade500, // Teal dark
                    textColor: Colors.white,
                    onTap: () => normalPush(context: context, direction: Co2LinearGaugeScreen()),
                  ),
                  const SizedBox(width: 16),
                  StatInfoCard(
                    title: 'Daily Streak',
                    summary: '5-day eco streak maintained.',
                    date: 'This Week',
                    time: '07:00 AM',
                    status: 'Keep it up!',
                    backgroundColor: Colors.indigo.shade900, // Orange dark
                    textColor: Colors.white,
                    onTap: () => normalPush(context: context, direction: DailyStreakScreen()),
                  ),
                  const SizedBox(width: 16),
                  StatInfoCard(
                    title: 'Top Rank',
                    summary: 'You’re currently ranked #2.',
                    date: 'This Month',
                    time: '05:00 PM',
                    status: 'Awesome!',
                    backgroundColor: Colors.indigo.shade500, // Brown dark
                    textColor: Colors.white,
                    onTap: () => normalPush(context: context, direction: TopRankGaugeScreen()),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),


          ],
        ),
      ),
    );
  }

  Widget _buildDoctorCard(String name, String specialty, String imageUrl) {
    return Container(
      width: 100,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundImage: AssetImage(imageUrl),
          ),
          const SizedBox(height: 8),
          Text(
            name,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            specialty,
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, bool isSelected) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          color: isSelected ? Colors.blue : Colors.grey,
        ),
        if (isSelected)
          Container(
            margin: const EdgeInsets.only(top: 4),
            width: 4,
            height: 4,
            decoration: const BoxDecoration(
              color: Colors.blue,
              shape: BoxShape.circle,
            ),
          ),
      ],
    );
  }

  void _loadGiftPoints() async {
    final points = await ApiService().getGiftPointsByEmail("test@example.com");
    print("Gift Points: $points");
  }


  Widget _buildStatCard(
    BuildContext context, {
    required String title,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color.withOpacity(0.2),
          child: Icon(icon, color: color),
        ),
        title: Text(title),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }
}
