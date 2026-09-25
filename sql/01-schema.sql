CREATE DATABASE MovieRecommenderDB;
GO

USE MovieRecommenderDB;
GO

CREATE TABLE Users (
	user_id INT PRIMARY KEY
);
GO

CREATE TABLE Movies (
	movie_id INT PRIMARY KEY,
	title NVARCHAR(255) NOT NULL
);
GO

CREATE TABLE Genres (
	genre_id INT IDENTITY (1,1) PRIMARY KEY,
	genre_name NVARCHAR(50) NOT NULL UNIQUE
);
GO


CREATE TABLE MovieGenres (
    movie_id INT NOT NULL,
    genre_id INT NOT NULL,

    PRIMARY KEY (movie_id, genre_id),

    FOREIGN KEY (movie_id)
        REFERENCES Movies(movie_id),

    FOREIGN KEY (genre_id)
        REFERENCES Genres(genre_id)
);
GO

CREATE TABLE Ratings (
    user_id INT NOT NULL,
    movie_id INT NOT NULL,
    rating DECIMAL(2,1) NOT NULL,

    PRIMARY KEY (user_id, movie_id),

    FOREIGN KEY (user_id)
        REFERENCES Users(user_id),

    FOREIGN KEY (movie_id)
        REFERENCES Movies(movie_id),

    CHECK (rating >= 0.5 AND rating <= 5.0)
);
GO
