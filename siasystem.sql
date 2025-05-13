-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 13, 2025 at 07:08 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `siasystem`
--

-- --------------------------------------------------------

--
-- Table structure for table `admin_users`
--

CREATE TABLE `admin_users` (
  `admin_id` varchar(50) NOT NULL,
  `first_name` varchar(50) DEFAULT NULL,
  `last_name` varchar(50) DEFAULT NULL,
  `role_description` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `admin_users`
--

INSERT INTO `admin_users` (`admin_id`, `first_name`, `last_name`, `role_description`, `created_at`, `updated_at`) VALUES
('ADMIN001', 'System', 'Administrator', 'Super Admin', '2025-05-13 03:04:40', '2025-05-13 03:04:40');

-- --------------------------------------------------------

--
-- Table structure for table `attendance`
--

CREATE TABLE `attendance` (
  `id` varchar(50) NOT NULL,
  `student_id` varchar(50) NOT NULL,
  `subject_id` varchar(50) NOT NULL,
  `date` date NOT NULL,
  `status` enum('present','absent','late','excused') NOT NULL,
  `teacher_id` varchar(50) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `attendance`
--

INSERT INTO `attendance` (`id`, `student_id`, `subject_id`, `date`, `status`, `teacher_id`, `created_at`, `updated_at`) VALUES
('6822d3573438b', 'STD004', 'SUBJ004', '2025-05-13', 'absent', 'TCHR001', '2025-05-13 05:06:31', '2025-05-13 05:06:31'),
('6822d3573491b', 'STD002', 'SUBJ004', '2025-05-13', 'absent', 'TCHR001', '2025-05-13 05:06:31', '2025-05-13 05:06:31'),
('6822d357349bc', 'STD005', 'SUBJ004', '2025-05-13', 'present', 'TCHR001', '2025-05-13 05:06:31', '2025-05-13 05:06:31'),
('6822d35737b12', 'STD003', 'SUBJ004', '2025-05-13', 'present', 'TCHR001', '2025-05-13 05:06:31', '2025-05-13 05:06:31'),
('6822d35b6cd19', 'STD004', 'SUBJ002', '2025-05-13', 'present', 'TCHR001', '2025-05-13 05:06:35', '2025-05-13 05:06:35'),
('6822d35b6d449', 'STD002', 'SUBJ002', '2025-05-13', 'present', 'TCHR001', '2025-05-13 05:06:35', '2025-05-13 05:06:35'),
('6822d35b6d4d6', 'STD005', 'SUBJ002', '2025-05-13', 'present', 'TCHR001', '2025-05-13 05:06:35', '2025-05-13 05:06:35'),
('6822d35b6d56c', 'STD003', 'SUBJ002', '2025-05-13', 'present', 'TCHR001', '2025-05-13 05:06:35', '2025-05-13 05:06:35'),
('6822d363dafb0', 'STD004', 'SUBJ001', '2025-05-13', 'absent', 'TCHR001', '2025-05-13 05:06:43', '2025-05-13 05:06:43'),
('6822d363db9da', 'STD002', 'SUBJ001', '2025-05-13', 'present', 'TCHR001', '2025-05-13 05:06:43', '2025-05-13 05:06:43'),
('6822d363dba9e', 'STD005', 'SUBJ001', '2025-05-13', 'present', 'TCHR001', '2025-05-13 05:06:43', '2025-05-13 05:06:43'),
('6822d363dbb37', 'STD003', 'SUBJ001', '2025-05-13', 'present', 'TCHR001', '2025-05-13 05:06:43', '2025-05-13 05:06:43');

-- --------------------------------------------------------

--
-- Table structure for table `concerns`
--

CREATE TABLE `concerns` (
  `concern_id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `status` enum('open','in_progress','resolved','closed') DEFAULT 'open',
  `raised_by` varchar(20) DEFAULT NULL,
  `assigned_to` varchar(20) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `enrolled_subjects`
--

CREATE TABLE `enrolled_subjects` (
  `id` int(11) NOT NULL,
  `student_id` varchar(20) DEFAULT NULL,
  `subject_id` varchar(20) DEFAULT NULL,
  `semester` varchar(20) DEFAULT NULL,
  `school_year` varchar(20) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `enrolled_subjects`
--

INSERT INTO `enrolled_subjects` (`id`, `student_id`, `subject_id`, `semester`, `school_year`, `created_at`) VALUES
(1, '2023001', 'SUBJ001', '1st', '2023-2024', '2025-05-10 23:10:47');

-- --------------------------------------------------------

--
-- Table structure for table `events`
--

CREATE TABLE `events` (
  `id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `date` date NOT NULL,
  `start_time` time DEFAULT NULL,
  `end_time` time DEFAULT NULL,
  `location` varchar(255) DEFAULT NULL,
  `event_type` enum('academic','exam','holiday','other') DEFAULT 'other',
  `student_id` varchar(20) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `events`
--

INSERT INTO `events` (`id`, `title`, `description`, `date`, `start_time`, `end_time`, `location`, `event_type`, `student_id`, `created_at`) VALUES
(1, 'Midterm Exam', 'CS101 Midterm Examination', '2025-05-18', '09:00:00', '12:00:00', NULL, 'exam', '2023001', '2025-05-10 23:11:58'),
(2, 'Project Deadline', 'Submit final project for CS101', '2025-05-25', '23:59:59', '23:59:59', NULL, 'academic', '2023001', '2025-05-10 23:11:58'),
(3, 'Semester Break', 'End of first semester', '2025-06-10', NULL, NULL, NULL, 'holiday', NULL, '2025-05-10 23:11:58'),
(4, 'Midterm Exam', 'CS101 Midterm Examination', '2025-05-20', '09:00:00', '12:00:00', NULL, 'exam', '2023001', '2025-05-13 02:01:30'),
(5, 'Project Deadline', 'Submit final project for CS101', '2025-05-27', '23:59:59', '23:59:59', NULL, 'academic', '2023001', '2025-05-13 02:01:30'),
(6, 'Semester Break', 'End of first semester', '2025-06-12', NULL, NULL, NULL, 'holiday', NULL, '2025-05-13 02:01:30');

-- --------------------------------------------------------

--
-- Table structure for table `grades`
--

CREATE TABLE `grades` (
  `id` int(11) NOT NULL,
  `student_id` varchar(20) DEFAULT NULL,
  `subject_id` varchar(20) DEFAULT NULL,
  `grade` decimal(5,2) DEFAULT NULL,
  `semester` varchar(20) DEFAULT NULL,
  `school_year` varchar(20) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `grades`
--

INSERT INTO `grades` (`id`, `student_id`, `subject_id`, `grade`, `semester`, `school_year`, `created_at`) VALUES
(1, '2023001', 'SUBJ001', 85.50, '1st', '2023-2024', '2025-05-10 23:10:47');

-- --------------------------------------------------------

--
-- Table structure for table `notifications`
--

CREATE TABLE `notifications` (
  `id` int(11) NOT NULL,
  `student_id` varchar(50) DEFAULT NULL,
  `title` varchar(255) NOT NULL,
  `message` text NOT NULL,
  `type` enum('info','success','warning','error') DEFAULT 'info',
  `is_read` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `students`
--

CREATE TABLE `students` (
  `student_id` varchar(50) NOT NULL,
  `first_name` varchar(50) DEFAULT NULL,
  `last_name` varchar(50) DEFAULT NULL,
  `course` varchar(50) DEFAULT NULL,
  `year_level` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `students`
--

INSERT INTO `students` (`student_id`, `first_name`, `last_name`, `course`, `year_level`, `created_at`, `updated_at`) VALUES
('STD001', 'Jane', 'Doe', 'BSIT', 1, '2025-05-13 03:04:40', '2025-05-13 03:04:40'),
('STD002', 'Alice', 'Johnson', 'BSIT', 1, '2025-05-13 03:04:40', '2025-05-13 03:04:40'),
('STD003', 'Bob', 'Williams', 'BSIT', 1, '2025-05-13 03:04:40', '2025-05-13 03:04:40'),
('STD004', 'Carol', 'Brown', 'BSIT', 1, '2025-05-13 03:04:40', '2025-05-13 03:04:40'),
('STD005', 'David', 'Miller', 'BSIT', 1, '2025-05-13 03:04:40', '2025-05-13 03:04:40');

-- --------------------------------------------------------

--
-- Table structure for table `student_subjects`
--

CREATE TABLE `student_subjects` (
  `student_id` varchar(50) NOT NULL,
  `subject_id` varchar(50) NOT NULL,
  `academic_year` varchar(20) DEFAULT NULL,
  `semester` varchar(20) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `student_subjects`
--

INSERT INTO `student_subjects` (`student_id`, `subject_id`, `academic_year`, `semester`, `created_at`) VALUES
('STD002', 'SUBJ001', '2024-2025', '1st', '2025-05-13 03:04:40'),
('STD002', 'SUBJ002', '2024-2025', '1st', '2025-05-13 03:04:40'),
('STD002', 'SUBJ003', '2024-2025', '1st', '2025-05-13 03:04:40'),
('STD002', 'SUBJ004', '2024-2025', '1st', '2025-05-13 03:04:40'),
('STD002', 'SUBJ005', '2024-2025', '1st', '2025-05-13 03:04:40'),
('STD003', 'SUBJ001', '2024-2025', '1st', '2025-05-13 03:04:40'),
('STD003', 'SUBJ002', '2024-2025', '1st', '2025-05-13 03:04:40'),
('STD003', 'SUBJ003', '2024-2025', '1st', '2025-05-13 03:04:40'),
('STD003', 'SUBJ004', '2024-2025', '1st', '2025-05-13 03:04:40'),
('STD003', 'SUBJ005', '2024-2025', '1st', '2025-05-13 03:04:40'),
('STD004', 'SUBJ001', '2024-2025', '1st', '2025-05-13 03:04:40'),
('STD004', 'SUBJ002', '2024-2025', '1st', '2025-05-13 03:04:40'),
('STD004', 'SUBJ003', '2024-2025', '1st', '2025-05-13 03:04:40'),
('STD004', 'SUBJ004', '2024-2025', '1st', '2025-05-13 03:04:40'),
('STD004', 'SUBJ005', '2024-2025', '1st', '2025-05-13 03:04:40'),
('STD005', 'SUBJ001', '2024-2025', '1st', '2025-05-13 03:04:40'),
('STD005', 'SUBJ002', '2024-2025', '1st', '2025-05-13 03:04:40'),
('STD005', 'SUBJ003', '2024-2025', '1st', '2025-05-13 03:04:40'),
('STD005', 'SUBJ004', '2024-2025', '1st', '2025-05-13 03:04:40'),
('STD005', 'SUBJ005', '2024-2025', '1st', '2025-05-13 03:04:40');

-- --------------------------------------------------------

--
-- Table structure for table `subjects`
--

CREATE TABLE `subjects` (
  `subject_id` varchar(50) NOT NULL,
  `subject_name` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `credits` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `subjects`
--

INSERT INTO `subjects` (`subject_id`, `subject_name`, `description`, `credits`, `created_at`, `updated_at`) VALUES
('SUBJ001', 'Introduction to Programming', 'Basic concepts of programming using Python', 3, '2025-05-13 03:04:40', '2025-05-13 03:04:40'),
('SUBJ002', 'Web Development', 'HTML, CSS, and JavaScript fundamentals', 3, '2025-05-13 03:04:40', '2025-05-13 03:04:40'),
('SUBJ003', 'Database Management', 'SQL and database design principles', 3, '2025-05-13 03:04:40', '2025-05-13 03:04:40'),
('SUBJ004', 'Data Structures', 'Advanced programming concepts and algorithms', 4, '2025-05-13 03:04:40', '2025-05-13 03:04:40'),
('SUBJ005', 'Software Engineering', 'Software development lifecycle and methodologies', 4, '2025-05-13 03:04:40', '2025-05-13 03:04:40');

-- --------------------------------------------------------

--
-- Table structure for table `tasks`
--

CREATE TABLE `tasks` (
  `task_id` varchar(50) NOT NULL,
  `teacher_id` varchar(50) DEFAULT NULL,
  `subject_id` varchar(50) DEFAULT NULL,
  `title` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `due_date` datetime DEFAULT NULL,
  `status` enum('draft','active','completed','archived') DEFAULT 'draft',
  `points` int(11) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tasks`
--

INSERT INTO `tasks` (`task_id`, `teacher_id`, `subject_id`, `title`, `description`, `due_date`, `status`, `points`, `created_at`, `updated_at`) VALUES
('6822c97a62344', 'TCHR001', 'SUBJ001', 'eeqwewqe', 'weqweqwewq', '2025-05-13 12:24:00', 'draft', 0, '2025-05-13 04:24:26', '2025-05-13 04:24:26'),
('TASK001', 'TCHR001', 'SUBJ001', 'Python Basics Quiz', 'Complete the quiz on Python fundamentals', '2025-05-20 23:59:59', 'active', 100, '2025-05-13 03:04:40', '2025-05-13 03:04:40'),
('TASK003', 'TCHR001', 'SUBJ002', 'Portfolio Website', 'Build your personal portfolio using HTML/CSS', '2025-05-22 23:59:59', 'active', 200, '2025-05-13 03:04:40', '2025-05-13 03:04:40'),
('TASK004', 'TCHR001', 'SUBJ003', 'Database Design', 'Design a database for a library system', '2025-05-28 23:59:59', 'draft', 150, '2025-05-13 03:04:40', '2025-05-13 03:04:40'),
('TASK005', 'TCHR001', 'SUBJ004', 'Sorting Algorithm', 'Implement and analyze different sorting algorithms', '2025-05-30 23:59:59', 'active', 180, '2025-05-13 03:04:40', '2025-05-13 03:04:40');

-- --------------------------------------------------------

--
-- Table structure for table `task_logs`
--

CREATE TABLE `task_logs` (
  `id` int(11) NOT NULL,
  `task_id` int(11) DEFAULT NULL,
  `student_id` varchar(50) DEFAULT NULL,
  `action` enum('created','updated','completed','deleted') NOT NULL,
  `details` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `task_submissions`
--

CREATE TABLE `task_submissions` (
  `submission_id` varchar(50) NOT NULL,
  `task_id` varchar(50) DEFAULT NULL,
  `student_id` varchar(50) DEFAULT NULL,
  `submission_text` text DEFAULT NULL,
  `file_path` varchar(255) DEFAULT NULL,
  `submitted_at` datetime DEFAULT NULL,
  `status` enum('pending','graded','late','resubmitted') DEFAULT 'pending',
  `grade` decimal(5,2) DEFAULT NULL,
  `feedback` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `task_submissions`
--

INSERT INTO `task_submissions` (`submission_id`, `task_id`, `student_id`, `submission_text`, `file_path`, `submitted_at`, `status`, `grade`, `feedback`, `created_at`, `updated_at`) VALUES
('SUB001', 'TASK001', 'STD002', 'Completed Python quiz', NULL, '2025-05-19 14:30:00', 'pending', NULL, NULL, '2025-05-13 03:04:41', '2025-05-13 03:04:41'),
('SUB002', 'TASK001', 'STD003', 'Completed Python quiz', NULL, '2025-05-19 15:45:00', 'pending', NULL, NULL, '2025-05-13 03:04:41', '2025-05-13 03:04:41'),
('SUB004', 'TASK003', 'STD004', 'Portfolio website submission', '/submissions/portfolio_std004.zip', '2025-05-21 16:20:00', 'pending', NULL, NULL, '2025-05-13 03:04:41', '2025-05-13 03:04:41');

-- --------------------------------------------------------

--
-- Table structure for table `teachers`
--

CREATE TABLE `teachers` (
  `teacher_id` varchar(50) NOT NULL,
  `first_name` varchar(50) DEFAULT NULL,
  `last_name` varchar(50) DEFAULT NULL,
  `department` varchar(100) DEFAULT NULL,
  `specialization` varchar(100) DEFAULT NULL,
  `qualification` varchar(100) DEFAULT NULL,
  `office_hours` varchar(255) DEFAULT NULL,
  `contact_number` varchar(20) DEFAULT NULL,
  `emergency_contact` varchar(20) DEFAULT NULL,
  `bio` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `teachers`
--

INSERT INTO `teachers` (`teacher_id`, `first_name`, `last_name`, `department`, `specialization`, `qualification`, `office_hours`, `contact_number`, `emergency_contact`, `bio`, `created_at`, `updated_at`) VALUES
('TCHR001', 'John', 'Smith', 'Computer Science', 'Software Engineering', 'MSc', 'Monday to Friday, 8am-5pm', '1234567890', '1234567890', 'Teacher Bio', '2025-05-13 03:04:40', '2025-05-13 03:04:40');

-- --------------------------------------------------------

--
-- Table structure for table `teacher_subjects`
--

CREATE TABLE `teacher_subjects` (
  `teacher_id` varchar(50) NOT NULL,
  `subject_id` varchar(50) NOT NULL,
  `academic_year` varchar(20) DEFAULT NULL,
  `semester` varchar(20) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `teacher_subjects`
--

INSERT INTO `teacher_subjects` (`teacher_id`, `subject_id`, `academic_year`, `semester`, `created_at`) VALUES
('TCHR001', 'SUBJ001', '2024-2025', '1st', '2025-05-13 03:04:40'),
('TCHR001', 'SUBJ002', '2024-2025', '1st', '2025-05-13 03:04:40'),
('TCHR001', 'SUBJ003', '2024-2025', '1st', '2025-05-13 03:04:40'),
('TCHR001', 'SUBJ004', '2024-2025', '1st', '2025-05-13 03:04:40'),
('TCHR001', 'SUBJ005', '2024-2025', '1st', '2025-05-13 03:04:40');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` varchar(50) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('admin','teacher','student') NOT NULL,
  `status` enum('active','inactive','suspended') DEFAULT 'active',
  `email` varchar(100) DEFAULT NULL,
  `profile_image` varchar(255) DEFAULT NULL,
  `last_login` datetime DEFAULT NULL,
  `login_attempts` int(11) DEFAULT 0,
  `reset_token` varchar(255) DEFAULT NULL,
  `reset_token_expires` datetime DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `username`, `password`, `role`, `status`, `email`, `profile_image`, `last_login`, `login_attempts`, `reset_token`, `reset_token_expires`, `created_at`, `updated_at`) VALUES
('ADMIN001', 'admin', '$2y$10$r61nxqXmdu840Q0Y0TdAOOyu7gKtcU/JQ4rm1zt0AIRLlmwaz/m3S', 'admin', 'active', 'admin@siasystem.edu', '../assets/images/default-avatar.png', NULL, 0, NULL, NULL, '2025-05-13 03:04:40', '2025-05-13 03:04:40'),
('STD001', 'student', '$2y$10$fnoC1gvJPvJ/KNSKdyk2ROnnlzEuxgBtNWE0dRXhQSsLayblV7j.O', 'student', 'active', 'student@siasystem.edu', '../assets/images/default-avatar.png', NULL, 0, NULL, NULL, '2025-05-13 03:04:40', '2025-05-13 03:04:40'),
('STD002', 'student2', '$2y$10$eeUuGSCJrE6NOFcH.jTDwOtwf2jXJBNY1XDCOUo.mNLQ2hz/ohWh6', 'student', 'active', NULL, NULL, NULL, 0, NULL, NULL, '2025-05-13 03:04:40', '2025-05-13 03:04:40'),
('STD003', 'student3', '$2y$10$nzAMnazEaLtBESrMH.hilejDySOtJa9S9a1X2ao4UnOfdYX4BNAEe', 'student', 'active', NULL, NULL, NULL, 0, NULL, NULL, '2025-05-13 03:04:40', '2025-05-13 03:04:40'),
('STD004', 'student4', '$2y$10$Zr/xn/nj9YCHbojIyPS0ne6dbw14ouwc7LvJ8KWWq9oslyjFdiV8W', 'student', 'active', NULL, NULL, NULL, 0, NULL, NULL, '2025-05-13 03:04:40', '2025-05-13 03:04:40'),
('STD005', 'student5', '$2y$10$.9c30gZtOIHSiZ9roK3Bsu8bSbIevXCkC5DB8cpB/wMh/LWraXGbe', 'student', 'active', NULL, NULL, NULL, 0, NULL, NULL, '2025-05-13 03:04:40', '2025-05-13 03:04:40'),
('TCHR001', 'teacher', '$2y$10$iIx9QttT5oNSFzjpGHbNM.yXmPSm2HxkLNZJyU9bnYpKUVtZw.SZm', 'teacher', 'active', 'teacher@siasystem.edu', '../assets/images/default-avatar.png', '2025-05-13 11:07:17', 0, NULL, NULL, '2025-05-13 03:04:40', '2025-05-13 03:07:17');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin_users`
--
ALTER TABLE `admin_users`
  ADD PRIMARY KEY (`admin_id`);

--
-- Indexes for table `attendance`
--
ALTER TABLE `attendance`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_attendance` (`student_id`,`subject_id`,`date`),
  ADD KEY `subject_id` (`subject_id`),
  ADD KEY `teacher_id` (`teacher_id`);

--
-- Indexes for table `concerns`
--
ALTER TABLE `concerns`
  ADD PRIMARY KEY (`concern_id`),
  ADD KEY `raised_by` (`raised_by`),
  ADD KEY `assigned_to` (`assigned_to`);

--
-- Indexes for table `enrolled_subjects`
--
ALTER TABLE `enrolled_subjects`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_enrollment` (`student_id`,`subject_id`,`semester`,`school_year`),
  ADD KEY `subject_id` (`subject_id`);

--
-- Indexes for table `events`
--
ALTER TABLE `events`
  ADD PRIMARY KEY (`id`),
  ADD KEY `student_id` (`student_id`);

--
-- Indexes for table `grades`
--
ALTER TABLE `grades`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_grade` (`student_id`,`subject_id`,`semester`,`school_year`),
  ADD KEY `subject_id` (`subject_id`);

--
-- Indexes for table `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `student_id` (`student_id`);

--
-- Indexes for table `students`
--
ALTER TABLE `students`
  ADD PRIMARY KEY (`student_id`);

--
-- Indexes for table `student_subjects`
--
ALTER TABLE `student_subjects`
  ADD PRIMARY KEY (`student_id`,`subject_id`),
  ADD KEY `subject_id` (`subject_id`);

--
-- Indexes for table `subjects`
--
ALTER TABLE `subjects`
  ADD PRIMARY KEY (`subject_id`);

--
-- Indexes for table `tasks`
--
ALTER TABLE `tasks`
  ADD PRIMARY KEY (`task_id`),
  ADD KEY `teacher_id` (`teacher_id`),
  ADD KEY `subject_id` (`subject_id`);

--
-- Indexes for table `task_logs`
--
ALTER TABLE `task_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `student_id` (`student_id`);

--
-- Indexes for table `task_submissions`
--
ALTER TABLE `task_submissions`
  ADD PRIMARY KEY (`submission_id`),
  ADD KEY `task_id` (`task_id`),
  ADD KEY `student_id` (`student_id`);

--
-- Indexes for table `teachers`
--
ALTER TABLE `teachers`
  ADD PRIMARY KEY (`teacher_id`);

--
-- Indexes for table `teacher_subjects`
--
ALTER TABLE `teacher_subjects`
  ADD PRIMARY KEY (`teacher_id`,`subject_id`),
  ADD KEY `subject_id` (`subject_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `concerns`
--
ALTER TABLE `concerns`
  MODIFY `concern_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `enrolled_subjects`
--
ALTER TABLE `enrolled_subjects`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `events`
--
ALTER TABLE `events`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `grades`
--
ALTER TABLE `grades`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `notifications`
--
ALTER TABLE `notifications`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `task_logs`
--
ALTER TABLE `task_logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `admin_users`
--
ALTER TABLE `admin_users`
  ADD CONSTRAINT `admin_users_ibfk_1` FOREIGN KEY (`admin_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;

--
-- Constraints for table `attendance`
--
ALTER TABLE `attendance`
  ADD CONSTRAINT `attendance_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `students` (`student_id`),
  ADD CONSTRAINT `attendance_ibfk_2` FOREIGN KEY (`subject_id`) REFERENCES `subjects` (`subject_id`),
  ADD CONSTRAINT `attendance_ibfk_3` FOREIGN KEY (`teacher_id`) REFERENCES `teachers` (`teacher_id`);

--
-- Constraints for table `concerns`
--
ALTER TABLE `concerns`
  ADD CONSTRAINT `concerns_ibfk_1` FOREIGN KEY (`raised_by`) REFERENCES `users` (`user_id`),
  ADD CONSTRAINT `concerns_ibfk_2` FOREIGN KEY (`assigned_to`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `enrolled_subjects`
--
ALTER TABLE `enrolled_subjects`
  ADD CONSTRAINT `enrolled_subjects_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `students` (`student_id`),
  ADD CONSTRAINT `enrolled_subjects_ibfk_2` FOREIGN KEY (`subject_id`) REFERENCES `subjects` (`subject_id`);

--
-- Constraints for table `events`
--
ALTER TABLE `events`
  ADD CONSTRAINT `events_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `students` (`student_id`);

--
-- Constraints for table `grades`
--
ALTER TABLE `grades`
  ADD CONSTRAINT `grades_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `students` (`student_id`),
  ADD CONSTRAINT `grades_ibfk_2` FOREIGN KEY (`subject_id`) REFERENCES `subjects` (`subject_id`);

--
-- Constraints for table `notifications`
--
ALTER TABLE `notifications`
  ADD CONSTRAINT `notifications_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `students` (`student_id`) ON DELETE CASCADE;

--
-- Constraints for table `students`
--
ALTER TABLE `students`
  ADD CONSTRAINT `students_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;

--
-- Constraints for table `student_subjects`
--
ALTER TABLE `student_subjects`
  ADD CONSTRAINT `student_subjects_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `students` (`student_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `student_subjects_ibfk_2` FOREIGN KEY (`subject_id`) REFERENCES `subjects` (`subject_id`) ON DELETE CASCADE;

--
-- Constraints for table `tasks`
--
ALTER TABLE `tasks`
  ADD CONSTRAINT `tasks_ibfk_1` FOREIGN KEY (`teacher_id`) REFERENCES `teachers` (`teacher_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_2` FOREIGN KEY (`subject_id`) REFERENCES `subjects` (`subject_id`) ON DELETE CASCADE;

--
-- Constraints for table `task_logs`
--
ALTER TABLE `task_logs`
  ADD CONSTRAINT `task_logs_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `students` (`student_id`) ON DELETE CASCADE;

--
-- Constraints for table `task_submissions`
--
ALTER TABLE `task_submissions`
  ADD CONSTRAINT `task_submissions_ibfk_1` FOREIGN KEY (`task_id`) REFERENCES `tasks` (`task_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `task_submissions_ibfk_2` FOREIGN KEY (`student_id`) REFERENCES `students` (`student_id`) ON DELETE CASCADE;

--
-- Constraints for table `teachers`
--
ALTER TABLE `teachers`
  ADD CONSTRAINT `teachers_ibfk_1` FOREIGN KEY (`teacher_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;

--
-- Constraints for table `teacher_subjects`
--
ALTER TABLE `teacher_subjects`
  ADD CONSTRAINT `teacher_subjects_ibfk_1` FOREIGN KEY (`teacher_id`) REFERENCES `teachers` (`teacher_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `teacher_subjects_ibfk_2` FOREIGN KEY (`subject_id`) REFERENCES `subjects` (`subject_id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
