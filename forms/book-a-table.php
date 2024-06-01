<?php
include 'config.php'; // Ensure your database configuration is included

// Validate and sanitize input data
function validate_input($data) {
  $data = trim($data);
  $data = stripslashes($data);
  $data = htmlspecialchars($data);
  return $data;
}

$name = $email = $phone = $password = $confirm_password = "";
$error_message = "";

if ($_SERVER["REQUEST_METHOD"] == "POST") {
  $name = validate_input($_POST['name']);
  $email = validate_input($_POST['email']);
  $phone = validate_input($_POST['phone']);
  $password = validate_input($_POST['date']); // Assuming 'date' is the password field
  $confirm_password = validate_input($_POST['time']); // Assuming 'time' is the confirm password field
  
  // Validate inputs
  if (empty($name) || empty($email) || empty($phone) || empty($password) || empty($confirm_password)) {
    $error_message = "All fields are required.";
  } elseif (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
    $error_message = "Invalid email format.";
  } elseif ($password !== $confirm_password) {
    $error_message = "Passwords do not match.";
  } else {
    // Hash the password
    $hashed_password = password_hash($password, PASSWORD_DEFAULT);

    // Insert data into the database
    $stmt = $conn->prepare("INSERT INTO users (username, email, phone, password) VALUES (?, ?, ?, ?)");
    $stmt->bind_param("ssss", $name, $email, $phone, $hashed_password);

    if ($stmt->execute()) {
      echo "New record created successfully";
      $stmt->close();
      $conn->close();
      exit;
    } else {
      $error_message = "Error: " . $stmt->error;
    }

    $stmt->close();
    $conn->close();
  }
}
?>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <title>4Ys'Stall - Sign Up</title>
    <link href="assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link href="assets/css/main.css" rel="stylesheet">
</head>

<body>
    <section id="book-a-table" class="book-a-table">
        <div class="container" data-aos="fade-up">
            <div class="section-header">
                <h2>Sign up</h2>
                <p>Sign<span>up</span> With Us</p>
            </div>
            <div class="row g-0">
                <div class="col-lg-12 d-flex align-items-center reservation-form-bg">
                    <form action="book-a-table.php" method="post" role="form" class="php-email-form" data-aos="fade-up"
                        data-aos-delay="100">
                        <?php if (!empty($error_message)): ?>
                        <div class="alert alert-danger"><?php echo $error_message; ?></div>
                        <?php endif; ?>
                        <div class="row gy-4">
                            <div class="col-lg-4 col-md-6">
                                <input type="text" name="name" class="form-control" id="name" placeholder="Your Name"
                                    value="<?php echo $name; ?>" required />
                            </div>
                            <div class="col-lg-4 col-md-6">
                                <input type="email" class="form-control" name="email" id="email"
                                    placeholder="Your Email" value="<?php echo $email; ?>" required />
                            </div>
                            <div class="col-lg-4 col-md-6">
                                <input type="text" class="form-control" name="phone" id="phone" placeholder="Your Phone"
                                    value="<?php echo $phone; ?>" required />
                            </div>
                            <div class="col-lg-4 col-md-6">
                                <input type="password" name="date" class="form-control" id="date" placeholder="Password"
                                    required />
                            </div>
                            <div class="col-lg-4 col-md-6">
                                <input type="password" class="form-control" name="time" id="time"
                                    placeholder="Confirm password" required />
                            </div>
                        </div>
                        <div class="mb-3">
                            <div class="loading">Loading</div>
                            <div class="error-message"></div>
                            <div class="sent-message">Signing you up!</div>
                        </div>
                        <div class="text-center"><button type="submit">Sign up</button></div>
                    </form>
                </div>
            </div>
        </div>
    </section>
</body>

</html>
