document.getElementById('registrationForm').addEventListener('submit', function(event) {
    event.preventDefault(); // Prevent form submission

    // Get form values
    const username = document.getElementById('username').value;
    const email = document.getElementById('email').value;
    const password = document.getElementById('password').value;
    const confirmPassword = document.getElementById('confirmPassword').value;

    // Clear message
    document.getElementById('message').textContent = '';

    // Validate form
    if (password !== confirmPassword) {
        document.getElementById('message').textContent = "Passwords do not match!";
        return;
    }

    // Simple mock submission
    document.getElementById('message').textContent = "Registration successful!";
});
