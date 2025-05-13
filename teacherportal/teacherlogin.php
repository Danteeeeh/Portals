<?php
session_start();
error_reporting(E_ALL);
ini_set('display_errors', 1);

require_once '../includes/Database.php';
require_once '../includes/Auth.php';

$db = new Database();
$auth = new Auth($db);

// Clear any existing session if not logged in as teacher
if (!isset($_SESSION['user_role']) || $_SESSION['user_role'] !== 'teacher') {
    session_destroy();
    session_start();
}

// If already logged in as teacher, redirect to dashboard
if (isset($_SESSION['user_role']) && $_SESSION['user_role'] === 'teacher') {
    header('Location: teacherdashboard.php');
    exit();
}

// Handle login form submission
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $username = $_POST['username'] ?? '';
    $password = $_POST['password'] ?? '';

    if (empty($username) || empty($password)) {
        $error_message = 'Please enter both username and password.';
    } else {
        if ($auth->login($username, $password)) {
            // Verify user is a teacher
            if ($_SESSION['user_role'] === 'teacher') {
                header('Location: teacherdashboard.php');
                exit();
            } else {
                $error_message = 'Invalid teacher credentials';
                session_destroy();
            }
        } else {
            $error_message = 'Invalid username or password.';
        }
    }
}
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="../assets/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <title>Teacher Login - SIA System</title>
    <meta name="description" content="Teacher login portal for Student Information and Attendance System">
    <style>
        :root {
            --primary-color: #4361ee;
            --primary-dark: #3f37c9;
            --text-light: #718096;
            --text-dark: #2d3748;
            --bg-light: #f7fafc;
            --white: #ffffff;
            --error-color: #e53e3e;
            --success-color: #38a169;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', sans-serif;
            background: var(--bg-light);
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }

        .particles-container {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            z-index: -1;
            background: linear-gradient(135deg, var(--primary-color) 0%, var(--primary-dark) 100%);
        }

        .login-page {
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 2rem;
        }

        .login-card {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border-radius: 24px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 1000px;
            display: flex;
            overflow: hidden;
        }

        .login-left {
            flex: 1;
            padding: 3rem;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }

        .login-right {
            flex: 1;
            background: linear-gradient(135deg, var(--primary-color) 0%, var(--primary-dark) 100%);
            padding: 3rem;
            color: white;
            display: flex;
            flex-direction: column;
            justify-content: center;
            position: relative;
            overflow: hidden;
        }

        .login-right::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: url('../assets/images/pattern.svg') center/cover;
            opacity: 0.1;
        }

        .school-logo {
            width: 80px;
            height: auto;
            margin-bottom: 2rem;
        }

        .welcome-text {
            margin-bottom: 2rem;
        }

        .welcome-text h1 {
            font-size: 2rem;
            font-weight: 700;
            margin-bottom: 0.5rem;
            background: linear-gradient(135deg, var(--primary-color) 0%, var(--primary-dark) 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        .welcome-text p {
            color: var(--text-light);
            font-size: 1rem;
        }

        .login-form {
            display: flex;
            flex-direction: column;
            gap: 1.5rem;
        }

        .form-group {
            position: relative;
        }

        .form-group input {
            width: 100%;
            padding: 1rem 1rem 1rem 3rem;
            border: 2px solid #e2e8f0;
            border-radius: 12px;
            font-size: 1rem;
            transition: all 0.3s ease;
        }

        .form-group input:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 3px rgba(67, 97, 238, 0.1);
        }

        .form-group i {
            position: absolute;
            left: 1rem;
            top: 50%;
            transform: translateY(-50%);
            color: #a0aec0;
            transition: all 0.3s ease;
        }

        .form-group input:focus + i {
            color: var(--primary-color);
        }

        .login-button {
            background: linear-gradient(135deg, var(--primary-color) 0%, var(--primary-dark) 100%);
            color: white;
            border: none;
            padding: 1rem;
            border-radius: 12px;
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
            width: 100%;
        }

        .login-button:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(67, 97, 238, 0.2);
        }

        .error-message {
            color: var(--error-color);
            margin-bottom: 1rem;
            font-size: 0.9rem;
            padding: 0.75rem;
            border-radius: 8px;
            background-color: rgba(229, 62, 62, 0.1);
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .login-button:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(67, 97, 238, 0.2);
        }

        .login-footer {
            margin-top: 2rem;
            text-align: center;
            color: var(--text-light);
        }

        .login-footer a {
            color: var(--primary-color);
            text-decoration: none;
            font-weight: 500;
        }

        .features-list {
            margin-top: 2rem;
            display: flex;
            flex-direction: column;
            gap: 1.5rem;
            max-width: 400px;
            margin-left: auto;
            margin-right: auto;
        }

        .feature-item {
            display: flex;
            align-items: center;
            gap: 1rem;
            padding: 1.5rem;
            border-radius: 12px;
            background: rgba(255, 255, 255, 0.1);
            transition: all 0.3s ease;
            color: white;
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.1);
        }

        .feature-item:hover {
            background: rgba(255, 255, 255, 0.2);
            transform: translateX(5px);
        }

        .feature-icon {
            width: 48px;
            height: 48px;
        }

        .feature-icon i {
            font-size: 1.75rem;
            color: white;
            opacity: 0.9;
        }

        .feature-item h3 {
            font-size: 1.25rem;
            font-weight: 600;
            margin-bottom: 0.5rem;
            color: white;
            line-height: 1.2;
        }

        .feature-item p {
            font-size: 0.95rem;
            opacity: 0.9;
            color: rgba(255, 255, 255, 0.9);
            margin: 0;
            line-height: 1.5;
        }
    </style>
