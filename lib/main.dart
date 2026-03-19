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
        scaffoldBackgroundColor: const Color(0xFF0F1115),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF0F1115),
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.white),
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
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
    final List<Widget> cardsTablet = _buildCards(width: (width / 2) - 36);
    final List<Widget> cardsDesktop = _buildCards(width: null);

    Widget layoutContent;

    if (width < 600) {
      layoutContent = Column(children: cardsMobile);
    } else if (width < 900) {
      layoutContent = Wrap(
        alignment: WrapAlignment.start,
        children: cardsTablet,
      );
    } else {
      layoutContent = Row(
        children: cardsDesktop.map((c) => Expanded(child: c)).toList(),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Visão Geral'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none_outlined, color: Colors.white70),
            onPressed: () {},
          ),
          const SizedBox(width: 16),
        ],
      ),
      drawer: Drawer(
        backgroundColor: const Color(0xFF1E2024),
        child: ListView(
          padding: EdgeInsets.zero,
          children: const [
            DrawerHeader(
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.white10)),
              ),
              child: Text(
                'Menu',
                style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            ListTile(
              leading: Icon(Icons.dashboard, color: Colors.blueAccent),
              title: Text('Dashboard', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Olá, Fernando',
              style: TextStyle(color: Colors.white54, fontSize: 16),
            ),
            const SizedBox(height: 4),
            const Text(
              'Acompanhe seus resultados',
              style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            layoutContent,
          ],
        ),
      ),
    );
  }

  List<Widget> _buildCards({required double? width}) {
    return [
      DashboardCard(
        title: 'Receita Total',
        value: 'R\$ 45.230',
        icon: Icons.account_balance_wallet_outlined,
        accentColor: Colors.greenAccent,
        trend: '+12%',
        cardWidth: width,
      ),
      DashboardCard(
        title: 'Novos Clientes',
        value: '3.492',
        icon: Icons.people_outline,
        accentColor: Colors.blueAccent,
        trend: '+5%',
        cardWidth: width,
      ),
      DashboardCard(
        title: 'Acessos Hoje',
        value: '12.8k',
        icon: Icons.mouse_outlined,
        accentColor: Colors.orangeAccent,
        trend: '-2%',
        isTrendNegative: true,
        cardWidth: width,
      ),
      DashboardCard(
        title: 'Servidores',
        value: '99.9%',
        icon: Icons.dns_outlined,
        accentColor: Colors.purpleAccent,
        trend: 'Ok',
        cardWidth: width,
      ),
    ];
  }
}

class DashboardCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color accentColor;
  final String trend;
  final bool isTrendNegative;
  final double? cardWidth;

  const DashboardCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.accentColor,
    required this.trend,
    this.isTrendNegative = false,
    this.cardWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: cardWidth,
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
      // Movi a decoração para cá! Agora a caixa inteira estica e as cores seguem.
      decoration: BoxDecoration(
        color: const Color(0xFF1E2024),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: accentColor.withValues(alpha: 0.15),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Envolvi o conteúdo em um Padding em vez de outro Container
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: accentColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(icon, color: accentColor, size: 28),
                ),
                const SizedBox(height: 24),
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white54,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  value,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
          
          Positioned(
            top: 24,
            right: 24,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: isTrendNegative 
                    ? Colors.redAccent.withValues(alpha: 0.15)
                    : Colors.greenAccent.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    isTrendNegative ? Icons.arrow_downward : Icons.arrow_upward,
                    size: 14,
                    color: isTrendNegative ? Colors.redAccent : Colors.greenAccent,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    trend,
                    style: TextStyle(
                      color: isTrendNegative ? Colors.redAccent : Colors.greenAccent,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}