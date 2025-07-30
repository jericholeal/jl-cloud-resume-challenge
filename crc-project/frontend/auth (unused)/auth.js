// Authentication script

(function() {
    // Define correct password to grant access to site
    const correctPassword = "jkocloudman";

    // Check if sessionStorage has a flag indicating access was granted
    const stored = sessionStorage.getItem("accessGranted");

    // If access has been granted before in this session, redirect to index.html
    if (stored === "true") {
        window.location.href = "index.html"; // Redirect to index page
    }
})();

// Function to check entered password
function checkPassword() {
    // Get value the user typed in the password input field
    const input = document.getElementById("passwordInput").value;

    // Compare input against correct password
    if (input === "jkocloudman") {
        // Password is correct
        sessionStorage.setItem("accessGranted", "true"); // Store flag in sessionStorage

        // Redirect to index.html
        window.location.href = "index.html";
    } else {
        // Password is incorrect
        window.location.href = "accessdenied.html"; // Redirect to access denied page
    }
}