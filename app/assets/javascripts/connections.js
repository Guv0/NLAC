$("tr[data-link]").click(function() {
  window.location = $(this).getAttribute("data-link")
})
