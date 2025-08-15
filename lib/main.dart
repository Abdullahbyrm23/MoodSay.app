import 'splash_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'journal_page.dart';
import 'dart:math';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

// Ana uygulama giriş noktası
void main() async {
  // Flutter uygulamasının başlatılması için gerekli olan widget'ların
  // hazır olmasını sağlar.
  WidgetsFlutterBinding.ensureInitialized();

  // 'intl' paketi için Türkçe (tr) dil verilerini yüklüyoruz.
  // Bu işlem, tarih ve saat formatlama hatalarını önlemek için zorunludur.
  await initializeDateFormatting('tr', null);

  runApp(const MoodApp());
}

// Uygulamanın ana widget'ı
class MoodApp extends StatelessWidget {
  const MoodApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Montserrat',
        scaffoldBackgroundColor: Colors.black,
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            fontSize: 72,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          bodyLarge: TextStyle(fontSize: 18, color: Colors.white70),
        ),
      ),
      home: const SplashScreen(),
    );
  }
}

// Mood verilerini tutacak model sınıfı
class Mood {
  final String animationPath;
  final String title;
  final List<String> descriptions;
  final List<Color> colors;

  const Mood({
    required this.animationPath,
    required this.title,
    required this.descriptions,
    required this.colors,
  });
}

// Ana sayfa widget'ı
class MoodHomePage extends StatefulWidget {
  const MoodHomePage({super.key});

  @override
  State<MoodHomePage> createState() => _MoodHomePageState();
}

