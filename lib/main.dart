import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Responsive Dashboard',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.grey[100],
      ),
      home: const Dashboard(),
    );
  }
}

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    // Change GridView according to screen size
    int columns = width > 900 ? 3 : 2;

    return Scaffold(
      body: Row(
        children: [

          // =================================================
          // SIDEBAR
          // =================================================

          Container(
            width: 220,
            color: Colors.white,
            child: Column(
              children: [

                const SizedBox(height: 40),

                const Text(
                  "DashBoard",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),

                const SizedBox(height: 40),

                sidebarItem(
                  context,
                  "Home",
                  Icons.home,
                  true,
                ),

                sidebarItem(
                  context,
                  "Profile",
                  Icons.person,
                  false,
                ),

                sidebarItem(
                  context,
                  "Messages",
                  Icons.message,
                  false,
                ),

                sidebarItem(
                  context,
                  "Reports",
                  Icons.bar_chart,
                  false,
                ),

                sidebarItem(
                  context,
                  "Settings",
                  Icons.settings,
                  false,
                ),

                const Spacer(),

                sidebarItem(
                  context,
                  "Logout",
                  Icons.logout,
                  false,
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),

          // =================================================
          // MAIN CONTENT
          // =================================================

          Expanded(
            child: Column(
              children: [

                // Top Bar
                Container(
                  height: 70,
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  color: Colors.white,
                  child: Row(
                    children: [
                      const Text(
                        "Dashboard",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const Spacer(),

                      const Icon(Icons.notifications_none),

                      const SizedBox(width: 20),

                      const CircleAvatar(
                        child: Icon(Icons.person),
                      ),
                    ],
                  ),
                ),

                // Dashboard Content
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.all(25),
                    children: [

                      // Welcome
                      const Text(
                        "Welcome Back!",
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 5),

                      Text(
                        "Here is your dashboard overview.",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey[600],
                        ),
                      ),

                      const SizedBox(height: 25),

                      // =================================================
                      // SUMMARY CARDS
                      // =================================================

                      Row(
                        children: [

                          Expanded(
                            child: summaryCard(
                              context,
                              "Users",
                              "120",
                              Icons.people,
                            ),
                          ),

                          const SizedBox(width: 15),

                          Expanded(
                            child: summaryCard(
                              context,
                              "Orders",
                              "85",
                              Icons.shopping_cart,
                            ),
                          ),

                          if (width > 700) ...[
                            const SizedBox(width: 15),

                            Expanded(
                              child: summaryCard(
                                context,
                                "Tasks",
                                "28",
                                Icons.task_alt,
                              ),
                            ),
                          ],
                        ],
                      ),

                      const SizedBox(height: 30),

                      // =================================================
                      // QUICK ACCESS
                      // =================================================

                      const Text(
                        "Quick Access",
                        style: TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 15),

                      GridView.count(
                        crossAxisCount: columns,
                        shrinkWrap: true,
                        physics:
                            const NeverScrollableScrollPhysics(),
                        crossAxisSpacing: 15,
                        mainAxisSpacing: 15,
                        childAspectRatio: 1.8,
                        children: [

                          featureCard(
                            context,
                            "Profile",
                            Icons.person,
                          ),

                          featureCard(
                            context,
                            "Messages",
                            Icons.message,
                          ),

                          featureCard(
                            context,
                            "Reports",
                            Icons.bar_chart,
                          ),

                          featureCard(
                            context,
                            "Settings",
                            Icons.settings,
                          ),

                          featureCard(
                            context,
                            "Calendar",
                            Icons.calendar_month,
                          ),

                          featureCard(
                            context,
                            "Help",
                            Icons.help_outline,
                          ),
                        ],
                      ),

                      const SizedBox(height: 30),

                      // =================================================
                      // RECENT ACTIVITIES
                      // =================================================

                      const Text(
                        "Recent Activities",
                        style: TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 12),

                      Card(
                        elevation: 2,
                        child: Column(
                          children: [

                            activityTile(
                              context,
                              "User logged in",
                              "10 minutes ago",
                              Icons.login,
                            ),

                            const Divider(height: 1),

                            activityTile(
                              context,
                              "New order received",
                              "30 minutes ago",
                              Icons.shopping_cart,
                            ),

                            const Divider(height: 1),

                            activityTile(
                              context,
                              "New message",
                              "1 hour ago",
                              Icons.message,
                            ),

                            const Divider(height: 1),

                            activityTile(
                              context,
                              "Settings updated",
                              "2 hours ago",
                              Icons.settings,
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20),

                      // =================================================
                      // BOTTOM CARDS
                      // =================================================

                      Row(
                        children: [

                          Expanded(
                            child: infoCard(
                              "Completed",
                              "28 Tasks",
                              Icons.check_circle,
                            ),
                          ),

                          const SizedBox(width: 15),

                          Expanded(
                            child: infoCard(
                              "Pending",
                              "8 Tasks",
                              Icons.pending,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // =============================================================
  // SIDEBAR ITEM
  // =============================================================

  static Widget sidebarItem(
    BuildContext context,
    String title,
    IconData icon,
    bool selected,
  ) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color: selected ? Colors.blue[50] : Colors.transparent,
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color: selected ? Colors.blue : Colors.grey[700],
        ),

        title: Text(
          title,
          style: TextStyle(
            color: selected ? Colors.blue : Colors.grey[800],
            fontWeight:
                selected ? FontWeight.bold : FontWeight.normal,
          ),
        ),

        onTap: () {
          if (title != "Home") {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailPage(title: title),
              ),
            );
          }
        },
      ),
    );
  }

  // =============================================================
  // SUMMARY CARD
  // =============================================================

  static Widget summaryCard(
    BuildContext context,
    String title,
    String value,
    IconData icon,
  ) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailPage(title: title),
          ),
        );
      },

      child: Card(
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(16),

          child: Row(
            children: [

              Icon(
                icon,
                size: 32,
                color: Colors.blue,
              ),

              const SizedBox(width: 12),

              Flexible(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [

                    Text(title),

                    const SizedBox(height: 3),

                    Text(
                      value,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // =============================================================
  // QUICK ACCESS CARD
  // =============================================================

  static Widget featureCard(
    BuildContext context,
    String title,
    IconData icon,
  ) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),

      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailPage(title: title),
          ),
        );
      },

      child: Card(
        elevation: 2,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Icon(
              icon,
              size: 34,
              color: Colors.blue,
            ),

            const SizedBox(height: 8),

            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),

            const SizedBox(height: 4),

            const Text(
              "Tap to open",
              style: TextStyle(
                fontSize: 11,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // =============================================================
  // ACTIVITY
  // =============================================================

  static Widget activityTile(
    BuildContext context,
    String title,
    String time,
    IconData icon,
  ) {
    return ListTile(
      leading: CircleAvatar(
        child: Icon(icon),
      ),

      title: Text(title),

      subtitle: Text(time),

      trailing: const Icon(
        Icons.arrow_forward_ios,
        size: 15,
      ),

      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("$title selected"),
          ),
        );
      },
    );
  }

  // =============================================================
  // INFO CARD
  // =============================================================

  static Widget infoCard(
    String title,
    String value,
    IconData icon,
  ) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(18),

        child: Row(
          children: [

            Icon(
              icon,
              color: Colors.blue,
              size: 30,
            ),

            const SizedBox(width: 12),

            Flexible(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [

                  Text(title),

                  const SizedBox(height: 4),

                  Text(
                    value,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
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

// =============================================================
// DETAIL PAGE
// =============================================================

class DetailPage extends StatelessWidget {
  final String title;

  const DetailPage({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            const Icon(
              Icons.check_circle,
              size: 70,
              color: Colors.blue,
            ),

            const SizedBox(height: 20),

            Text(
              "$title Page",
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Text(
              "You opened the $title section.",
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 25),

            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Go Back"),
            ),
          ],
        ),
      ),
    );
  }
}