-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 14, 2023 at 11:52 PM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.0.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `quiz_time`
--

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE `admin` (
  `admin_id` int(11) NOT NULL,
  `admin_username` varchar(45) NOT NULL,
  `admin_password` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`admin_id`, `admin_username`, `admin_password`) VALUES
(6, 'vincent', 'pbkdf2:sha256:600000$nvkYN9QQNU9mOy8N$597b216'),
(7, 'vincent', 'pbkdf2:sha256:600000$yD20PHg1LICLT453$34d7354');

-- --------------------------------------------------------

--
-- Table structure for table `alembic_version`
--

CREATE TABLE `alembic_version` (
  `version_num` varchar(32) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `alembic_version`
--

INSERT INTO `alembic_version` (`version_num`) VALUES
('2efcb698ced5');

-- --------------------------------------------------------

--
-- Table structure for table `category`
--

CREATE TABLE `category` (
  `category_id` int(11) NOT NULL,
  `category_name` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `category`
--

INSERT INTO `category` (`category_id`, `category_name`) VALUES
(1, 'Football'),
(2, 'Bible'),
(3, 'General Knowledge'),
(4, 'Current Affairs');

-- --------------------------------------------------------

--
-- Table structure for table `difficulty`
--

CREATE TABLE `difficulty` (
  `difficulty_id` int(11) NOT NULL,
  `description` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `difficulty`
--

INSERT INTO `difficulty` (`difficulty_id`, `description`) VALUES
(1, 'Easy'),
(2, 'Hard');

-- --------------------------------------------------------

--
-- Table structure for table `donation`
--

CREATE TABLE `donation` (
  `don_id` int(11) NOT NULL,
  `don_amt` float NOT NULL,
  `don_userid` int(11) DEFAULT NULL,
  `don_date` datetime DEFAULT NULL,
  `don_status` enum('pending','failed','paid') NOT NULL DEFAULT 'pending',
  `don_fullname` varchar(100) DEFAULT NULL,
  `don_email` varchar(100) DEFAULT NULL,
  `don_refno` varchar(20) NOT NULL,
  `don_paygate_response` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `donation`
--

INSERT INTO `donation` (`don_id`, `don_amt`, `don_userid`, `don_date`, `don_status`, `don_fullname`, `don_email`, `don_refno`, `don_paygate_response`) VALUES
(1, 5000, 2, '2023-07-08 18:40:58', 'pending', 'victor', 'victor@gmail.com', '66778000', NULL),
(2, 5000, 2, '2023-07-08 18:45:41', 'pending', 'victor', 'victor@gmail.com', '86784082', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `question`
--

CREATE TABLE `question` (
  `question_id` int(11) NOT NULL,
  `question` varchar(450) NOT NULL,
  `question_category_id` int(11) NOT NULL,
  `question_difficulty_id` int(11) NOT NULL,
  `option_1` varchar(120) NOT NULL,
  `option_2` varchar(120) NOT NULL,
  `option_3` varchar(120) NOT NULL,
  `option_4` varchar(120) NOT NULL,
  `correct_answer` varchar(120) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `question`
--

INSERT INTO `question` (`question_id`, `question`, `question_category_id`, `question_difficulty_id`, `option_1`, `option_2`, `option_3`, `option_4`, `correct_answer`) VALUES
(6, 'Which player scored the fastest hat-trick in the Premier League?', 1, 2, 'Sadio Mane', 'Robbie Fowler', 'Jermain Defoe', 'Gabriel Agbonlahor', 'Sadio Mane (2 minutes 56 seconds for Southampton vs Aston Villa in 2015)'),
(7, 'Three players share the record for most Premier League red cards (8). Who are they?', 1, 2, 'Patrick Vieira, Richard Dunne and Duncan Ferguson', 'Patrick Vieira, Richard Dunne and Roy Keane', 'Patrick Vieira, Roy Keane and Duncan Ferguson', 'Roy Keane, Richard Dunne and Duncan Ferguson', 'Patrick Vieira, Richard Dunne and Duncan Ferguson'),
(8, 'With 260 goals, who is the Premier League\'s all-time top scorer?', 1, 1, 'Harry Kane', 'Wayne Rooney', 'Alan Shearer', 'Christiano Ronaldo', 'Alan Shearer'),
(9, 'When was the inaugural Premier League season?', 1, 1, '1990-1991', '1992-1993', '1991-1992', '1993-1994', '1992-1993'),
(10, 'Which team won the first Premier League title?', 1, 1, 'Chelsea', 'Manchester City', 'Arsenal', 'Manchester United', 'Manchester United'),
(11, 'With 202 clean sheets, which goalkeeper has the best record in the Premier League?', 1, 1, 'David de Gea', 'Mark Schwarzer', 'Petr Cech', 'Peter Schmeichel', 'Petr Cech'),
(12, 'Which three players shared the Premier League Golden Boot in 2018-19?', 1, 1, 'Aubameyang, Salah and Mane', 'Aubameyang, Salah and Kane', 'Kane, Salah and Mane', 'Aubameyang, Vardy and Mane', 'Aubameyang, Salah and Mane'),
(13, 'The fastest goal scored in Premier League history came in 7.69 seconds. Who scored it?', 1, 1, 'Sadio Mane', 'Shane Long', 'Mo Salah', 'Harry Kane', 'Shane Long'),
(14, 'Which country won the first ever World Cup in 1930?', 1, 1, 'Brazil', 'Uruguay', 'Argentina', 'France', 'Uruguay'),
(15, 'Which country has won the most World Cups?', 1, 1, 'France', 'England', 'Brazil', 'Germany', 'Brazil'),
(16, 'Which country has appeared in three World Cup finals, but never won the competition?', 1, 2, 'England', 'Netherlands', 'Italy', 'U.S.A', 'Netherlands'),
(17, 'The 2026 World Cup will be hosted across three different countries. Can you name them?', 1, 2, 'England, Scotland and Ireland', 'Mexico, Canada and U.S.A', 'Morocco, Spain and Portugal ', 'Saudi Arabia, Qatar and Lebanon', 'Mexico, Canada and U.S.A'),
(18, 'In which World Cup did Diego Maradona score his infamous \'Hand of God\' goal?', 1, 2, 'Mexico,1986', 'U.S.A,1994', 'Italy,1990', '1982,Spain', 'Mexico,1986'),
(19, 'Which Ballon d\'Or-winning footballer had a galaxy named after them in 2015?', 1, 2, 'Ronaldo', 'Messi', 'Kaka', 'Ronaldinho', 'Ronaldo'),
(20, 'Which Portuguese team did Ronaldo play for before signing for Manchester United?', 1, 1, 'Benfica', 'Sporting', 'Porto', 'Rio Ave', 'Sporting'),
(21, 'Which German multinational sportswear company is Messi an ambassador for?', 1, 1, 'Nike', 'Adidas', 'Louis Vuitton', 'Fendi', 'Adidas'),
(22, 'Messi famously retired from international duty in which year before reversing his decision?', 1, 1, '2016', '2019', '2017', '2015', '2016'),
(23, 'Who is the only player to win the Champions League with three different clubs?', 1, 2, 'Christiano Ronaldo', 'Clearance Seedorf', 'Lionel Messi', 'Toni Kroos', 'Clearance Seedorf'),
(24, 'Which team was the first from the UK to win the European Cup?', 1, 2, 'Manchester United', 'Celtics', 'Liverpool', 'Nottingham Forests', 'Celtics'),
(25, 'Which outfield player appeared in the Champions League final in three different decades?', 1, 2, 'Paul Scholes', 'Ryan Giggs', 'Jermain Defoe', 'Roy Keane', 'Ryan Giggs'),
(26, 'Which one of the following three teams has not won the European Championship: Denmark, Belgium or Greece?', 1, 2, 'Denmark', 'Greece', 'Belgium', 'All of the above', 'Belgium'),
(27, 'FC Cologne have which animal on their club crest?', 1, 2, 'Rat', 'Goat', 'Cow', 'Dog', 'Goat'),
(28, 'Jurgen Klopp has managed two clubs in Germany, Borussia Dortmund and - can you name the other?', 1, 1, 'Bayern Munich', 'Cologne', 'Mainz', 'Frankfurt', 'Mainz'),
(29, 'I\'ve worn numbers 7, 17, 28 and 9 in my career, playing my football across, England, Spain, Italy and Portugal.', 1, 2, 'Zlatan Ibrahimovic', 'Cristiano Ronaldo', 'Carlos Tevez', 'Robbie Fowler', 'Cristiano Ronaldo'),
(30, 'Which club is associated with \'Galacticos\'?', 1, 1, 'Barcelona', 'Bayern munich', 'Sevilla', 'Real Madrid', 'Real Madrid'),
(31, 'Which club is sometimes referred to as FC Hollywood?', 1, 2, 'Bayern Munich', 'Barcelona', 'Benfica', 'Manchester United', 'Bayern Munich'),
(32, 'In video game FIFA 20, team Piemonte Calcio represents which real-life club?', 1, 2, 'Roma', 'Napoli', 'Juventus', 'Genoa', 'Juventus'),
(33, 'Which MLS franchise team does David Beckham own?', 1, 1, 'Austin FC', 'Inter Miami', ' FC Dallas', 'LA Galaxy', 'Inter Miami'),
(34, 'The Scudetto is the name given to the league title in which European country?', 1, 1, 'France', 'Spain', 'Italy', 'Germany', 'Italy'),
(35, 'Which club did Alan Shearer win the Premier League title with?', 1, 2, 'Newcastle United', 'Nottingham Forest', 'Blackburn Rovers', 'Portsmouth Fc', 'Blackburn Rovers'),
(36, 'Which 2 teams play in The Barcelona Derby?', 1, 1, 'Barcelona and Espanyol', 'Barcelona and Cadiz', 'Barcelona and Mallorca', 'Barcelona and Real Betis', 'Barcelona and Espanyol'),
(37, 'What is Juventus’ nickname?', 1, 1, 'Old Lady\'s', 'Old Guard', 'Blancolorris', 'The Striped', 'Old Lady\'s'),
(38, 'In what football league does ‘The Beckham Rule’ apply?', 1, 2, 'Premier League', 'La Liga', 'Seria A', 'MLS', 'MLS'),
(39, 'What country did Eusébio play international football for?', 1, 2, 'France', 'Brazil', 'Portugal', 'Argentina', 'Portugal'),
(40, 'At which club did Frank Lampard start his professional career?', 1, 2, 'Chelsea', 'Everton', 'West Ham', 'Aston Villa', 'West Ham'),
(41, 'Which club set a Premier League record for most goals scored in a match away from home when they beat Southampton 9-0?', 1, 1, 'Manchester United', 'Manchester City', 'Liverpool', 'Chelsea', 'Liverpool'),
(42, 'Which nation has won the African Cup of Nations the most?', 1, 2, 'Nigeria', 'Morocco', 'Egypt', 'Algeria', 'Egypt'),
(43, 'How many teams play in the group stages of the UEFA Champions League?', 1, 1, '64', '24', '32', '16', '32'),
(44, 'Which club did Thierry Henry play for before joining Arsenal?', 1, 2, 'PSG', 'Monaco', 'Lille', 'Barcelona', 'Monaco'),
(45, 'Which club has won the most FA Cup titles?', 1, 2, 'Manchester United', 'Chelsea', 'Arsenal', 'Liverpool', 'Arsenal'),
(46, 'In what US State is the city Nashville?', 3, 2, 'Texas', 'Tennessee', 'Alabama', 'Washington', 'Tennessee'),
(47, 'Which popular video game franchise has released games with the subtitles World At War and Black Ops?', 3, 2, 'PES', 'Fifa', 'Call of Duty', 'Gameloft', 'Call of Duty'),
(48, 'What is the smallest planet in our solar system?', 3, 1, 'Mars', 'Pluto', 'Venus', 'Mercury', 'Mercury'),
(49, 'What is the capital of New Zealand?', 3, 1, 'Auckland', 'Wellington', 'Sydney', 'Melbourne', 'Wellington'),
(50, 'What is the name of the main antagonist in the Shakespeare play Othello?', 3, 2, 'Othello', 'Iago', ' Desdemona', 'Cassio', 'Iago'),
(51, 'What is the currency of Denmark?', 3, 2, 'Euros', 'Dollars', 'Pounds', 'Krone', 'Krone'),
(52, 'What is the largest island in the Caribbean?', 3, 1, 'Jamaica', 'Dominica', 'Antigua and Barbadus', 'Cuba', 'Cuba'),
(53, 'What is the main language spoken in Switzerland? ', 3, 2, 'French', 'Romansh', 'German', 'Italian', 'German'),
(54, 'Which country has the most time zones?', 3, 1, 'France', 'U.S.A', 'Australia', 'Canada', 'France'),
(55, 'Which element is represented by the chemical symbol “O”?', 3, 1, 'Osmium', 'Oxygen', 'Ozone', 'Carbon', 'Oxygen'),
(56, 'What is the main language spoken in Australia?', 3, 1, 'French', 'English', 'Spanish', 'Portugese', 'English'),
(57, 'What is the world’s second-largest country by land area?', 3, 1, 'U.S.A', 'Russia', 'Mali', 'Canada', 'Canada'),
(58, 'Which planet in our solar system has the longest day?', 3, 2, 'Mercury', 'Earth', 'Mars', 'Venus', 'Venus'),
(59, 'What is the largest organ in the human body?', 3, 1, 'Ear', 'Heart', 'Skin', 'Mouth', 'Skin'),
(60, 'What is the smallest U.S. state by land area?', 3, 2, 'New Jersey', 'Rhodes Island', 'Vermont', 'Alaska', 'Rhodes Island'),
(61, 'Which country is known as the Land of the Midnight Sun? ', 3, 2, 'Greece', 'Norway', 'Scotland', 'Isreal', 'Norway'),
(62, 'What is the capital of Turkey?', 3, 1, 'Istanbul', 'Ankara', 'Trabzon', 'Bodum', 'Ankara'),
(63, 'What is the fastest  animal?', 3, 1, 'Golden Eagle', 'Peregrine Falcon', 'Cheetah', 'Sailfish', 'Peregrine Falcon'),
(64, 'Which famous explorer discovered America? ', 3, 1, 'Mungo Park', 'Marco Polo', 'Vasco da Gama', 'Christopher Columbus', 'Christopher Columbus'),
(65, 'What is the national flower of England?', 3, 2, 'Tulip', 'Rose', 'Lily', 'Orchid', 'Rose'),
(66, 'Which country is known for inventing the pizza?', 3, 2, 'Spain', 'U.S.A', 'Italy', 'France', 'Italy'),
(67, 'What is the largest country in South America? ', 3, 1, 'Brazil', 'Argentina', 'Uruguay', 'Chile', 'Brazil'),
(68, 'What is the name of the world’s largest river by volume?', 3, 2, 'Pacific', 'River Thames', 'Amazon River', 'River Nile', 'Amazon River'),
(69, 'Who wrote the novel “The Old Man and the Sea”?', 3, 2, 'C.S Lewis', 'Ernest Hemingway', 'Stephen King', 'Nora Roberts', 'Ernest Hemingway'),
(70, 'What is the largest continent by land area?', 3, 1, 'Europ', 'Asia', 'Africa', 'North America', 'Asia'),
(71, 'Which country is known for inventing the yo-yo? ', 3, 2, 'U.S.A', 'China', 'Italy', 'Philippines', 'Philippines'),
(72, 'What is the primary ingredient in sushi? ', 3, 2, 'Meat', 'Rice', 'Cucumber', 'Nori', 'Rice'),
(73, 'Which planet is known as the gas giant with the Great Red Spot?', 3, 2, 'Mars', 'Saturn', 'Neptune', 'Jupiter', 'Jupiter'),
(74, 'Who is the author of the “Harry Potter” series? ', 3, 1, 'Stephen King', 'Nora Roberts', 'J.K Rawlings', 'Dan Brown', 'J.K Rowling'),
(75, 'What is the largest internal organ in the human body?', 3, 1, 'Skin', 'Kidney', 'Heart', 'Liver', 'Liver'),
(76, 'Which athlete holds the record for the most Olympic gold medals won? ', 3, 1, 'Usain Bolt', 'Allyson Felix', 'Michael Phelps', 'Jenny Thompson', 'Michael Phelps'),
(77, 'In which sport is the Davis Cup awarded? ', 3, 2, 'Tennis', 'Football', 'Cycling', 'Driving', 'Tennis'),
(78, 'What is the scientific term for the process of cell division?', 3, 1, 'Miosis', 'Osmosis', 'Mitosis', 'Oesteoporosis', 'Mitosis'),
(79, 'What African country is known as the “Land of a Thousand Hills”? ', 3, 2, 'Mali', 'Rwanda', 'Egypt', 'Kenya', 'Rwanda'),
(80, 'Which animated film features the song “Let It Go”?', 3, 1, 'Teen Titans', 'Sophia the First', 'Frozen', 'Super Friends', 'Frozen'),
(81, 'What is the largest country in the world by land area?', 3, 1, 'Canada', 'Russia', 'U.S.A', 'China', 'Russia'),
(82, 'What is the hardest natural substance on Earth?', 3, 2, 'Rock', 'Silver', 'Gold', 'Diamond', 'Diamond'),
(83, 'Which organ in the human body produces insulin?', 3, 2, 'Heart', 'Liver', 'Kidney', 'Pancreas', 'Pancreas'),
(85, 'What is the largest island in the world?', 3, 2, 'Greenland', 'Rhodes Island', 'Jamaica', 'Cuba', 'Greenland'),
(86, 'How many hearts does an octopus have?', 3, 1, '1', '2', '3', '4', '3'),
(87, 'How many days did God take to create the world?', 2, 1, '5days', '7days', '6days', 'None', '6days'),
(88, 'What was God’s sign to Noah that he would never destroy the earth again?', 2, 1, 'Rain', 'Fire', 'Rainbow', 'Flood', 'Rainbow'),
(89, 'How many Siblings did Joseph have?', 2, 2, '11', '10', '12', '13', '12'),
(90, 'Through what did God speak to Moses in the desert?', 2, 2, 'Cloud', 'Fire', 'Burning bush', 'Moutain', 'Burning bush'),
(91, 'Where did God give Moses the Ten Commandments?', 2, 1, 'Mount Horeb', 'Mount Sinai', 'Mount Nebo', 'Mount Seer', 'Mount Sinai'),
(92, 'What day of the week did Jesus rise back to life?', 2, 1, 'Friday', 'Monday', 'Tuesday', 'Sunday', 'Sunday'),
(93, 'How many books have the name John in them?', 2, 1, '3', '2', '4', '1', '4'),
(94, 'Which book did Jesus directly write?', 2, 2, 'Revelations', 'Romans', 'Acts', 'None', 'None'),
(95, ' How many sling-throws did it take David to hit Goliath?', 2, 2, '3', '2', '5', '1', '1'),
(96, 'How many of Jesus’ brothers are named in the Bible?', 2, 2, '3', '1', '2', '4', '4'),
(97, ': What was most likely the first of Paul\'s letters written?', 2, 2, 'Acts', 'Romans', '1 Corinthians', '1 Thessalonians.', '1 Thessalonians.'),
(98, 'Who was the woman judge who led Israel to victory?', 2, 1, 'Ruth', 'Esther', 'Deborah', 'Mabel', 'Deborah'),
(99, 'How many times did David spare Saul’s life?', 2, 2, '2', '0', '1', '3', '2'),
(100, 'Who was David’s son that started a rebellion against him?', 2, 2, 'Abner', 'Absalom', 'Joab', 'Solomon', 'Absalom'),
(101, 'Which Apostle shared the Gospel with an Ethiopian official on the road to Gaza?', 2, 2, 'Stephen', 'Peter', 'Philip', 'Mark', 'Philip'),
(102, ' In what city were Jesus’ followers first called “Christians”?', 2, 2, 'Samaria', 'Jerusalem', 'Corithn', 'Antioch', 'Antioch'),
(103, 'Which angel told Daniel the meaning of his vision of the ram and the goat?', 2, 2, 'Michael', 'Gabriel', 'Huriel', 'None', 'Gabriel'),
(104, 'Which tribe of Israel received no inheritance of land?', 2, 2, 'Simeon', 'Levi', 'Joseph', 'Reuben', 'Levi'),
(105, 'Which missionary was described as having known the holy scriptures from an early age?', 2, 2, 'Timothy', 'Silas', 'Paul', 'Philip', 'Timothy'),
(106, 'Who pretended to be mad to avoid capture and death at the hands of an enemy king?', 2, 2, 'Saul', 'David', 'Jonathan', 'Samson', 'David'),
(107, 'What is the common name given to the first four books of the New Testament?', 2, 1, 'Epistles', 'Gospel', 'Tenet', 'The Early Books', 'Gospels'),
(108, 'What language was most of the New Testament originally written in?', 2, 1, 'Roman', 'Hebrew', 'Greek', 'Latin', 'Greek'),
(109, 'Which wood has been used by Noah to build the ark?', 2, 2, 'Mahogany', 'Acacias', 'Gopher', 'Borwood', 'Gopher'),
(110, 'What is the last word in the Old Testament?', 2, 2, 'Blessing', 'God', 'Amen', 'Curse', 'Curse'),
(111, ' How many books are in the New Testament?', 2, 1, '25', '26', '24', '27', '27'),
(112, 'What tribe is Paul from?', 2, 2, 'Judah', 'Levi', 'Benjamin', 'Reuben', 'Benjamin'),
(113, 'How many people boarded Noah’s Ark?', 2, 1, '7', '6', '4', '8', '8'),
(114, 'The Bible has how many divisions and sections?', 2, 2, '8', '4', '6', '2', '8'),
(115, ' How many blemishes was a sacrificial beast allowed to have?', 2, 1, '1', 'few', 'many', 'none', 'none'),
(116, 'What did Felix feel when Paul told him of Christ?', 2, 2, 'Happy', 'Naive', 'Fear', 'Suprised', 'Fear'),
(117, 'What animal is slain for the feast of Passover?', 2, 1, 'Ram', 'Cow', 'Lamb', 'Goat', 'Lamb'),
(118, 'Who did Peter raise from the dead in the city of Joppa?', 2, 1, 'Anna', 'Dorcas', 'Lazarus', 'Blind Man', 'Dorcas'),
(119, 'How many times did Noah send out a dove from the Ark?', 2, 1, '4', '2', '3', '1', '3'),
(120, 'In the Old Testament, which prophet foretold of Jesus’ birth?', 2, 1, 'Zachariah', 'Jeremiah', 'Malachi', 'Micah', 'Micah'),
(121, 'Which of the 12 apostles did not have his feet washed by Jesus?', 2, 1, 'Peter', 'Judas', 'John', 'None', 'None'),
(122, 'How old was Noah when the flood began?', 2, 1, '500', '300', '700', '600', '600'),
(123, 'How many sacraments are there?', 2, 1, '5', '2', '10', '7', '7'),
(124, 'How many Beatitudes are there?', 2, 1, '11', '10', '8', '7', '11'),
(125, 'How many works of the flesh are there?', 2, 1, '100', '10', '17', 'uncountable', '17'),
(126, 'How many people were at the Last Supper?', 2, 1, '12', '13', '10', '15', '13');

-- --------------------------------------------------------

--
-- Table structure for table `quiz`
--

CREATE TABLE `quiz` (
  `quiz_id` int(11) NOT NULL,
  `quiz_name` varchar(45) NOT NULL,
  `quiz_difficulty_id` int(11) NOT NULL,
  `date` datetime DEFAULT NULL,
  `time_started` datetime DEFAULT NULL,
  `time_ended` datetime DEFAULT NULL,
  `quiz_status` enum('1','0') NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `quiz`
--

INSERT INTO `quiz` (`quiz_id`, `quiz_name`, `quiz_difficulty_id`, `date`, `time_started`, `time_ended`, `quiz_status`) VALUES
(5, 'Quizwas', 1, '2023-07-01 21:22:51', '2023-07-01 21:22:51', '2023-07-01 21:22:51', '0'),
(7, 'Quiz Bucks', 2, '2023-07-07 12:02:58', '2023-07-07 12:02:58', '2023-07-07 12:02:58', '0'),
(8, 'Clever Bot', 2, '2023-07-07 19:16:26', '2023-07-07 19:16:26', '2023-07-07 19:16:26', '1'),
(9, 'Quiz Me', 2, '2023-07-13 13:56:02', '2023-07-13 13:56:02', '2023-07-13 13:56:02', '1');

-- --------------------------------------------------------

--
-- Table structure for table `quiz_question`
--

CREATE TABLE `quiz_question` (
  `quiz_question_id` int(11) NOT NULL,
  `quiz_question_quiz_id` int(11) NOT NULL,
  `quiz_question_question_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `quiz_question`
--

INSERT INTO `quiz_question` (`quiz_question_id`, `quiz_question_quiz_id`, `quiz_question_question_id`) VALUES
(11, 5, 124),
(12, 5, 125),
(13, 5, 126),
(14, 5, 6),
(15, 5, 7),
(16, 5, 8),
(17, 5, 9),
(18, 7, 16),
(19, 7, 17),
(20, 7, 18),
(21, 7, 19),
(22, 7, 20),
(23, 7, 21),
(24, 7, 22),
(25, 8, 40),
(26, 8, 41),
(27, 8, 42),
(28, 8, 43),
(29, 8, 44),
(30, 8, 45),
(31, 8, 46),
(32, 8, 47),
(33, 8, 48),
(34, 8, 49),
(35, 8, 50),
(36, 8, 51),
(37, 8, 52),
(38, 8, 53),
(39, 8, 54),
(40, 8, 55),
(41, 8, 56),
(42, 8, 57),
(43, 8, 58),
(44, 8, 59),
(45, 8, 60),
(46, 8, 63),
(47, 8, 64),
(48, 8, 65),
(49, 8, 66),
(50, 8, 67),
(51, 8, 69),
(52, 8, 70),
(53, 8, 77),
(54, 8, 78),
(55, 8, 80),
(56, 8, 82),
(57, 8, 85),
(58, 8, 104),
(59, 8, 105),
(60, 8, 109),
(61, 8, 110),
(62, 8, 115),
(63, 8, 126),
(64, 9, 7),
(65, 9, 9),
(66, 9, 11),
(67, 9, 12),
(68, 9, 13),
(69, 9, 16),
(70, 9, 17),
(71, 9, 18),
(72, 9, 20),
(73, 9, 22),
(74, 9, 24),
(75, 9, 25),
(76, 9, 27),
(77, 9, 29),
(78, 9, 32),
(79, 9, 35),
(80, 9, 37),
(81, 9, 39),
(82, 9, 41),
(83, 9, 44),
(84, 9, 46),
(85, 9, 48),
(86, 9, 50),
(87, 9, 52),
(88, 9, 55),
(89, 9, 58),
(90, 9, 60),
(91, 9, 61),
(92, 9, 63),
(93, 9, 65),
(94, 9, 69),
(95, 9, 72),
(96, 9, 74),
(97, 9, 78),
(98, 9, 82),
(99, 9, 87),
(100, 9, 89),
(101, 9, 91),
(102, 9, 93),
(103, 9, 96),
(104, 9, 99),
(105, 9, 105),
(106, 9, 109),
(107, 9, 113),
(108, 9, 117),
(109, 9, 121),
(110, 9, 124);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` int(11) NOT NULL,
  `user_email` varchar(45) NOT NULL,
  `user_password` varchar(120) NOT NULL,
  `user_mobile` varchar(15) NOT NULL,
  `datereg` datetime DEFAULT NULL,
  `firstname` varchar(45) NOT NULL,
  `lastname` varchar(45) NOT NULL,
  `pix` varchar(120) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `user_email`, `user_password`, `user_mobile`, `datereg`, `firstname`, `lastname`, `pix`) VALUES
(1, 'vincent@gmail.com', 'pbkdf2:sha256:600000$Xy6qTsAem3hBS1en$eb57d7f31caced7c70205817558650392c1f7216bd2b28eb4edb8ff9d6c3dcb8', '07063013655', '2023-06-21 18:57:10', 'OMOTAYO', 'DAISI', NULL),
(2, 'victor@gmail.com', 'pbkdf2:sha256:600000$BVepQciyJxjNRbeE$38b1a8150d86d25c0a3fac43690ec8964268df7fd98dcdbdfdfdf4bccdab130a', '08106244030', '2023-07-01 09:03:23', 'Victor', 'Daisi', 'vincent.jpg'),
(3, 'george74@gmail.com', 'pbkdf2:sha256:600000$lUf0SypoYmvUzoVx$e354c4f6322ef8c87c32aaa7e22aa1320bfdf687a3c5050022ccaba44ec10951', '090243636446', '2023-07-03 17:14:31', 'george', 'gbolade', NULL),
(4, 'adafirstjohn@gmail.com', 'pbkdf2:sha256:600000$6Vvc5jicvvZvtSNK$1111b7d8dc59a3f530576f1d4fe9e1826bcf46aa68a952538da834ba3d437b94', '07025848478', '2023-07-13 13:43:14', 'Adaora', 'Onye', NULL),
(5, 'vincent@gmail.com', 'pbkdf2:sha256:600000$pyUxGFnH9y9M0cAE$5fd5e91687dbdc17aaa839d723d13f6b5f5bf838f7b52a89327075fa194faa38', '07063013655', '2023-07-14 20:50:46', 'OMOTAYO', 'DAISI', NULL),
(6, 'vin@gmail.com', 'pbkdf2:sha256:600000$hklttX8opNv9BZ34$556c71c62e96e02785336167a3f426cee792ceeb1087f73b1d2203bb6fe4b362', '07063013655', '2023-07-14 20:53:16', 'OMOTAYO', 'DAISI', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `user_quiz_answer`
--

CREATE TABLE `user_quiz_answer` (
  `user_quiz_answer_id` int(11) NOT NULL,
  `correct_answer` varchar(45) NOT NULL,
  `user_answer_quiz_id` int(11) DEFAULT NULL,
  `user_answer_question_id` int(11) DEFAULT NULL,
  `user_answer_user_id` int(11) DEFAULT NULL,
  `user_answer` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `user_quiz_answer`
--

INSERT INTO `user_quiz_answer` (`user_quiz_answer_id`, `correct_answer`, `user_answer_quiz_id`, `user_answer_question_id`, `user_answer_user_id`, `user_answer`) VALUES
(1, 'West Ham', 8, 40, 2, 'West Ham');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`admin_id`);

--
-- Indexes for table `alembic_version`
--
ALTER TABLE `alembic_version`
  ADD PRIMARY KEY (`version_num`);

--
-- Indexes for table `category`
--
ALTER TABLE `category`
  ADD PRIMARY KEY (`category_id`);

--
-- Indexes for table `difficulty`
--
ALTER TABLE `difficulty`
  ADD PRIMARY KEY (`difficulty_id`);

--
-- Indexes for table `donation`
--
ALTER TABLE `donation`
  ADD PRIMARY KEY (`don_id`),
  ADD KEY `don_userid` (`don_userid`);

--
-- Indexes for table `question`
--
ALTER TABLE `question`
  ADD PRIMARY KEY (`question_id`),
  ADD KEY `question_category_id` (`question_category_id`),
  ADD KEY `question_difficulty_id` (`question_difficulty_id`);

--
-- Indexes for table `quiz`
--
ALTER TABLE `quiz`
  ADD PRIMARY KEY (`quiz_id`),
  ADD KEY `quiz_difficulty_id` (`quiz_difficulty_id`);

--
-- Indexes for table `quiz_question`
--
ALTER TABLE `quiz_question`
  ADD PRIMARY KEY (`quiz_question_id`),
  ADD KEY `quiz_question_question_id` (`quiz_question_question_id`),
  ADD KEY `quiz_question_quiz_id` (`quiz_question_quiz_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`);

--
-- Indexes for table `user_quiz_answer`
--
ALTER TABLE `user_quiz_answer`
  ADD PRIMARY KEY (`user_quiz_answer_id`),
  ADD KEY `user_answer_question_id` (`user_answer_question_id`),
  ADD KEY `user_answer_quiz_id` (`user_answer_quiz_id`),
  ADD KEY `user_answer_user_id` (`user_answer_user_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admin`
--
ALTER TABLE `admin`
  MODIFY `admin_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `category`
--
ALTER TABLE `category`
  MODIFY `category_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `difficulty`
--
ALTER TABLE `difficulty`
  MODIFY `difficulty_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `donation`
--
ALTER TABLE `donation`
  MODIFY `don_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `question`
--
ALTER TABLE `question`
  MODIFY `question_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=127;

--
-- AUTO_INCREMENT for table `quiz`
--
ALTER TABLE `quiz`
  MODIFY `quiz_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `quiz_question`
--
ALTER TABLE `quiz_question`
  MODIFY `quiz_question_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=111;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `user_quiz_answer`
--
ALTER TABLE `user_quiz_answer`
  MODIFY `user_quiz_answer_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `donation`
--
ALTER TABLE `donation`
  ADD CONSTRAINT `donation_ibfk_1` FOREIGN KEY (`don_userid`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `question`
--
ALTER TABLE `question`
  ADD CONSTRAINT `question_ibfk_1` FOREIGN KEY (`question_category_id`) REFERENCES `category` (`category_id`),
  ADD CONSTRAINT `question_ibfk_2` FOREIGN KEY (`question_difficulty_id`) REFERENCES `difficulty` (`difficulty_id`);

--
-- Constraints for table `quiz`
--
ALTER TABLE `quiz`
  ADD CONSTRAINT `quiz_ibfk_1` FOREIGN KEY (`quiz_difficulty_id`) REFERENCES `difficulty` (`difficulty_id`);

--
-- Constraints for table `quiz_question`
--
ALTER TABLE `quiz_question`
  ADD CONSTRAINT `quiz_question_ibfk_1` FOREIGN KEY (`quiz_question_question_id`) REFERENCES `question` (`question_id`),
  ADD CONSTRAINT `quiz_question_ibfk_2` FOREIGN KEY (`quiz_question_quiz_id`) REFERENCES `quiz` (`quiz_id`);

--
-- Constraints for table `user_quiz_answer`
--
ALTER TABLE `user_quiz_answer`
  ADD CONSTRAINT `user_quiz_answer_ibfk_1` FOREIGN KEY (`user_answer_question_id`) REFERENCES `question` (`question_id`),
  ADD CONSTRAINT `user_quiz_answer_ibfk_2` FOREIGN KEY (`user_answer_quiz_id`) REFERENCES `quiz` (`quiz_id`),
  ADD CONSTRAINT `user_quiz_answer_ibfk_3` FOREIGN KEY (`user_answer_user_id`) REFERENCES `users` (`user_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
