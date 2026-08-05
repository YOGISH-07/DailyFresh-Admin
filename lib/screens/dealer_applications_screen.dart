import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DealerApplicationsScreen extends StatelessWidget {
  const DealerApplicationsScreen({super.key});

  Future<void> approveDealer(
      BuildContext context,
      String uid,
      Map<String, dynamic> data,
      ) async {
    try {
      final firestore = FirebaseFirestore.instance;

      // Create dealer in dealers collection
      await firestore.collection("dealers").doc(uid).set({
        "shopName": data["shopName"] ?? "",
        "ownerName": data["ownerName"] ?? "",
        "email": data["email"] ?? "",
        "phone": data["phone"] ?? "",
        "address": data["address"] ?? "",
        "status": "active",
      });

      // Change application status
      await firestore
          .collection("dealerApplications")
          .doc(uid)
          .update({
        "status": "approved",
      });

      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Dealer approved successfully"),
        ),
      );
    } catch (e) {
      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error: $e"),
        ),
      );
    }
  }

  Future<void> rejectDealer(
      BuildContext context,
      String uid,
      ) async {
    try {
      await FirebaseFirestore.instance
          .collection("dealerApplications")
          .doc(uid)
          .update({
        "status": "rejected",
      });

      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Dealer application rejected"),
        ),
      );
    } catch (e) {
      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error: $e"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7F2),

      appBar: AppBar(
        title: const Text("Dealer Applications"),
        backgroundColor: const Color(0xFF2E7D32),
        foregroundColor: Colors.white,
      ),

      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("dealerApplications")
            .snapshots(),

        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text(
                "No dealer applications found",
                style: TextStyle(fontSize: 18),
              ),
            );
          }

          final applications = snapshot.data!.docs;

          return ListView.builder(
            padding: const EdgeInsets.all(20),
            itemCount: applications.length,

            itemBuilder: (context, index) {
              final doc = applications[index];

              final data =
              doc.data() as Map<String, dynamic>;

              return Card(
                margin: const EdgeInsets.only(bottom: 15),

                child: Padding(
                  padding: const EdgeInsets.all(20),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data["shopName"] ?? "No Shop Name",
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 10),

                      Text(
                        "Owner: ${data["ownerName"] ?? ""}",
                      ),

                      Text(
                        "Email: ${data["email"] ?? ""}",
                      ),

                      Text(
                        "Phone: ${data["phone"] ?? ""}",
                      ),

                      Text(
                        "Address: ${data["address"] ?? ""}",
                      ),

                      const SizedBox(height: 10),

                      Text(
                        "Status: ${data["status"] ?? "pending"}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if ((data["status"] ?? "pending") == "pending") ...[
                        const SizedBox(height: 15),

                        Row(
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                approveDealer(
                                  context,
                                  doc.id,
                                  data,
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                foregroundColor: Colors.white,
                              ),
                              child: const Text("Approve"),
                            ),

                            const SizedBox(width: 10),

                            ElevatedButton(
                              onPressed: () {
                                rejectDealer(
                                  context,
                                  doc.id,
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                                foregroundColor: Colors.white,
                              ),
                              child: const Text("Reject"),
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}