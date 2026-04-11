import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../documents/screens/upload_documents_screen.dart';
import '../../home/screens/home_screen.dart';
import '../../payments/screens/fees_screen.dart';
import '../../profile/screens/profile_screen.dart';
import '../../tracking/screens/track_shipment_screen.dart';
import '../providers/layout_provider.dart';
import '../widgets/bottom_nav.dart';

class LayoutScreen extends StatelessWidget {
  const LayoutScreen({super.key});

  static const List<Widget> _tabs = [
    HomeScreen(),
    TrackShipmentScreen(),
    UploadDocumentsScreen(),
    FeesScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<LayoutProvider>(
      builder: (context, layoutProvider, child) {
        return Scaffold(
          body: _tabs[layoutProvider.currentIndex],
          bottomNavigationBar: const BottomNav(),
        );
      },
    );
  }
}
