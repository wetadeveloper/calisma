import 'package:final_hazirlik/views/notesapp/employee_registration_screen.dart';
import 'package:final_hazirlik/views/notesapp/salary_payment_screen.dart';
import 'package:final_hazirlik/views/notesapp/salary_slip_screen.dart';
import 'package:flutter/material.dart';

class Notesapp extends StatefulWidget {
  const Notesapp({super.key});

  @override
  _NotesappState createState() => _NotesappState();
}

class _NotesappState extends State<Notesapp> with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this); // Tab kontrolcüsü başlatıldı
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Maaş Uygulaması'),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(icon: Icon(Icons.person_add), text: 'Çalışan Kayıt'),
            Tab(icon: Icon(Icons.list), text: 'Maaş Bordrosu'),
            Tab(icon: Icon(Icons.payment), text: 'Ödeme Yap'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildErrorHandledScreen(EmployeeRegistrationScreen()),
          _buildErrorHandledScreen(SalarySlipScreen()),
          _buildErrorHandledScreen(SalaryPaymentScreen()),
        ],
      ),
    );
  }

  Widget _buildErrorHandledScreen(Widget screen) {
    return FutureBuilder(
      future: Future.microtask(() => screen), // Sayfa yüklenmesi simüle edilir
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          // Hata durumunda bir mesaj göster
          return Center(
            child: Text(
              'Bir hata oluştu: ${snapshot.error}',
              style: TextStyle(color: Colors.red, fontSize: 16),
              textAlign: TextAlign.center,
            ),
          );
        } else if (snapshot.connectionState == ConnectionState.done) {
          // Sayfa başarıyla yüklendiğinde
          return screen;
        } else {
          // Yüklenme durumunda bir yükleme göstergesi göster
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
