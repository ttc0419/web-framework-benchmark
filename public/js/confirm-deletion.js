const deleteButtons = document.querySelectorAll("button.btn-danger");
for (const button of deleteButtons) {
    button.addEventListener("click", function (event) {
        if (confirm(`Are you sure you want to delete "${event.target.parentElement.parentElement.firstElementChild.textContent}"?`))
            document.getElementById("deletion-form").submit();
        else
            event.preventDefault();
    });
}
