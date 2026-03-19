import 'package:flutter/material.dart';

void main() {
  runApp(const DashboardApp());
}

class DashboardApp extends StatelessWidget {
  const DashboardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dashboard Responsivo',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.blue,
        scaffoldBackgroundColor: Colors.grey[100],
      ),
      home: const DashboardPage(),
    );
  }
}

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    final List<Widget> cardsMobile = _buildCards(width: double.infinity);
    final List<Widget> cardsTablet = _buildCards(width: (width / 2) - 30);
    final List<Widget> cardsDesktop = _buildCards(width: null);

    Widget layoutContent;

    if (width < 600) {
      layoutContent = Column(children: cardsMobile);
    } else if (width < 900) {
      layoutContent = Wrap(
        alignment: WrapAlignment.center,
        children: cardsTablet,
      );
    } else {
      layoutContent = Row(
        children: cardsDesktop.map((c) => Expanded(child: c)).toList(),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Flutter Dashboard',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.blueAccent,
        iconTheme: const IconThemeData(color: Colors.white),
      ),

      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: const [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.blueAccent),
              child: Text(
                'Menu',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(leading: Icon(Icons.dashboard), title: Text('Dashboard')),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Configurações'),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12.0),
        child: layoutContent,
      ),
    );
  }

  List<Widget> _buildCards({required double? width}) {
    return [
      DashboardCard(
        title: 'Vendas Totais',
        value: 'R\$ 25.400',
        icon: Icons.attach_money,
        color: Colors.green,
        cardWidth: width,
      ),
      DashboardCard(
        title: 'Novos Usuários',
        value: '1.234',
        icon: Icons.person_add,
        color: Colors.blue,
        cardWidth: width,
      ),
      DashboardCard(
        title: 'Taxa de Conversão',
        value: '4.8%',
        icon: Icons.trending_up,
        color: Colors.orange,
        cardWidth: width,
      ),
      DashboardCard(
        title: 'Reclamações',
        value: '12',
        icon: Icons.warning_amber_rounded,
        color: Colors.redAccent,
        cardWidth: width,
      ),
    ];
  }
}

class DashboardCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;
  final double? cardWidth;

  const DashboardCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
    this.cardWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: cardWidth,
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 6,
            offset: const Offset(0, 4),
          ),
        ],
      ),

      child: Stack(
        clipBehavior: Clip.hardEdge,
        children: [
          Positioned(
            right: -15,
            bottom: -15,
            child: Icon(
              icon,
              size: 100,
              color: Colors.white.withValues(alpha: 0.2),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(icon, color: Colors.white, size: 36),
                const SizedBox(height: 16),
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  value,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 28,
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
