<?php
require_once 'includes/Database.php';
require_once 'includes/Auth.php';

// Initialize Database and Auth
$db = new Database();
$auth = new Auth($db);

// Check if user is already logged in
if ($auth->isLoggedIn()) {
    // Redirect based on user role
    switch ($_SESSION['user_role']) {
        case 'admin':
            header('Location: admin/admindashboard.php');
            break;
        case 'student':
            header('Location: Studentportal/studentdashboard.php');
            break;
        case 'teacher':
            header('Location: teacherportal/teacherdashboard.php');
            break;
    }
    exit();
}
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>BCP Student Information System</title>
    <link rel="stylesheet" href="assets/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            text-align: center;
            background-color: #f4f4f9;
            margin: 0;
            padding: 0;
        }
        .container {
            margin-top: 100px;
        }
        .button {
            display: inline-block;
            margin: 20px;
            padding: 15px 30px;
            font-size: 18px;
            color: #fff;
            background-color: #007BFF;
            border: none;
            border-radius: 5px;
            text-decoration: none;
            cursor: pointer;
        }
        .button:hover {
            background-color: #0056b3;
        }
        .welcome-box {
            margin-top: 100px;
        }
        .logo {
            width: 100px;
            height: 100px;
            margin: 20px auto;
        }
        .portal-buttons {
            margin-top: 20px;
        }
        .admin {
            background-color: #dc3545;
        }
        .student {
            background-color: #28a745;
        }
        .teacher {
            background-color: #17a2b8;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="welcome-box">
            <img src="assets/images/bcplogo.png" alt="BCP Logo" class="logo">
            <h1>Welcome to BCP Student Information System</h1>
            <p>Please select your portal to login:</p>
            <div class="portal-buttons">
                <a href="admin/adminlogin.php" class="button admin">
                    <i class="fas fa-user-shield"></i>
                    Admin Portal
                </a>
                <a href="Studentportal/studentlogin.php" class="button student">
                    <i class="fas fa-user-graduate"></i>
                    Student Portal
                </a>
                <a href="teacherportal/teacherlogin.php" class="button teacher">
                    <i class="fas fa-chalkboard-teacher"></i>
                    Teacher Portal
                </a>
            </div>
        </div>
    </div>
    <script src="assets/js/script.js"></script>
</body>
</html>