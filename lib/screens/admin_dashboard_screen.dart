import 'package:flutter/material.dart';
import 'dealer_applications_screen.dart';

class AdminDashboardScreen extends StatelessWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7F2),

      appBar: AppBar(
        title: const Text(
          "DailyFresh Admin",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFF2E7D32),
        foregroundColor: Colors.white,
      ),

      body: Padding(
        padding: const EdgeInsets.all(30),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Admin Dashboard",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              "Manage DailyFresh from here",
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 30),

            Expanded(
              child: GridView.count(
                crossAxisCount: 3,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                childAspectRatio: 1.6,

                children: [
                  DashboardCard(
                    title: "Dealer Applications",
                    icon: Icons.assignment_outlined,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                          const DealerApplicationsScreen(),
                        ),
                      );
                    },
                  ),

                  DashboardCard(
                    title: "Dealers",
                    icon: Icons.storefront_outlined,
                  ),

                  DashboardCard(
                    title: "Products",
                    icon: Icons.inventory_2_outlined,
                  ),

                  DashboardCard(
                    title: "Orders",
                    icon: Icons.shopping_bag_outlined,
                  ),

                  DashboardCard(
                    title: "Customers",
                    icon: Icons.people_outline,
                  ),

                  DashboardCard(
                    title: "Overview",
                    icon: Icons.dashboard_outlined,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DashboardCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback? onTap;

  const DashboardCard({
    super.key,
    required this.title,
    required this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap:onTap,

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 45,
              color: const Color(0xFF2E7D32),
            ),

            const SizedBox(height: 15),

            Text(
              title,
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}