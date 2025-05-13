import 'package:flutter/material.dart';
import 'package:smar_bin/services/SharedPrefsHelper.dart';
import 'package:smar_bin/shared/components/GiftPointsWidget.dart';
import 'package:smar_bin/services/api_service.dart'; // Make sure this import is correct

class GiftPointsScreen extends StatefulWidget {

  const GiftPointsScreen({super.key});

  @override
  State<GiftPointsScreen> createState() => _GiftPointsScreenState();
}

class _GiftPointsScreenState extends State<GiftPointsScreen> {
  int? giftPoints;
  int? pointsGoal;

  // final int maxPoints = 100;
  bool isLoading = true;
  bool isLoading1 = true;

  @override
  void initState() {
    super.initState();
    _init();
  }

  void _init() async {
    final email = await SharedPrefsHelper.getEmail();
    print("2222 " + email.toString());
    await fetchGiftPoints(email);
    await fetchPointsGoal(email);
    print("TEST: " + pointsGoal.toString());
  }


  Future<void> fetchGiftPoints(String? email) async {
    if (email == null) return;

    final points = await ApiService().getGiftPointsByEmail(email);
    setState(() {
      giftPoints = points;
      isLoading = false;
    });
  }

  Future<void> fetchPointsGoal(String? email) async {
    if (email == null) return;

    final points = await ApiService().getPointsGoalByEmail(email);
    setState(() {
      pointsGoal = points;
      isLoading1 = false;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Gift Points',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 4),
            Text(
              'Your current points for next reward',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.normal,
                color: Colors.grey,
              ),
            ),
          ],
        ),
        titleSpacing: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.grey),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 80,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: (isLoading || isLoading1)
              ? const CircularProgressIndicator()
              : (giftPoints != null && pointsGoal != null)
              ? GiftPointsWidget(
            points: giftPoints!.toDouble(),
            maxPoints: pointsGoal!.toDouble(),
          )
              : const Text('Unable to load gift points'),
        ),
      ),
    );
  }
}
