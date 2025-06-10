// API endpoint to fetch visitor count
const apiEndpoint = "https://2dqhper5il.execute-api.us-east-1.amazonaws.com/increment";

// Function to call Lambda function through API Gateway
async function fetchVisitorCount() {
    try {
        // Send GET request to Lambda function via API Gateway endpoint
        const response = await fetch(apiEndpoint);
    
        // Check if response is ok (status code 200)
        if (!response.ok) {
            throw new Error(`HTTP error! Status: ${response.status}`);
        }
    
        // Convert response to JSON
        const data = await response.json();
        
        // Extract visitor count from response (returned as count)
        const count = data.count;
    
        // Update visitor count in HTML (<span id="visitor-count">)
        document.getElementById("visitor-count").innerText = count;
    } catch (error) {                        
        // If there's an error (e.g. network issue), show a message and log it
        console.error("Error fetching visitor count:", error);
        document.getElementById("visitor-count").innerText = "Error fetching count";
    }
}

// Call the function to fetch visitor count when the page loads
fetchVisitorCount();