import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:movieslist/constans.dart';
import 'package:movieslist/my_icon_button.dart';

class MyAppHomeScreen extends StatefulWidget {
  const MyAppHomeScreen({super.key});

  @override
  State<MyAppHomeScreen> createState() => _MyAppHomeScreenState();
}

class _MyAppHomeScreenState extends State<MyAppHomeScreen> {
  final List<String> categories = ["All", "Action", "Drama", "Sci-Fi", "Horror", "Comedy"];
  int selectedCategoryIndex = 0;

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
                        "What do you watch Today?",
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          height: 1.2,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    MyIconButton(
                      icon: Iconsax.notification,
                      pressed: () {
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
                    fillColor: Colors.grey[900],
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
                          setState(() {
                            selectedCategoryIndex = index;
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 6),
                          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: selectedCategoryIndex == index ? Colors.blueAccent : Colors.grey[800],
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
                  child: PageView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      moviePoster("https://image.tmdb.org/t/p/w500//8Vs5FTHth3JJVoysF3Fb4CxlKxS.jpg"),
                      moviePoster("https://image.tmdb.org/t/p/w500//rC3GiEf9cWvVDNfxjWBhF1Syh9a.jpg"),
                      moviePoster("https://image.tmdb.org/t/p/w500//qNBAXBIQlnOThrVvA6mA2B5ggV6.jpg"),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // TRENDING MOVIES SECTION
                Text(
                  "Trending Now",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),

                // TRENDING MOVIE LIST
                Column(
                  children: [
                    trendingMovieItem("John Wick 4", "Action", "https://image.tmdb.org/t/p/w500//vZloFAK7NmvMGKE7VkF5UHaz0I.jpg"),
                    trendingMovieItem("Oppenheimer", "Drama", "https://image.tmdb.org/t/p/w500//svPLX5XkP7QFwkpxSiR2cYfaLeP.jpg"),
                    trendingMovieItem("Dune: Part Two", "Sci-Fi", "https://image.tmdb.org/t/p/w500//dU4HfnTEJDf9KvxGS9hgO7w9Dlx.jpg"),
                  ],
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
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(imageUrl, width: 50, height: 70, fit: BoxFit.cover),
        ),
        title: Text(title, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        subtitle: Text(genre, style: TextStyle(color: Colors.grey[400])),
        trailing: Icon(Iconsax.play, color: Colors.blueAccent),
      ),
    );
  }
}