</head>
<body>
    <div class="particles-container" id="particles-js"></div>
    <div class="login-page">
        <div class="login-card">
            <div class="login-left">
                <img src="../assets/images/bcplogo.png" alt="School Logo" class="school-logo">
                <div class="welcome-text">
                    <h1>Welcome Back!</h1>
                    <p>Please sign in to access your teacher dashboard</p>
                </div>
                
                <form method="POST" class="login-form">
                    <?php if (isset($error_message)) { ?>
                        <div class="error-message">
                            <i class="fas fa-exclamation-circle"></i>
                            <?php echo htmlspecialchars($error_message); ?>
                        </div>
                    <?php } ?>
                    
                    <div class="form-group">
                        <input type="text" name="username" placeholder="Username" required>
                        <i class="fas fa-user"></i>
                    </div>
                    
                    <div class="form-group">
                        <input type="password" name="password" placeholder="Password" required>
                        <i class="fas fa-lock"></i>
                    </div>
                    
                    <button type="submit" class="login-button">
                        <i class="fas fa-sign-in-alt"></i>
                        Sign In
                    </button>
                </form>
                
                <div class="login-footer">
                    <a href="../index.php">Back to Home</a>
                </div>
            </div>
            
            <div class="login-right">
                <div class="features-list">
                    <div class="feature-item">
                        <div class="feature-icon">
                            <i class="fas fa-user-graduate"></i>
                        </div>
                        <div class="feature-content">
                            <h3>Student Management</h3>
                            <p>Manage student records and academic progress</p>
                        </div>
                    </div>
                    
                    <div class="feature-item">
                        <div class="feature-icon">
                            <i class="fas fa-clock"></i>
                        </div>
                        <div class="feature-content">
                            <h3>Attendance Tracking</h3>
                            <p>Monitor student attendance and generate reports</p>
                        </div>
                    </div>
                    
                    <div class="feature-item">
                        <div class="feature-icon">
                            <i class="fas fa-chart-bar"></i>
                        </div>
                        <div class="feature-content">
                            <h3>Performance Analytics</h3>
                            <p>View and analyze student performance data</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/particles.js/2.0.0/particles.min.js"></script>
    <script>
        particlesJS("particles-js", {
            particles: {
                number: { value: 80, density: { enable: true, value_area: 800 } },
                color: { value: "#ffffff" },
                shape: { type: "circle" },
                opacity: { value: 0.5, random: false },
                size: { value: 3, random: true },
                line_linked: { enable: true, distance: 150, color: "#ffffff", opacity: 0.4, width: 1 },
                move: { enable: true, speed: 6, direction: "none", random: false, straight: false, out_mode: "out", bounce: false }
            },
            interactivity: {
                detect_on: "canvas",
                events: { onhover: { enable: true, mode: "repulse" }, onclick: { enable: true, mode: "push" }, resize: true },
                modes: { repulse: { distance: 100, duration: 0.4 }, push: { particles_nb: 4 } }
            },
            retina_detect: true
        });
    </script>
</body>
</html>