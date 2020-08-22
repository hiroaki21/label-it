function label_reset() {
  const destroy = document.getElementById("destroy");
    
  destroy.addEventListener("click", (e) => {
    $('input[type="text"]').val('');
  })
}

window.addEventListener("load", label_reset);