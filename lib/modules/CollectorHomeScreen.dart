import 'package:flutter/material.dart';
import 'package:smar_bin/services/api_service.dart';
import '../models/Bin.dart';

class CollectorHomeScreen extends StatefulWidget {
  const CollectorHomeScreen({super.key});

  @override
  State<CollectorHomeScreen> createState() => _CollectorHomeScreenState();
}

class _CollectorHomeScreenState extends State<CollectorHomeScreen> {
  List<Bin> bins = [];
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    loadBins();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Dashboard',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 4),
            Text(
              'Find here the bins information.',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.normal,
                color: Colors.grey,
              ),
            ),
          ],
        ),
        titleSpacing: 0,
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 80,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : errorMessage != null
          ? Center(child: Text('Error: $errorMessage'))
          : ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: bins.length,
        itemBuilder: (context, index) {
          final bin = bins[index];
          return Card(
            elevation: 3,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12)),
            margin: const EdgeInsets.only(bottom: 16),
            child: ListTile(
              contentPadding: const EdgeInsets.all(16),
              title: Text(
                bin.reference,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text("Fill Level: ${bin.fillLevel}%"),
              trailing: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: getStatusColor(bin.status),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  bin.status,
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> loadBins() async {
    try {
      final fetchedBins = await ApiService().fetchBins();
      setState(() {
        bins = fetchedBins;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = e.toString();
        isLoading = false;
      });
    }
  }

  Color getStatusColor(String status) {
    switch (status) {
      case "Full":
        return Colors.red;
      case "Near Full":
        return Colors.orange;
      case "Collected":
        return Colors.green;
      default:
        return Colors.grey;
    }
  }
}
