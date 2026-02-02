-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Converted for PostgreSQL
-- Original Host: 127.0.0.1
-- Original Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

START TRANSACTION;
SET TimeZone = 'UTC';

--
-- Database: "examify_db"
--

-- --------------------------------------------------------

--
-- Table structure for table "failed_jobs"
--

CREATE TABLE "failed_jobs" (
  "id" bigserial NOT NULL PRIMARY KEY,
  "uuid" varchar(255) NOT NULL UNIQUE,
  "connection" text NOT NULL,
  "queue" text NOT NULL,
  "payload" text NOT NULL,
  "exception" text NOT NULL,
  "failed_at" timestamp NOT NULL DEFAULT current_timestamp
);

-- --------------------------------------------------------

--
-- Table structure for table "migrations"
--

CREATE TABLE "migrations" (
  "id" serial NOT NULL PRIMARY KEY,
  "migration" varchar(255) NOT NULL,
  "batch" integer NOT NULL
);

--
-- Dumping data for table "migrations"
--

INSERT INTO "migrations" ("id", "migration", "batch") VALUES
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2014_10_12_100000_create_password_resets_table', 1),
(3, '2019_08_19_000000_create_failed_jobs_table', 1),
(4, '2019_12_14_000001_create_personal_access_tokens_table', 1);

-- --------------------------------------------------------

--
-- Table structure for table "options"
--

CREATE TABLE "options" (
  "id" serial NOT NULL PRIMARY KEY,
  "question_id" integer DEFAULT NULL,
  "option_text" text DEFAULT NULL,
  "is_correct" boolean DEFAULT false
);

--
-- Dumping data for table "options"
--

INSERT INTO "options" ("id", "question_id", "option_text", "is_correct") VALUES
(1, 1, 'A. Tokyo', true),
(2, 1, 'B. Wazap', false),
(3, 1, 'C. Bangtits', false),
(4, 1, 'D. Bangkok', false);

-- --------------------------------------------------------

--
-- Table structure for table "password_resets"
--

CREATE TABLE "password_resets" (
  "email" varchar(255) NOT NULL,
  "token" varchar(255) NOT NULL,
  "created_at" timestamp NULL DEFAULT NULL
);

-- --------------------------------------------------------

--
-- Table structure for table "personal_access_tokens"
--

CREATE TABLE "personal_access_tokens" (
  "id" bigserial NOT NULL PRIMARY KEY,
  "tokenable_type" varchar(255) NOT NULL,
  "tokenable_id" bigint NOT NULL,
  "name" varchar(255) NOT NULL,
  "token" varchar(64) NOT NULL UNIQUE,
  "abilities" text DEFAULT NULL,
  "last_used_at" timestamp NULL DEFAULT NULL,
  "created_at" timestamp NULL DEFAULT NULL,
  "updated_at" timestamp NULL DEFAULT NULL
);

-- --------------------------------------------------------

--
-- Table structure for table "questions"
--

CREATE TABLE "questions" (
  "id" serial NOT NULL PRIMARY KEY,
  "quiz_id" integer DEFAULT NULL,
  "question_text" text DEFAULT NULL,
  "question_type" varchar(50) DEFAULT NULL CHECK ("question_type" IN ('multiple_choice','true_false','short_answer')),
  "marks" integer DEFAULT NULL,
  "correct_answer" text DEFAULT NULL
);

--
-- Dumping data for table "questions"
--

INSERT INTO "questions" ("id", "quiz_id", "question_text", "question_type", "marks", "correct_answer") VALUES
(1, 6, 'What is the Capital City of Japan', 'multiple_choice', 10, '0');

-- --------------------------------------------------------

--
-- Table structure for table "quizzes"
--

CREATE TABLE "quizzes" (
  "id" serial NOT NULL PRIMARY KEY,
  "title" varchar(200) DEFAULT NULL,
  "topic_id" integer DEFAULT NULL,
  "teacher_id" integer DEFAULT NULL,
  "duration" integer DEFAULT NULL,
  "total_marks" integer DEFAULT NULL,
  "instructions" text DEFAULT NULL,
  "created_at" timestamp NOT NULL DEFAULT current_timestamp
);

--
-- Dumping data for table "quizzes"
--

INSERT INTO "quizzes" ("id", "title", "topic_id", "teacher_id", "duration", "total_marks", "instructions", "created_at") VALUES
(6, 'Capital Cities', 2, 2, 30, 50, NULL, '2025-10-18 16:15:26');

-- --------------------------------------------------------

--
-- Table structure for table "student_answers"
--

CREATE TABLE "student_answers" (
  "id" serial NOT NULL PRIMARY KEY,
  "attempt_id" integer DEFAULT NULL,
  "question_id" integer DEFAULT NULL,
  "answer_text" text DEFAULT NULL,
  "is_correct" boolean DEFAULT NULL,
  "marks_obtained" integer DEFAULT NULL
);

-- --------------------------------------------------------

--
-- Table structure for table "student_attempts"
--

