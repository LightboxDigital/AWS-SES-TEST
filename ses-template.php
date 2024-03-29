<?php

// Modify the path in the require statement below to refer to the
// location of your Composer autoload.php file.
require_once __DIR__ . '/vendor/autoload.php';

// Instantiate a new PHPMailer
$mail = new PHPMailer\PHPMailer\PHPMailer();

// Tell PHPMailer to use SMTP
$mail->isSMTP();

$mail->SMTPDebug = 2;

// Replace sender@example.com with your "From" address.
// This address must be verified with Amazon SES.
$mail->setFrom('[[FROM-ADDRESS]]', 'AWS SES');

// Replace recipient@example.com with a "To" address. If your account
// is still in the sandbox, this address must be verified.
// Also note that you can include several addAddress() lines to send
// email to multiple recipients.
$mail->addAddress('[[RECEIVER-ADDRESS]]', '[[RECEIVER-NAME]]');

// Replace smtp_username with your Amazon SES SMTP user name.
$mail->Username = '[[SMTP-USERNAME]]';

// Replace smtp_password with your Amazon SES SMTP password.
$mail->Password = '[[SMTP-PASSWORD]]';

// Specify a configuration set. If you do not want to use a configuration
// set, comment or remove the next line.
// $mail->addCustomHeader('X-SES-CONFIGURATION-SET', 'ConfigSet');

// If you're using Amazon SES in a region other than US West (Oregon),
// replace email-smtp.us-west-2.amazonaws.com with the Amazon SES SMTP
// endpoint in the appropriate region.
$mail->Host = 'email-smtp.eu-west-1.amazonaws.com';

// The subject line of the email
$mail->Subject = 'Amazon SES test (SMTP interface accessed using PHP)';

// The HTML-formatted body of the email
$mail->Body = '<h1>Email Test</h1>
    <p>This email was sent through the
    <a href="https://aws.amazon.com/ses">Amazon SES</a> SMTP
    interface using the <a href="https://github.com/PHPMailer/PHPMailer">
    PHPMailer</a> class.</p>';

// Tells PHPMailer to use SMTP authentication
$mail->SMTPAuth = true;

// Enable TLS encryption over port 587
$mail->SMTPSecure = 'tls';
$mail->Port = 587;

// Tells PHPMailer to send HTML-formatted email
$mail->isHTML(true);

// The alternative email body; this is only displayed when a recipient
// opens the email in a non-HTML email client. The \r\n represents a
// line break.
$mail->AltBody = "Email Test\r\nThis email was sent through the
    Amazon SES SMTP interface using the PHPMailer class.";

if(!$mail->send()) {
    echo "Email not sent. " . $mail->ErrorInfo . PHP_EOL;
} else {
    echo "Email sent!" . PHP_EOL;
}
?>
