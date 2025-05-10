import 'package:flutter/material.dart';
import 'package:smar_bin/models/Gift.dart';
import 'package:smar_bin/services/SharedPrefsHelper.dart';
import 'package:smar_bin/services/api_service.dart';
import 'package:smar_bin/shared/components/component.dart';

class GiftPointsSelectionScreen extends StatefulWidget {

  const GiftPointsSelectionScreen({super.key,});

  @override
  State<GiftPointsSelectionScreen> createState() => _GiftPointsSelectionScreenState();
}

class _GiftPointsSelectionScreenState extends State<GiftPointsSelectionScreen> {
  late List<Gift> gifts;
  late int userPoints;
  bool isLoading = true;
  String? email;



  @override
  void initState() {
    super.initState();
    init();
    gifts = [
      Gift(image: 'assets/images/coffee.png', title: 'Coffee', cost: 100),
      Gift(image: 'assets/images/water.png', title: 'Water', cost: 50),
      Gift(image: 'assets/images/tshirt.png', title: 'Eco T-Shirt', cost: 200),
      Gift(image: 'assets/images/coupon.png', title: 'Coupon', cost: 150),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Reward',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 4), // Added spacing between texts
            Text(
              'Choose the reward you are aiming for',
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
        toolbarHeight: 80, // Increased from 70 to 80
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: Theme.of(context).secondaryHeaderColor,
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Icon(Icons.stars, size: 28, color: Theme.of(context).primaryColor),
                SizedBox(width: 10),
                Text('Your Points: ${userPoints}', style: TextStyle(fontSize: 20)),
              ],
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: gifts.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 3 / 4,
              ),
              itemBuilder: (context, index) {
                final gift = gifts[index];
                return GestureDetector(
                  onTap: () => _onGiftTap(gift),
                  child: Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    elevation: 4,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(gift.image, height: 120),
                        SizedBox(height: 10),
                        Text(gift.title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        SizedBox(height: 5),
                        Text('${gift.cost} pts', style: TextStyle(color: Colors.grey.shade700)),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> init() async {
    final storedEmail = await SharedPrefsHelper.getEmail();
    if (storedEmail != null) {
      setState(() {
        email = storedEmail;
      });
      final points = await ApiService().getGiftPointsByEmail(storedEmail);
      setState(() {
        userPoints = points!;
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
      print('No email found in SharedPreferences.');
    }
  }

  void _onGiftTap(Gift gift) {
    if (userPoints <= gift.cost) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text("Confirm Exchange"),
          content: Text("Do you want to select this item as a goal?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () async {
                Navigator.pop(context);
                // Here you'd trigger the exchange logic
                sendPointsGoalUpdate(email.toString(), gift.cost);
                flutterToast(message: "A new goal is here!", backgroundColor: Colors.green);
              },
              child: Text("Confirm"),
            ),
          ],
        ),
      );
    } else {
      flutterToast(message: "You credit already allow you to buy this item", backgroundColor: Colors.green);
    }
  }

  void sendPointsGoalUpdate(String email, int pointsGoal) async {

    bool success = await ApiService().updatePointsGoal(email, pointsGoal);
    if (success) {
      print('Gift point update confirmed.');
    } else {
      print('Failed to update gift point.');
    }
  }


}
