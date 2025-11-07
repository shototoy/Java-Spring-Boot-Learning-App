DROP DATABASE IF EXISTS learning_db;
CREATE DATABASE learning_db CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE learning_db;

CREATE TABLE users (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    role VARCHAR(50) NOT NULL,
    section VARCHAR(100)
);

CREATE TABLE lessons (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    subject VARCHAR(100) NOT NULL,
    title VARCHAR(255) NOT NULL,
    content TEXT NOT NULL,
    video_url VARCHAR(500),
    order_num INT NOT NULL
);

CREATE TABLE quizzes (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    subject VARCHAR(100) NOT NULL,
    title VARCHAR(255) NOT NULL,
    duration INT NOT NULL
);

CREATE TABLE questions (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    quiz_id BIGINT NOT NULL,
    text TEXT NOT NULL,
    option_a VARCHAR(500) NOT NULL,
    option_b VARCHAR(500) NOT NULL,
    option_c VARCHAR(500) NOT NULL,
    option_d VARCHAR(500) NOT NULL,
    correct_answer CHAR(1) NOT NULL,
    FOREIGN KEY (quiz_id) REFERENCES quizzes(id) ON DELETE CASCADE
);

CREATE TABLE quiz_attempts (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    student_id BIGINT NOT NULL,
    quiz_id BIGINT NOT NULL,
    score INT NOT NULL,
    completed_at DATETIME NOT NULL,
    FOREIGN KEY (student_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (quiz_id) REFERENCES quizzes(id) ON DELETE CASCADE
);

CREATE TABLE progress (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    student_id BIGINT NOT NULL,
    lesson_id BIGINT NOT NULL,
    completion INT DEFAULT 0,
    FOREIGN KEY (student_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (lesson_id) REFERENCES lessons(id) ON DELETE CASCADE
);

INSERT INTO users (name, email, password, role, section) VALUES
('Teacher Admin', 'teacher@school.com', 'teacher123', 'TEACHER', NULL),
('John Smith', 'john@student.com', 'student123', 'STUDENT', 'Section A'),
('Maria Garcia', 'maria@student.com', 'student123', 'STUDENT', 'Section A'),
('David Lee', 'david@student.com', 'student123', 'STUDENT', 'Section B'),
('Sarah Johnson', 'sarah@student.com', 'student123', 'STUDENT', 'Section B');

INSERT INTO lessons (subject, title, content, video_url, order_num) VALUES
('math', 'Introduction to Fractions', 'A fraction represents a part of a whole. It consists of a numerator (top number) and denominator (bottom number). For example, 1/2 means one part out of two equal parts. Understanding fractions is essential for everyday math, from cooking to measuring distances.', 'https://www.youtube.com/watch?v=example1', 1),
('math', 'Adding and Subtracting Fractions', 'To add or subtract fractions, they must have the same denominator. If denominators are different, find the least common denominator (LCD). Example: 1/4 + 1/2 = 1/4 + 2/4 = 3/4. Always simplify your answer to its lowest terms.', 'https://www.youtube.com/watch?v=example2', 2),
('math', 'Multiplying Fractions', 'To multiply fractions, multiply the numerators together and the denominators together. Example: 2/3 × 3/4 = (2×3)/(3×4) = 6/12 = 1/2. Remember to simplify your final answer.', NULL, 3),
('english', 'Parts of Speech', 'English has eight main parts of speech: nouns, pronouns, verbs, adjectives, adverbs, prepositions, conjunctions, and interjections. Each plays a unique role in sentence structure. Understanding these helps you communicate more effectively.', 'https://www.youtube.com/watch?v=example3', 1),
('english', 'Writing Complex Sentences', 'Complex sentences contain one independent clause and at least one dependent clause. Example: "Although it was raining, we went to the park." The dependent clause adds detail to the main idea. Using complex sentences makes your writing more sophisticated.', NULL, 2),
('english', 'Reading Comprehension Strategies', 'Effective reading involves previewing the text, identifying main ideas, making connections, and asking questions. Always read actively by highlighting key points and taking notes. Summarizing paragraphs in your own words helps retain information.', 'https://www.youtube.com/watch?v=example4', 3),
('science', 'The Water Cycle', 'The water cycle describes how water moves on, above, and below Earth surface. It includes evaporation (water turns to vapor), condensation (vapor becomes clouds), precipitation (rain/snow), and collection (water returns to bodies of water). This cycle is continuous and vital for life.', 'https://www.youtube.com/watch?v=example5', 1),
('science', 'Plant Photosynthesis', 'Photosynthesis is how plants make food using sunlight, water, and carbon dioxide. Chlorophyll in leaves captures sunlight energy. The process produces glucose (food) and oxygen. Chemical equation: 6CO2 + 6H2O + light energy → C6H12O6 + 6O2.', NULL, 2),
('science', 'States of Matter', 'Matter exists in three main states: solid, liquid, and gas. Solids have fixed shape and volume. Liquids have fixed volume but take the shape of their container. Gases have neither fixed shape nor volume. Temperature changes can make matter change states.', 'https://www.youtube.com/watch?v=example6', 3);

INSERT INTO quizzes (subject, title, duration) VALUES
('math', 'Fractions Basics Quiz', 15),
('math', 'Fraction Operations Test', 20),
('english', 'Grammar Fundamentals', 15),
('english', 'Reading Comprehension Test', 25),
('science', 'Water Cycle Assessment', 10),
('science', 'Life Science Quiz', 20);

INSERT INTO questions (quiz_id, text, option_a, option_b, option_c, option_d, correct_answer) VALUES
(1, 'What does the numerator in a fraction represent?', 'The bottom number', 'The top number', 'The whole number', 'The decimal', 'B'),
(1, 'Which fraction is equivalent to 1/2?', '2/3', '3/6', '1/4', '4/6', 'B'),
(1, 'What is 3/4 as a decimal?', '0.25', '0.5', '0.75', '1.0', 'C'),
(1, 'Which fraction is larger: 2/3 or 3/4?', '2/3', '3/4', 'They are equal', 'Cannot determine', 'B'),
(1, 'Simplify: 6/8', '3/4', '2/3', '1/2', '4/6', 'A'),
(2, 'What is 1/4 + 2/4?', '3/8', '3/4', '1/2', '2/4', 'B'),
(2, 'Calculate: 2/3 × 3/4', '1/2', '6/12', '5/7', '2/4', 'A'),
(2, 'What is 5/6 - 1/3?', '4/3', '1/2', '2/3', '1/6', 'B'),
(2, 'Divide: 1/2 ÷ 1/4', '2', '1/8', '4', '1/2', 'A'),
(2, 'Add: 2/5 + 3/10', '5/15', '7/10', '1/2', '5/10', 'B'),
(3, 'Which word is a noun?', 'Quickly', 'Run', 'Beautiful', 'Book', 'D'),
(3, 'Identify the verb: "She sings beautifully."', 'She', 'Sings', 'Beautifully', 'None', 'B'),
(3, 'What is an adjective?', 'Action word', 'Describing word', 'Person/place/thing', 'Connecting word', 'B'),
(3, 'Which is a proper noun?', 'city', 'school', 'Manila', 'teacher', 'C'),
(3, 'Choose the pronoun: "They went to school."', 'Went', 'To', 'They', 'School', 'C'),
(4, 'What is the main idea of a paragraph?', 'The first sentence', 'The central point', 'The last word', 'The longest sentence', 'B'),
(4, 'A synonym is a word that:', 'Means the opposite', 'Means the same', 'Sounds similar', 'Rhymes', 'B'),
(4, 'What is context in reading?', 'The title only', 'Surrounding information', 'The author name', 'Page number', 'B'),
(4, 'An antonym of "hot" is:', 'Warm', 'Cold', 'Burning', 'Heat', 'B'),
(4, 'What does inference mean?', 'Reading slowly', 'Making conclusions', 'Memorizing', 'Summarizing', 'B'),
(5, 'What causes evaporation?', 'Cold temperature', 'Heat from sun', 'Wind only', 'Rain', 'B'),
(5, 'Where does condensation occur?', 'In oceans', 'In the sky', 'Underground', 'In rivers', 'B'),
(5, 'What is precipitation?', 'Water heating up', 'Rain or snow falling', 'Water flowing', 'Ice melting', 'B'),
(5, 'Which is NOT part of water cycle?', 'Evaporation', 'Condensation', 'Combustion', 'Precipitation', 'C'),
(5, 'What happens during collection?', 'Water evaporates', 'Water returns to earth', 'Clouds form', 'Sun heats water', 'B'),
(6, 'What do plants need for photosynthesis?', 'Only water', 'Sunlight, water, CO2', 'Only oxygen', 'Soil only', 'B'),
(6, 'What does photosynthesis produce?', 'Only water', 'Only CO2', 'Glucose and oxygen', 'Only nitrogen', 'C'),
(6, 'Chlorophyll is found in:', 'Roots', 'Stems', 'Leaves', 'Flowers', 'C'),
(6, 'What color is chlorophyll?', 'Red', 'Blue', 'Green', 'Yellow', 'C'),
(6, 'Which gas do plants release?', 'Carbon dioxide', 'Nitrogen', 'Oxygen', 'Hydrogen', 'C');

INSERT INTO quiz_attempts (student_id, quiz_id, score, completed_at) VALUES
(2, 1, 4, '2024-11-01 10:30:00'),
(2, 3, 5, '2024-11-02 14:15:00'),
(3, 1, 5, '2024-11-01 11:00:00'),
(3, 5, 4, '2024-11-03 09:45:00'),
(4, 2, 7, '2024-11-02 13:20:00'),
(4, 4, 8, '2024-11-04 10:10:00'),
(5, 3, 4, '2024-11-01 15:30:00'),
(5, 6, 9, '2024-11-05 11:25:00');

INSERT INTO progress (student_id, lesson_id, completion) VALUES
(2, 1, 100),
(2, 2, 100),
(2, 4, 100),
(2, 7, 50),
(3, 1, 100),
(3, 7, 100),
(3, 8, 75),
(4, 2, 100),
(4, 3, 100),
(4, 4, 100),
(4, 5, 100),
(5, 4, 100),
(5, 7, 100),
(5, 8, 100),
(5, 9, 100);