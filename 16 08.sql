CREATE DATABASE Movie_Booking_and_Ratings_Management_System;
USE Movie_Booking_and_Ratings_Management_System;
CREATE TABLE Movies (
    movie_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    genre VARCHAR(50),
    release_date DATE,
    duration_minutes INT
);
CREATE TABLE Customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100),
    phone VARCHAR(15)
);
CREATE TABLE Bookings (
    booking_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    movie_id INT,
    booking_date DATE,
    seats_booked INT,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    FOREIGN KEY (movie_id) REFERENCES Movies(movie_id)
);
CREATE TABLE Ratings (
    rating_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    movie_id INT,
    rating INT CHECK (rating BETWEEN 1 AND 5),
    review TEXT,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    FOREIGN KEY (movie_id) REFERENCES Movies(movie_id)
);
INSERT INTO Movies (title, genre, release_date, duration_minutes) VALUES
('Inception', 'Sci-Fi', '2010-07-16', 148),
('KGF Chapter 2', 'Action', '2022-04-14', 168),
('RRR', 'Historical Action', '2022-03-25', 182),
('Jawan', 'Action Drama', '2023-09-07', 165);

INSERT INTO Customers (name, email, phone) VALUES
('Ajith Kumar', 'ajith@example.com', '9876543210'),
('Meena Rani', 'meena@example.com', '9123456789'),
('Rajesh K', 'rajesh@example.com', '9988776655');

INSERT INTO Bookings (customer_id, movie_id, booking_date, seats_booked) VALUES
(1, 1, '2025-07-21', 2),
(2, 3, '2025-07-20', 3),
(3, 2, '2025-07-22', 1);

INSERT INTO Ratings (customer_id, movie_id, rating, review) VALUES
(1, 1, 5, 'Mind-blowing sci-fi movie!'),
(2, 3, 4, 'Great action and story.'),
(3, 2, 5, 'KGF is fire! Loved it.');

SELECT b.booking_id, c.name AS customer, m.title AS movie, 
       b.seats_booked, b.booking_date
FROM Bookings b
JOIN Customers c ON b.customer_id = c.customer_id
JOIN Movies m ON b.movie_id = m.movie_id;

SELECT m.title, ROUND(AVG(r.rating), 2) AS avg_rating
FROM Ratings r
JOIN Movies m ON r.movie_id = m.movie_id
GROUP BY m.title;

SELECT m.title, AVG(r.rating) AS avg_rating
FROM Ratings r
JOIN Movies m ON r.movie_id = m.movie_id
GROUP BY m.title
ORDER BY avg_rating DESC
LIMIT 3;

SELECT c.name, m.title, b.seats_booked, b.booking_date
FROM Bookings b
JOIN Customers c ON b.customer_id = c.customer_id
JOIN Movies m ON b.movie_id = m.movie_id
WHERE c.name = 'Ajith Kumar';

SELECT m.title, SUM(b.seats_booked) AS total_seats
FROM Bookings b
JOIN Movies m ON b.movie_id = m.movie_id
GROUP BY m.title;

SELECT m.title, r.review
FROM Ratings r
JOIN Movies m ON r.movie_id = m.movie_id
WHERE r.review LIKE '%action%';