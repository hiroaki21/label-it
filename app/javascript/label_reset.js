function label_reset() {
  const destroy = document.getElementById("destroy");

  try{
  destroy.addEventListener("click", (e) => {
    $('input[type="text"]').val('');
  })
  }catch(ignoreError){}
}

window.addEventListener("load", label_reset);