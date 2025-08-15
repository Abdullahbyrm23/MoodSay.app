import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:intl/intl.dart';
import 'main.dart'; // Mood modelini kullanabilmek için main.dart'ı içe aktarıyoruz.

class JournalPage extends StatefulWidget {
  final Mood mood;
  const JournalPage({super.key, required this.mood});

  @override
  State<JournalPage> createState() => _JournalPageState();
}

class _JournalPageState extends State<JournalPage> {
  final TextEditingController _journalController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _journalController.dispose();
    super.dispose();
  }

  // Tarih seçme işlemini yürüten fonksiyon
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: widget.mood.colors.first,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _saveJournalEntry() {
    final String journalText = _journalController.text;
    if (journalText.isNotEmpty) {
      // TODO: İleride günlük girişini kaydetme mantığı buraya eklenecek.
      // Kayıt yapıldıktan sonra bir geri bildirim gösterilebilir.
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${widget.mood.title} günlüğünüz kaydedildi!'),
          backgroundColor: widget.mood.colors.first,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Ana içerik, başlıkla çakışmaması için üstten boşluk bırakıyor.
          Positioned.fill(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(
                top: 100,
                left: 20,
                right: 20,
                bottom: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Geri butonu buradan kaldırıldı, Stack içine eklendi.
                  // Mood animasyonu
                  Center(
                    child: Lottie.asset(
                      widget.mood.animationPath,
                      width: 150,
                      height: 150,
                      repeat: true,
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Tarih göstergesi ve seçici
                  GestureDetector(
                    onTap: () => _selectDate(context),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 16,
                      ),
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(255, 255, 255, 0.1),
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: widget.mood.colors.first),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            DateFormat(
                              'dd MMMM yyyy',
                              'tr_TR',
                            ).format(_selectedDate),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                          Icon(
                            Icons.calendar_today,
                            color: widget.mood.colors.first,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Günlük metin alanı
                  Container(
                    height: 300,
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(255, 255, 255, 0.1),
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: widget.mood.colors.first),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextField(
                        controller: _journalController,
                        maxLines: null,
                        expands: true,
                        keyboardType: TextInputType.multiline,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                        decoration: InputDecoration(
                          hintText: 'Bugün neler oldu? Ne hissediyorsun?',
                          hintStyle: const TextStyle(
                            color: Color.fromRGBO(255, 255, 255, 0.5),
                            fontSize: 16,
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Kaydet butonu
                  ElevatedButton(
                    onPressed: _saveJournalEntry,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: widget.mood.colors.first,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: const Text(
                      'Kaydet',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // MoodSay başlığı, Stack içinde en üste sabitlendi.
          const Positioned(
            top: 40,
            left: 0,
            right: 0,
            child: SafeArea(
              child: Text(
                'MoodSay',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.w900,
                  fontStyle: FontStyle.italic,
                  shadows: [
                    Shadow(
                      blurRadius: 10.0,
                      color: Colors.black26,
                      offset: Offset(2.0, 2.0),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Geri butonu, Stack içinde en üste sabitlendi.
          Positioned(
            top: 40,
            left: 20,
            child: SafeArea(
              child: Container(
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(255, 255, 255, 0.2),
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
