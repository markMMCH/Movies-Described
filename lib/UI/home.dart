import 'package:flutter/material.dart';
import 'package:project1/UI/model.dart';
import 'movie_ui/movie_ui.dart';

class MovieListView extends StatelessWidget {


  final List<Movie> movieList  = Movie.getMovies();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade900,
      appBar: AppBar(
        title: Text("Movies"),
        backgroundColor: Colors.blueGrey.shade900,
      ),
      body: ListView.builder(
          itemCount: movieList.length,
          itemBuilder: (BuildContext context, int index) {
            return Stack(children: [
              movieCard(movieList[index], context),
              Positioned(top: 10, child: movieImage(movieList[index].images[0])),
              
            ]);
          }),
    );
  }


  Widget movieCard(Movie movie, BuildContext context) {
    return InkWell(
      child: Container(
        margin: EdgeInsets.only(left: 70),
        width: MediaQuery.of(context).size.width,
        height: 120,
        child: Card(
          color: Colors.black45,
          child: Padding(
            padding: const EdgeInsets.all(35.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(movie.title, style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                        color: Colors.white
                      ),),
                    ),
                    Text("Rating ${movie.imdbRating} / 10", style: mainTextStyle(),)
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Released: ${movie.released}", style: mainTextStyle(),),
                    Text(movie.runtime, style: mainTextStyle(),),
                    Text(movie.rated, style: mainTextStyle(),)
                  ],
                )
              ],
            ),
          ),
        ),
      ),
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => MovieDetail(movie: movie, movieName: movie.title,)));
      },
    );
  }


  TextStyle mainTextStyle() {
    return TextStyle(
      fontSize: 15,
      color: Colors.grey
    );
  }

  Widget movieImage(String? imageUrl) {
      return Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(image: NetworkImage(imageUrl ?? 'https://i.picsum.photos/id/56/200/200.jpg?hmac=rRTTTvbR4tHiWX7-kXoRxkV7ix62g9Re_xUvh4o47jA'), fit: BoxFit.cover),
        ),
      );
  }

}


class MovieDetail extends StatelessWidget {
  final String movieName;
  final Movie movie;

  const MovieDetail({super.key, required this.movieName, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.movie.title),
        backgroundColor: Colors.blueGrey.shade900,
      ),
      body: ListView(
        children: [
          MovieDetailsThumbnail(thumbnail: movie.images[0]),
          MovieDetailsHeaderWithPoster(movie: movie),
          HorizontalLine(),
          MovieDetailsCast(movie: movie),
          HorizontalLine(),
          MovieDetailsExtraPosters(posters: movie.images),
        ],
      ),
    );
  }
}

