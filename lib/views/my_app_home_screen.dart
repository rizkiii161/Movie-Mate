import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:movieslist/constans.dart';
import 'package:movieslist/api_service.dart'; // Import file API service

class MyAppHomeScreen extends StatefulWidget {
  const MyAppHomeScreen({super.key});

  @override
  State<MyAppHomeScreen> createState() => _MyAppHomeScreenState();
}

class _MyAppHomeScreenState extends State<MyAppHomeScreen> {
  final List<String> categories = ["All", "Action", "Drama", "Sci-Fi", "Horror", "Comedy"];
  int selectedCategoryIndex = 0;
  List<dynamic> trendingMovies = [];
  List<dynamic> filteredMovies = [];
  bool isLoading = true;
  Map<int, String> genres = {}; // Menyimpan daftar genre

  @override
  void initState() {
    super.initState();
    fetchTrendingMovies();
    fetchGenres(); // Ambil daftar genre saat inisialisasi
  }

  Future<void> fetchTrendingMovies() async {
    try {
      final movies = await ApiService.fetchTrendingMovies();
      print("Data from API: ${movies.length} movies"); // Debug: Cetak jumlah film
      setState(() {
        trendingMovies = movies;
        filteredMovies = movies; // Awalnya, filteredMovies sama dengan trendingMovies
        isLoading = false;
      });
    } catch (e) {
      print("Error fetching movies: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> fetchGenres() async {
    try {
      final genreList = await ApiService.fetchGenres();
      setState(() {
        genres = genreList;
      });
    } catch (e) {
      print("Error fetching genres: $e");
    }
  }

  void filterMoviesByCategory(int index) {
    setState(() {
      selectedCategoryIndex = index;
      if (index == 0) {
        // Jika "All" dipilih, tampilkan semua film
        filteredMovies = trendingMovies;
      } else {
        // Filter film berdasarkan genre
        final genreName = categories[index];
        final genreId = _getGenreId(genreName);
        filteredMovies = trendingMovies.where((movie) {
          final genreIds = movie['genre_ids'] as List<dynamic>;
          return genreIds.contains(genreId);
        }).toList();
      }
    });
  }

  int _getGenreId(String genreName) {
    // Mapping nama genre ke genre ID
    switch (genreName) {
      case "Action":
        return 28;
      case "Drama":
        return 18;
      case "Sci-Fi":
        return 878;
      case "Horror":
        return 27;
      case "Comedy":
        return 35;
      default:
        return 0;
    }
  }

  String getGenreNames(List<dynamic> genreIds) {
    return genreIds.map((id) => genres[id] ?? "Unknown").join(", ");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kbackgroundcolor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // HEADER: Title & Notification Button
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        "What do you want to watch Today?",
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          height: 1.2,
                          color: ktextcolor,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Iconsax.notification, color: ktextcolor),
                      onPressed: () {
                        print("Notification clicked");
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 15),

                // SEARCH BAR
                TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: ksecondarycolor,
                    hintText: "Search movies...",
                    hintStyle: TextStyle(color: Colors.grey[500]),
                    prefixIcon: Icon(Iconsax.search_normal, color: Colors.grey[500]),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // CATEGORY FILTER
                SizedBox(
                  height: 40,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          filterMoviesByCategory(index); // Panggil fungsi filter
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 6),
                          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: selectedCategoryIndex == index ? kbluecolor : ksecondarycolor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                            child: Text(
                              categories[index],
                              style: TextStyle(
                                color: selectedCategoryIndex == index ? Colors.white : Colors.grey[400],
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 20),

                // CAROUSEL MOVIE POSTERS
                SizedBox(
                  height: 200,
                  child: isLoading
                      ? Center(child: CircularProgressIndicator(color: kbluecolor))
                      : trendingMovies.isEmpty
                          ? Center(child: Text("No movies found", style: TextStyle(color: ktextcolor)))
                          : PageView(
                              scrollDirection: Axis.horizontal,
                              children: trendingMovies
                                  .sublist(0, trendingMovies.length < 4 ? trendingMovies.length : 4)
                                  .map((movie) => Stack(
                                        children: [
                                          moviePoster("https://image.tmdb.org/t/p/w500${movie['poster_path']}"),
                                          Positioned(
                                            bottom: 10,
                                            left: 10,
                                            right: 10,
                                            child: Container(
                                              padding: EdgeInsets.all(5),
                                              color: Colors.black.withOpacity(0.6),
                                              child: Text(
                                                movie['title'],
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold),
                                                textAlign: TextAlign.center,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ))
                                  .toList(),
                            ),
                ),
                const SizedBox(height: 20),

                // TRENDING MOVIES SECTION
                Text(
                  "Trending Now",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: ktextcolor,
                  ),
                ),
                const SizedBox(height: 10),

                // TRENDING MOVIE LIST
                isLoading
                    ? Center(child: CircularProgressIndicator(color: kbluecolor))
                    : filteredMovies.isEmpty
                        ? Center(child: Text("No movies found", style: TextStyle(color: ktextcolor)))
                        : Column(
                            children: filteredMovies
                                .map((movie) => trendingMovieItem(
                                      movie['title'],
                                      getGenreNames(movie['genre_ids']),
                                      "https://image.tmdb.org/t/p/w500${movie['poster_path']}",
                                    ))
                                .toList(),
                          ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // MOVIE POSTER WIDGET
  Widget moviePoster(String imageUrl) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        image: DecorationImage(
          image: NetworkImage(imageUrl),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  // TRENDING MOVIE ITEM
  Widget trendingMovieItem(String title, String genre, String imageUrl) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        color: ksecondarycolor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(imageUrl, width: 50, height: 70, fit: BoxFit.cover),
        ),
        title: Text(title, style: TextStyle(color: ktextcolor, fontWeight: FontWeight.bold)),
        subtitle: Text(genre, style: TextStyle(color: Colors.grey[400])),
        trailing: Icon(Iconsax.play, color: kbluecolor),
      ),
    );
  }
}