CREATE TABLE "student_attempts" (
  "id" serial NOT NULL PRIMARY KEY,
  "student_id" integer DEFAULT NULL,
  "quiz_id" integer DEFAULT NULL,
  "score" numeric(5,2) DEFAULT NULL,
  "total_marks" integer DEFAULT NULL,
  "percentage" numeric(5,2) DEFAULT NULL,
  "time_taken" integer DEFAULT NULL,
  "completed_at" timestamp NOT NULL DEFAULT current_timestamp
);

--
-- Dumping data for table "student_attempts"
--

INSERT INTO "student_attempts" ("id", "student_id", "quiz_id", "score", "total_marks", "percentage", "time_taken", "completed_at") VALUES
(1, 3, 6, 10.00, 50, 20.00, NULL, '2025-10-18 16:18:52');

-- --------------------------------------------------------

--
-- Table structure for table "topics"
--

CREATE TABLE "topics" (
  "id" serial NOT NULL PRIMARY KEY,
  "name" varchar(100) DEFAULT NULL,
  "description" text DEFAULT NULL,
  "teacher_id" integer DEFAULT NULL,
  "created_at" timestamp NOT NULL DEFAULT current_timestamp
);

--
-- Dumping data for table "topics"
--

INSERT INTO "topics" ("id", "name", "description", "teacher_id", "created_at") VALUES
(1, 'Calculus 1', 'this will be a quiz about introduction to Calculus 1', 2, '2025-10-18 14:26:35'),
(2, 'History', 'Introduction to History', 2, '2025-10-18 16:14:52');

-- --------------------------------------------------------

--
-- Table structure for table "users"
--

CREATE TABLE "users" (
  "id" serial NOT NULL PRIMARY KEY,
  "name" varchar(100) DEFAULT NULL,
  "email" varchar(100) NOT NULL UNIQUE,
  "password" varchar(255) DEFAULT NULL,
  "role" varchar(50) DEFAULT NULL CHECK ("role" IN ('admin','teacher','student')),
  "created_at" timestamp NOT NULL DEFAULT current_timestamp
);

--
-- Dumping data for table "users"
--

INSERT INTO "users" ("id", "name", "email", "password", "role", "created_at") VALUES
(1, 'Zander', 'Zander@gmail.com', 'scrypt:32768:8:1$MA2mzNJ3euNtL5ap$c51154a13f9273fc32da6fb50daa18d2e16d3086222ff49882411ba2178945b239d07fbbbe721c08de1397ee6ad31fc87c8190bf36281cd383897eb242495292', 'student', '2025-10-18 14:07:54'),
(2, 'John Xavier', 'JohnXavier@gmail.com', 'scrypt:32768:8:1$bjl1nzl2Ebp5JfhC$74f1a30cf33b9d97391f6b9d09eb907299fcc9a4c0335f0f5e35927e89d79b829ec6819165423da00761cd0b097bf3e08e2271f88a7681d52639fe57632ce240', 'teacher', '2025-10-18 14:22:35'),
(3, 'Jason Derulo', 'Jasonderulo@gmail.com', 'scrypt:32768:8:1$MT6YDUAJSe4M385g$f3613715ecd0bac203f1e2271ab14d8ea18e8b4ec1f3ab16296ad69c8e4f0b4223eeae44786eb2ed8eb4e8d3b515c745914d82a5875c6a882da521703aeb99aa', 'student', '2025-10-18 16:16:08'),
(4, 'raven', 'raven@gmail.com', 'scrypt:32768:8:1$jG6U7piPgmPYYy73$6edc2522111fa3401280d967e976c851f36f83af95e02988ec252c1d03c7c0925bee57aa48c528deafb7b8dab9d1992e90a23fb13b5fb28be7df5da6e1ad87ab', 'student', '2025-10-26 12:03:23');


-- Add Foreign Keys

ALTER TABLE "options"
  ADD CONSTRAINT "options_ibfk_1" FOREIGN KEY ("question_id") REFERENCES "questions" ("id");

ALTER TABLE "questions"
  ADD CONSTRAINT "questions_ibfk_1" FOREIGN KEY ("quiz_id") REFERENCES "quizzes" ("id");

ALTER TABLE "quizzes"
  ADD CONSTRAINT "quizzes_ibfk_1" FOREIGN KEY ("topic_id") REFERENCES "topics" ("id"),
  ADD CONSTRAINT "quizzes_ibfk_2" FOREIGN KEY ("teacher_id") REFERENCES "users" ("id");

ALTER TABLE "student_answers"
  ADD CONSTRAINT "student_answers_ibfk_1" FOREIGN KEY ("attempt_id") REFERENCES "student_attempts" ("id"),
  ADD CONSTRAINT "student_answers_ibfk_2" FOREIGN KEY ("question_id") REFERENCES "questions" ("id");

ALTER TABLE "student_attempts"
  ADD CONSTRAINT "student_attempts_ibfk_1" FOREIGN KEY ("student_id") REFERENCES "users" ("id"),
  ADD CONSTRAINT "student_attempts_ibfk_2" FOREIGN KEY ("quiz_id") REFERENCES "quizzes" ("id");

ALTER TABLE "topics"
  ADD CONSTRAINT "topics_ibfk_1" FOREIGN KEY ("teacher_id") REFERENCES "users" ("id");

COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
