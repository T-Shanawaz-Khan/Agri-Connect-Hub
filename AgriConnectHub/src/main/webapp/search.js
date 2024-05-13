function search() {
    var query = document.getElementById("searchInput").value.trim();
    var searchResultsSection = document.getElementById("searchResults");
    var otherContent = document.getElementById("mainContent"); // Assuming this is the ID of the other content you want to hide

    if (query === "") {
        // Don't perform empty searches
        searchResultsSection.innerHTML = ""; // Clear previous search results
        searchResultsSection.style.display = "none"; // Hide search results section
        return;
    }

    var xhr = new XMLHttpRequest();
    xhr.open("GET", "searchServlet?query=" + encodeURIComponent(query), true);
    xhr.setRequestHeader("Content-Type", "application/json");
    xhr.onreadystatechange = function() {
        if (xhr.readyState == 4 && xhr.status == 200) {
            var searchResults = JSON.parse(xhr.responseText);
            displaySearchResults(searchResults);
            searchResultsSection.style.display = "block"; // Show search results section
            otherContent.style.display = "none"; // Hide other content
        }
    };
    xhr.send();
}


function displaySearchResults(searchResults) {
    var searchResultsSection = document.getElementById("searchResults");
    searchResultsSection.innerHTML = "";
    console.log(searchResults.length);
	if (searchResults.length === 0) {
    	var noResultsImage = document.createElement("img");
    	noResultsImage.src = "images/noresults.jpg"; // Replace "no_results_image.jpg" with the path to your image
    	noResultsImage.alt = "No results found";
    	searchResultsSection.appendChild(noResultsImage);
    	return;
	}


    searchResults.forEach(function(result) {
        var resultElement = document.createElement("div");
        resultElement.classList.add("search-result");

        // Create a wrapper div for the image and details
        var cardWrapper = document.createElement("div");
        cardWrapper.classList.add("card-wrapper");

        // Image container
        var imgContainer = document.createElement("div");
        imgContainer.classList.add("image-container");
        var imgElement = document.createElement("img");
        imgElement.src = result.imageSrc;
        imgElement.alt = result.title;
        imgContainer.appendChild(imgElement);
        cardWrapper.appendChild(imgContainer);

        // Details container
        var detailsContainer = document.createElement("div");
        detailsContainer.classList.add("details-container");
        
        var titleElement = document.createElement("h3");
        titleElement.textContent = result.title;
        detailsContainer.appendChild(titleElement);

        var descriptionElement = document.createElement("p");
        descriptionElement.textContent = result.description.substring(0, 100)+"..."; // Display only first 100 characters
        detailsContainer.appendChild(descriptionElement);

        cardWrapper.appendChild(detailsContainer);
        
        resultElement.addEventListener("click", function() {
            if (result.type === "blog") {
                window.location.href = "displayBlog.jsp?id=" + result.id; // Redirect to blog page
            } else if (result.type === "product") {
                // Redirect to mart.jsp and open respective pop up (replace with your logic)
                window.location.href = "mart.jsp#" + result.productId; // Redirect to product page
                // Open respective pop up (you need to implement this logic)
            }
        });

        resultElement.appendChild(cardWrapper);

        searchResultsSection.appendChild(resultElement);
    });
}
