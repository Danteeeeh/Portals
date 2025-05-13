<?php
session_start();

// Clear any existing session
session_destroy();
session_start();

require_once '../includes/Database.php';
require_once '../includes/Auth.php';

$db = new Database();
$auth = new Auth($db);

$error = '';
$success = '';

// Redirect if already logged in as student
if (isset($_SESSION['user_role']) && $_SESSION['user_role'] === 'student') {
    header('Location: studentdashboard.php');
    exit();
}

if (isset($_POST['login'])) {
    $username = trim($_POST['username']);
    // Remove 'Ld' prefix if it exists
    $username = preg_replace('/^Ld/i', '', $username);
    $password = isset($_POST['password']) ? trim($_POST['password']) : '';

    if (empty($username) || empty($password)) {
        $error = 'Please enter both username and password';
    } else {
        try {
            if ($auth->login($username, $password)) {
                // Verify user is a student
                if ($_SESSION['user_role'] === 'student') {
                    // Redirect to student dashboard
                    header('Location: studentdashboard.php');
                    exit();
                } else {
                    $error = 'Invalid student credentials';
                    session_destroy();
                }
            } else {
                $error = 'Invalid username or password';
            }
        } catch (Exception $e) {
            error_log('Login Error: ' . $e->getMessage());
            $error = 'System error occurred. Please try again later.';
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
    <title>Student Login - SIA System</title>
    <meta name="description" content="Student login portal for Student Information and Attendance System">
    <style>
        .particles-container {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            z-index: -1;
            background: linear-gradient(135deg, #4361ee 0%, #3f37c9 100%);
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
            background: linear-gradient(135deg, #4361ee 0%, #3f37c9 100%);
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
        }

        .login-form {
            display: flex;
            flex-direction: column;
            gap: 1.5rem;
            margin-top: 2rem;
            width: 100%;
            max-width: 400px;
        }

        .form-title {
            font-size: 2rem;
            font-weight: 700;
            margin-bottom: 1rem;
            background: linear-gradient(135deg, #4361ee 0%, #3f37c9 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            text-align: center;
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
            background: white;
        }

        .form-group i {
            position: absolute;
            left: 1rem;
            top: 50%;
            transform: translateY(-50%);
            color: #94a3b8;
            transition: all 0.3s ease;
        }

        .form-group input:focus + i {
            color: #4361ee;
        }

        .login-button {
            width: 100%;
            padding: 1rem;
            border: none;
            border-radius: 12px;
            background: linear-gradient(135deg, #4361ee 0%, #3f37c9 100%);
            color: white;
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            margin-top: 1rem;
        }

        .login-button:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(67, 97, 238, 0.25);
        }

        .login-button:active {
            transform: translateY(0);
        }

        .form-footer {
            text-align: center;
            margin-top: 2rem;
            color: #64748b;
        }

        .form-footer a {
            color: #4361ee;
            text-decoration: none;
            font-weight: 500;
            transition: all 0.3s ease;
        }

        .form-footer a:hover {
            text-decoration: underline;
        }

        .alert {
            padding: 1rem;
            border-radius: 12px;
            margin-bottom: 1rem;
            font-size: 0.875rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .alert-error {
            background: #fee2e2;
            color: #dc2626;
            border: 1px solid #fecaca;
        }

        .alert-success {
            background: #dcfce7;
            color: #16a34a;
            border: 1px solid #bbf7d0;
        }

        .form-hint {
            display: block;
            margin-top: -0.5rem;
            margin-bottom: 1rem;
            font-size: 0.75rem;
            color: #64748b;
            text-align: left;
        }

        .show-password {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            font-size: 0.875rem;
            color: #64748b;
            cursor: pointer;
        }

        .show-password input[type="checkbox"] {
            width: 1rem;
            height: 1rem;
            margin: 0;
        }

        .form-group input:focus + i {
            color: #4361ee;
        }

        .login-button {
            background: linear-gradient(135deg, #4361ee 0%, #3f37c9 100%);
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
            color: #4361ee;
            text-decoration: none;
            font-weight: 500;
        }

        .features-list {
            margin-top: 2rem;
            display: flex;
            flex-direction: column;
            gap: 1rem;
        }

        .feature-item {
            display: flex;
            align-items: center;
            gap: 1rem;
            background: rgba(255, 255, 255, 0.1);
            padding: 1rem;
            border-radius: 12px;
        }

        .feature-item i {
            font-size: 1.5rem;
        }

        .error-message, .success-message {
            padding: 12px;
            border-radius: 8px;
            margin-bottom: 16px;
            font-size: 0.875rem;
        }
        
        .error-message {
            background: #fee2e2;
            border: 1px solid #fecaca;
            color: #dc2626;
        }
        
        .success-message {
            background: #dcfce7;
            border: 1px solid #bbf7d0;
            color: #16a34a;
        }
        
        .text-primary {
            color: #4361ee;
        }
        
        .hover\:underline:hover {
            text-decoration: underline;
        }
        }
    </style>
    <script>
        function togglePassword() {
            var x = document.getElementById("password");
            if (x.type === "password") {
                x.type = "text";
            } else {
                x.type = "password";
            }
        }
    </script>
</head>
<body>
    <div class="particles-container" id="particles-js"></div>
    <div class="login-page">
        <div class="login-card">
            <div class="login-left">
                <img src="../assets/images/bcplogo.png" alt="School Logo" class="school-logo">
                <div class="welcome-text">
                    <h1>Welcome Back!</h1>
                    <p>Please sign in to access your student portal</p>
                </div>
                <?php if (isset($error_message)): ?>
                    <div class="error-message">
                        <i class="fas fa-exclamation-circle"></i>
                        <?php echo $error_message; ?>
                    </div>
                <?php endif; ?>
                <div class="login-form">
                    <h1 class="form-title">Welcome Back</h1>
                    <?php if (!empty($error)): ?>
                        <div class="error-message">
                            <?php echo $error; ?>
                        </div>
                    <?php endif; ?>
                    <?php if (!empty($success)): ?>
                        <div class="success-message">
                            <?php echo $success; ?>
                        </div>
                    <?php endif; ?>
                    <form method="post">
                        <div class="form-group">
                            <input type="text" name="username" placeholder="Enter Student ID" required pattern="[0-9]+" title="Please enter only numbers">
                            <i class="fas fa-id-card"></i>
                        </div>
                        <div class="form-group">
                            <input type="password" name="password" id="password" placeholder="Password" required>
                            <i class="fas fa-lock"></i>
                        </div>
                        <div class="form-group">
                            <label class="show-password">
                                <input type="checkbox" onclick="togglePassword()"> Show Password
                            </label>
                        </div>
                        <button type="submit" name="login" class="login-button">
                            <span>Sign In</span>
                        </button>
                    </form>
                    <div class="form-footer">
                        <p>Forgot your password? <a href="reset_password.php">Reset it here</a></p>
                    </div>
                </div>
                <div class="login-footer">
                    <p>Need help? <a href="#">Contact Support</a></p>
                    <p style="margin-top: 0.5rem;"><a href="../index.php">← Back to Home</a></p>
                </div>
            </div>
            <div class="login-right">
                <h2 style="font-size: 1.5rem; font-weight: 700; margin-bottom: 1rem;">Student Information System</h2>
                <p style="margin-bottom: 2rem; opacity: 0.9;">Access all your academic information in one place</p>
                <div class="features-list">
                    <div class="feature-item">
                        <i class="fas fa-graduation-cap"></i>
                        <div>
                            <h3>Academic Records</h3>
                            <p>View your grades and academic progress</p>
                        </div>
                    </div>
                    <div class="feature-item">
                        <i class="fas fa-calendar-check"></i>
                        <div>
                            <h3>Attendance Tracking</h3>
                            <p>Monitor your class attendance</p>
                        </div>
                    </div>
                    <div class="feature-item">
                        <i class="fas fa-clock"></i>
                        <div>
                            <h3>Class Schedule</h3>
                            <p>Access your daily class schedule</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/particles.js/2.0.0/particles.min.js"></script>
    <script>
        particlesJS('particles-js', {
            particles: {
                number: { value: 80, density: { enable: true, value_area: 800 } },
                color: { value: '#ffffff' },
                shape: { type: 'circle' },
                opacity: { value: 0.5, random: false },
                size: { value: 3, random: true },
                line_linked: { enable: true, distance: 150, color: '#ffffff', opacity: 0.4, width: 1 },
                move: { enable: true, speed: 6, direction: 'none', random: false, straight: false, out_mode: 'out', bounce: false }
            },
            interactivity: {
                detect_on: 'canvas',
                events: { onhover: { enable: true, mode: 'repulse' }, onclick: { enable: true, mode: 'push' }, resize: true },
                modes: { repulse: { distance: 100, duration: 0.4 }, push: { particles_nb: 4 } }
            },
            retina_detect: true
        });
    </script>
</body>
</html>