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
('Main Auditorium'),
('Mini Auditorium'),
('COEP Ground'),
('Academic Complex'),
('Cognizant Lab');

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
('Mindspark', 50, 4, 1, 1, '2023-01-01'),
('Impressions', 50, 2, 3, 3, '2022-12-21'),
('Zest', 50, 1, 4, 3, '2023-02-01'),
('RE-INIT', 50, 2, 1, 2, '2022-11-05'),
('FlossMeet', 50, 1, 1, 5, '2023-04-11'),
('Spandan', 50, 1, 3, 1, '2022-11-03');

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
('Admin1','password1'),
('Admin2','password2');

CREATE TABLE `ticket`(
  `p_id` INTEGER NOT NULL,
  `ticket_id` VARCHAR(100) NOT NULL,
  FOREIGN KEY (`p_id`) REFERENCES participants(`p_id`)
);
