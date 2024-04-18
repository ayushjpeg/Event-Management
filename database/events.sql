CREATE TABLE `event_type` (
  `type_id` INTEGER PRIMARY KEY AUTOINCREMENT,
  `type_title` TEXT NOT NULL
);

INSERT INTO `event_type` (`type_title`) VALUES
('Technical'),
('Gaming'),
('Cultural'),
('Sports'),
('Trivia');

CREATE TABLE `venue`(
  `venue_id` INTEGER PRIMARY KEY AUTOINCREMENT,
  `venue_name` VARCHAR(100) NOT NULL
);

INSERT INTO `venue` (`venue_name`) VALUES
('Lords'),
('Oval'),
('Parade Ground'),
('Academic Complex'),
('Computer Lab');

CREATE TABLE `events` (
  `event_id` INTEGER PRIMARY KEY AUTOINCREMENT,
  `event_title` VARCHAR(100) NOT NULL,
  `event_price` INTEGER NOT NULL,
  `participants` INTEGER NOT NULL,
  `type_id` INTEGER NOT NULL,
  `venue_id` INTEGER NOT NULL,
  `date` DATE NOT NULL,
  FOREIGN KEY (`type_id`) REFERENCES event_type(`type_id`),
  FOREIGN KEY (`venue_id`) REFERENCES venue(`venue_id`)
);

INSERT INTO `events` (`event_title`, `event_price`, `participants`, `type_id`, `venue_id`, `date`) VALUES
('Artival', 50, 40, 3, 3, '2024-04-19'),
('The Beings Night', 50, 20, 3, 3, '2024-04-19'),
('Quizmania', 50, 10, 5, 4, '2024-04-20'),
('Saturnalia', 50, 20, 1, 2, '2024-04-20'),
('Hackathon', 50, 10, 1, 5, '2024-04-21'),
('Wolfame', 50, 10, 2, 3, '2024-04-22');

CREATE TABLE `participants` (
  `p_id` INTEGER PRIMARY KEY AUTOINCREMENT,
  `event_id` INTEGER NOT NULL,
  `fullname` VARCHAR(100) NOT NULL,
  `email` VARCHAR(300) NOT NULL,
  `mobile` CHAR(10) NOT NULL,
  `college` VARCHAR(300) NOT NULL,
  FOREIGN KEY (`event_id`) REFERENCES events(`event_id`)
);


CREATE TABLE `admin`(
  `username` VARCHAR(100) NOT NULL,
  `password` VARCHAR(100) NOT NULL
);

INSERT INTO `admin` VALUES
('Admin','Admin123');