class _MoodHomePageState extends State<MoodHomePage> {
  final PageController _pageController = PageController();
  int _currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      int newPageIndex = _pageController.page?.round() ?? 0;
      if (_currentPageIndex != newPageIndex) {
        setState(() {
          _currentPageIndex = newPageIndex;
        });
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  final List<Mood> moods = const [
    Mood(
      animationPath: "assets/emojis/mutlu.json",
      title: "Mutlu",
      descriptions: [
        "Bugün her şey harika görünüyor!",
        "Harika bir gün! Gülümsemen hiç solmasın.",
        "İçindeki pozitif enerji etrafına yayılıyor.",
        "Hayat küçük anlardan ibaret, tadını çıkar.",
        "Mutluluğun sırrı, anın kıymetini bilmektir.",
        "Çok keyiflisin, bu harika hissi koru.",
        "Pozitif düşünceler, pozitif bir yaşam yaratır.",
        "Gülmek sana çok yakışıyor.",
        "En güzel günler bugün başladı!",
        "İçten bir gülümseme her kapıyı açar.",
        "Bugün içimde coşku var, hayat çok güzel.",
        "Enerjim tavan, hiçbir şey moralimi bozamaz.",
        "Güneşin doğuşu gibi içim parlıyor.",
        "Sevdiklerimle olmak gibisi yok, çok şükür.",
        "Küçük bir başarı bile günümü aydınlattı.",
        "Bu güzel hissin bitmesini hiç istemiyorum.",
        "Hayatın bana sunduklarına minnettarım.",
        "Her şeyin üstesinden gelebilecek güce sahibim.",
        "Gülümsemem, içimdeki mutluluğun yansıması.",
        "Bugün tam olarak olması gerektiği gibi hissediyorum.",
      ],
      colors: [Color(0xFFFFD700), Color(0xFFFF8C00)],
    ),
    Mood(
      animationPath: "assets/emojis/uzgun.json",
      title: "Üzgün",
      descriptions: [
        "Bazen üzgün hissetmek normaldir.",
        "Unutma, her fırtına sonrası güneş açar.",
        "Yalnız değilsin, bu hissin geçeceğini unutma.",
        "Sana iyi gelecek bir şeyler yapmayı dene.",
        "Hissettiklerini görmezden gelme, onlara izin ver.",
        "Üzülmek de insan olmanın bir parçasıdır.",
        "Biraz dinlenmeye ve kendinle kalmaya ihtiyacın olabilir.",
        "Yarın yeni bir gün ve yeni başlangıçlar demek.",
        "En kısa zamanda yeniden mutlu olacaksın.",
        "Bu hissin kalıcı olmadığını hatırla.",
        "Bazen kalbim biraz kırık hissediyor.",
        "Ağlamak iyi gelir, hislerine izin ver.",
        "Bu hissin geçeceğini biliyorum, sadece biraz zamana ihtiyacım var.",
        "Yalnız hissetme, sevdiklerin yanında.",
        "Kendini daha iyi hissedeceğin şeyler düşün.",
        "Bu duyguyu hissetmek de insan olmanın bir parçası.",
        "Her şeyin daha iyi olacağına inanıyorum.",
        "Kederli olmak, derin düşünebildiğini gösterir.",
        "Unutma, yarın yeni bir sayfa açabilirsin.",
        "Biraz kendime dönmeye ihtiyacım var.",
      ],
      colors: [Color(0xFF87CEFA), Color(0xFF1E90FF)],
    ),
    Mood(
      animationPath: "assets/emojis/Angry.json",
      title: "Kızgın",
      descriptions: [
        "Derin bir nefes al, her şey düzelecek.",
        "Bu duygunun geçici olduğunu hatırla.",
        "Öfke bazen bizi yorar, biraz sakinleşmeyi dene.",
        "Hislerini ifade etmenin daha yapıcı yollarını bulabilirsin.",
        "Öfkeni kontrol altında tutmak güçlü bir harekettir.",
        "Sakinleşmek için kendine biraz zaman tanı.",
        "Bu durumla başa çıkacak güce sahipsin.",
        "Olaylara farklı bir pencereden bakmaya çalış.",
        "Kızgınlık, enerjini boşa harcar.",
        "Öfkeni serbest bırak, rahatladığını hissedeceksin.",
        "Sinirlerimi yatıştırmak için bir mola vermeliyim.",
        "Öfkemi kontrol etmek, kendime olan saygımdır.",
        "Bu duygunun altında yatan nedeni bulmalıyım.",
        "Öfke, enerjimi alıp götürüyor, sakinleşmeliyim.",
        "Kendini ifade etmenin daha sakin yollarını dene.",
        "Unutma, öfke bazen sadece bir sinyaldir.",
        "Kendini sakinleştirmek için derin nefesler al.",
        "Bu durum, benim kontrolüm dışında olabilir.",
        "Bazen en iyisi, ortamdan uzaklaşmaktır.",
        "Bu hissin uzun sürmesine izin verme.",
      ],
      colors: [Color(0xFFFF4500), Color(0xFFDC143C)],
    ),
    Mood(
      animationPath: "assets/emojis/yorgun.json",
      title: "Yorgun",
      descriptions: [
        "Biraz dinlenmek sana iyi gelir.",
        "Vücudunu dinle, o neye ihtiyacı olduğunu bilir.",
        "Güzel bir uyku, her şeyin ilacı olabilir.",
        "Bugün dinlenme günü ilan et.",
        "Yorgun hissetmek, çok çalıştığının bir işaretidir.",
        "Kendine biraz mola ver.",
        "Enerjini geri kazanmak için kendine iyi bak.",
        "Şarj ol, yeniden başlayacaksın.",
        "Biraz yavaşla, acele etme.",
        "Dinlenmek, tembellik değil, bir ihtiyaçtır.",
        "Vücudum ve zihnim bir mola vermemi istiyor.",
        "Kendine nazik ol, hak ettiğin dinlenmeyi ver.",
        "Bugünün yorgunluğu, yarının enerjisi olacak.",
        "Sadece yorgun olmak bile bir başarıdır.",
        "Biraz kestirmek harika bir fikir.",
        "Bugün kendime bakma günü ilan ediyorum.",
        "Bir fincan sıcak içecek iyi gelir.",
        "Vücudumun sesini dinlemeyi öğreniyorum.",
        "Yatakta uzanmak en güzel şey.",
        "Şu an tek istediğim biraz dinlenmek.",
      ],
      colors: [Color(0xFF9400D3), Color(0xFF4B0082)],
    ),
    Mood(
      animationPath: "assets/emojis/dusunceli.json",
      title: "Düşünceli",
      descriptions: [
        "Yeni fikirler aklında dolaşıyor olabilir.",
        "Düşüncelerine kulak ver, harika sonuçlar çıkabilir.",
        "Belki de büyük bir karar arifesindesin.",
        "İç sesinle konuşmak için harika bir zaman.",
        "Zihnin aktif, bu yaratıcılığının bir göstergesi.",
        "Kendinle baş başa kalmak sana iyi gelebilir.",
        "Beyin fırtınası yapmanın tam zamanı.",
        "Yeni bir şeyler öğrenmek için harika bir gün.",
        "Her sorunun bir çözümü vardır, bulacaksın.",
        "Düşüncelerini bir yere not almak isteyebilirsin.",
        "Aklımda bir sürü yeni fikir dönüp duruyor.",
        "Bir karar vermeden önce her şeyi tartıyorum.",
        "Derin düşünmek, yeni bir perspektif kazandırır.",
        "Zihnimdeki karmaşayı çözmeye çalışıyorum.",
        "Bu durumu nasıl çözebileceğimi düşünüyorum.",
        "Belki de sadece sessizliğe ihtiyacım var.",
        "Hayatın anlamı üzerine kafa yoruyorum.",
        "Yeni bir başlangıç için plan yapıyorum.",
        "Bugün kendimle baş başa kalmak istiyorum.",
        "Gelecekle ilgili ne istediğimi düşünme zamanı.",
      ],
      colors: [Color(0xFFD2691E), Color(0xFF8B4513)],
    ),
    Mood(
      animationPath: "assets/emojis/saskin.json",
      title: "Şaşkın",
      descriptions: [
        "Bu seni çok şaşırttı, değil mi?",
        "Beklenmedik şeyler bazen harikadır.",
        "Gözlerin faltaşı gibi açıldı, ne oldu?",
        "Hayat sürprizlerle dolu, tadını çıkar.",
        "Şaşkınlık da bir duygudur, onu da kucakla.",
        "Yeni bir şey keşfetmiş gibisin.",
        "Bu durum karşısında ne hissedeceğini bilmiyorsun.",
        "İnanılmaz bir şeyle karşılaştın.",
        "Bazen kelimeler kifayetsiz kalır.",
        "Bu şaşkınlık, yeni bir maceranın başlangıcı olabilir.",
        "Gözlerime inanamıyorum, bu gerçek mi?",
        "Hiç beklemiyordum, tamamen şaşkınım.",
        "Bu sürpriz beni çok mutlu etti!",
        "Ne söyleyeceğimi bilemiyorum, dilim tutuldu.",
        "Bu kadarını hayal bile edemezdim.",
        "Bu, günümün en ilginç anıydı.",
        "Hayat beni her seferinde şaşırtıyor.",
        "Bazen şaşırmak harika bir duygudur.",
        "Şimdi tüm bu olanları sindirmem gerek.",
        "Bunu hiç tahmin edemezdim.",
      ],
      colors: [Color(0xFF8B008B), Color(0xFFFF69B4)],
    ),
    Mood(
      animationPath: "assets/emojis/ask.json",
      title: "Aşık",
      descriptions: [
        "Kalbin kelebeklerle dolu gibi.",
        "Sevgi dolu bir gün geçiriyorsun.",
        "Aşk, hayatın en güzel duygusudur.",
        "Bu hissi hissetmek harika olmalı.",
        "Gözlerin parlıyor, sebebi ne?",
        "Sevdiğin birine güzel bir sürpriz yap.",
        "Aşkın enerjisiyle dolusun.",
        "Sanki kalbinde bir çiçek açmış gibi.",
        "Aşk her şeyi güzelleştirir.",
        "Bugün kalbim yerinde durmuyor.",
        "Gözlerimin içi gülüyor, sebebi sensin.",
        "Aşk, dünyayı daha güzel bir yer yapıyor.",
        "Seninle olmak, her şeyi anlamlı kılıyor.",
        "Aşk dolu bir gün geçireceğim.",
        "Hayatımın en güzel rüyasısın.",
        "Kalbimde bir kelebekler ordusu var.",
        "Seni düşünmek bile beni mutlu ediyor.",
        "Bugün tüm dünya sevgi dolu görünüyor.",
        "Aşkın gücü her şeyin üstesinden gelir.",
      ],
      colors: [Color(0xFFFFB6C1), Color(0xFFDB7093)],
    ),
    Mood(
      animationPath: "assets/emojis/havali.json",
      title: "Havalı",
      descriptions: [
        "Bugün çok havalısın!",
        "Kendine güvenin tavan yapmış.",
        "Ortamın en cool insanı sensin.",
        "Güneş gözlüklerinle çok karizmatiksin.",
        "Bu özgüvenle her şeyin üstesinden gelirsin.",
        "Havalı olmak senin doğanda var.",
        "Kimseye aldırmadan kendi yolunda ilerle.",
        "Tarzınla herkesi etkiliyorsun.",
        "Sana sadece 'cool' denebilir.",
        "Bu havanı hiç bozma.",
        "Özgüvenim en üst seviyede, her şeye hazırım.",
        "Bugün tarzım ve tavrım konuşuyor.",
        "Kendimden eminim, kimseye ihtiyacım yok.",
        "Hayatı kendi kurallarıma göre yaşıyorum.",
        "Biraz havalı olmak kötü bir şey değil.",
        "Karizmam bugün tavan yaptı.",
        "Bugün kendime güveniyorum ve bu harika bir his.",
        "Herkesin bana baktığını hissediyorum.",
        "Bu havalı hissi seviyorum.",
        "Kendi hikayemin kahramanı benim.",
      ],
      colors: [Color(0xFF00CED1), Color(0xFF48D1CC)],
    ),
    Mood(
      animationPath: "assets/emojis/komik.json",
      title: "Komik",
      descriptions: [
        "Gülmekten gözünden yaş geldi!",
        "Bugün çok neşelisin, ne oldu?",
        "Kahkaha atmak gibisi yok.",
        "Etrafına neşe saçıyorsun.",
        "Gülmek, hayatın en güzel hediyesidir.",
        "Komik bir şey mi oldu, anlat da biz de gülelim.",
        "Bu enerjiyle günün harika geçecek.",
        "Gülmenin sesi bile güzel.",
        "İnsanları güldürmek harika bir yetenektir.",
        "Bugün moralin çok yüksek.",
        "Gülmekten karnıma ağrılar girdi!",
        "Bugün her şey bana komik geliyor.",
        "Etrafımdaki herkesi güldürmek istiyorum.",
        "Neşemle tüm dünyayı aydınlatacağım.",
        "Gülmek, en iyi terapidir.",
        "Bugün çok eğlenceli bir gün olacak gibi.",
        "Espri yeteneğim bugün pik yaptı.",
        "Gülmek, hayatın tadını çıkarmaktır.",
        "Küçük bir şaka bile günü güzelleştirebilir.",
        "Neşeli olmak harika bir şey.",
      ],
      colors: [Color(0xFF90EE90), Color(0xFF32CD32)],
    ),
    Mood(
      animationPath: "assets/emojis/sakin.json",
      title: "Sakin",
      descriptions: [
        "Bugün huzur ve sakinlik üzerindesin.",
        "Derin bir nefes al ve anın tadını çıkar.",
        "Zihnin dingin, ruhun huzurlu.",
        "Hayatın tüm karmaşasından uzaksın.",
        "Sakin bir gün geçirmek gibisi yok.",
        "Şu anki hissin çok değerli.",
        "Her şeyin yolunda olduğunu biliyorsun.",
        "Sakin kalmak, gücün bir işaretidir.",
        "Kendini çok rahatlamış hissediyorsun.",
        "Huzur, içten gelen bir histir.",
        "Huzur içinde, tamamen rahatlamış hissediyorum.",
        "Zihnim sakin, ruhum dingin.",
        "Her şeyin akışına bırakmanın ne kadar iyi olduğunu anladım.",
        "Bugün hiçbir şey beni strese sokamaz.",
        "Sakin kalmak, en büyük güçlerden biridir.",
        "İç huzurum yerinde, bu çok değerli.",
        "Tüm karmaşadan uzaklaşmış hissediyorum.",
        "Hayatın ritmi bugün benim için yavaşladı.",
        "Kendimi dinlemek için harika bir zaman.",
        "Bu huzurlu hissin kıymetini biliyorum.",
      ],
      colors: [Color(0xFF4682B4), Color(0xFF6495ED)],
    ),
  ];

  void _showMoodDialog(Mood mood) {
    showDialog(
      context: context,
      builder: (context) {
        return MoodDialog(
          mood: mood,
          onJournalButtonPressed: () {
            Navigator.of(context).pop();
            _navigateToJournalPage(mood);
          },
        );
      },
    );
  }

  void _navigateToJournalPage(Mood mood) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => JournalPage(mood: mood)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Emojilerin bulunduğu sayfa görünümü
          ScrollConfiguration(
            behavior: ScrollConfiguration.of(context).copyWith(
              dragDevices: {PointerDeviceKind.touch, PointerDeviceKind.mouse},
            ),
            child: PageView.builder(
              physics: const BouncingScrollPhysics(),
              controller: _pageController,
              itemCount: moods.length,
              itemBuilder: (context, index) {
                final mood = moods[index];
                return Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: mood.colors,
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Center(
                    child: MoodCard(mood: mood, onEmojiTap: _showMoodDialog),
                  ),
                );
              },
            ),
          ),
          // Uygulamanın adı olan MoodSay başlığı, sayfanın en üstüne yerleştirildi
          const Positioned(
            top: 40,
            left: 0,
            right: 0,
            child: SafeArea(
              child: Text(
                'MoodSay',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black, // Başlık rengi siyah
                  fontSize: 32, // Başlık boyutu biraz küçültüldü
                  fontWeight: FontWeight.w900, // Kalın yazı tipi
                  fontStyle: FontStyle.italic, // Eğik yazı tipi
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
          // Geri butonu
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
                  icon: const Icon(Icons.arrow_back, color: Colors.black),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      PageRouteBuilder(
                        transitionDuration: const Duration(milliseconds: 1000),
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            const SplashScreen(),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                              const begin = Offset(0.0, -1.0);
                              const end = Offset.zero;
                              const curve = Curves.ease;

                              var tween = Tween(
                                begin: begin,
                                end: end,
                              ).chain(CurveTween(curve: curve));

                              return SlideTransition(
                                position: animation.drive(tween),
                                child: child,
                              );
                            },
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _navigateToJournalPage(moods[_currentPageIndex]);
        },
        backgroundColor: Colors.white,
        child: const Icon(Icons.edit, color: Colors.black),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}

class MoodDialog extends StatelessWidget {
  final Mood mood;
  final VoidCallback onJournalButtonPressed;
  const MoodDialog({
    super.key,
    required this.mood,
    required this.onJournalButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    final randomDescription =
        mood.descriptions[Random().nextInt(mood.descriptions.length)];
    return AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: Column(
        children: [
          Lottie.asset(
            mood.animationPath,
            width: 100,
            height: 100,
            repeat: true,
            frameRate: FrameRate.max,
          ),
          const SizedBox(height: 10),
          Text(
            mood.title,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
        ],
      ),
      content: Text(
        randomDescription,
        textAlign: TextAlign.center,
        style: const TextStyle(color: Colors.black54, fontSize: 16),
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(
            'Kapat',
            style: TextStyle(
              color: mood.colors.first,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ElevatedButton(
          onPressed: onJournalButtonPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: mood.colors.first,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          child: const Text('Günlük Yaz'),
        ),
      ],
    );
  }
}

class MoodCard extends StatefulWidget {
  final Mood mood;
  final Function(Mood) onEmojiTap;

  const MoodCard({super.key, required this.mood, required this.onEmojiTap});

  @override
  State<MoodCard> createState() => _MoodCardState();
}

class _MoodCardState extends State<MoodCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    // Animasyon süresini 3 saniye olarak belirledik.
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.3,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    // Emojilerin sürekli animasyonlu olması için bu satırları ekliyoruz.
    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // Tıklama olaylarını sadece scale animasyonu için kullanıyoruz.
      // Emojinin sürekli animasyonu bu GestureDetector'dan bağımsız çalışacak.
      onTapDown: (_) => _controller.forward(),
      onTapUp: (_) => _controller.reverse(),
      onTapCancel: () => _controller.reverse(),
      onTap: () => widget.onEmojiTap(widget.mood),
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 150,
              height: 150,
              child: Lottie.asset(
                widget.mood.animationPath,
                controller: _controller,
                repeat: true,
                frameRate: FrameRate.max,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              widget.mood.title,
              style: Theme.of(context).textTheme.displayLarge?.copyWith(
                fontSize: 32,
                color: Colors.white,
                decoration: TextDecoration.none,
                shadows: const [
                  Shadow(
                    color: Colors.black45,
                    offset: Offset(2, 2),
                    blurRadius: 5,
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
