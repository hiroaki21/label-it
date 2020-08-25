function label_reload() {
  const reload = document.getElementById("reload");
    
  reload.addEventListener("click", (e) => {
    window.location.reload();
  })
}

window.addEventListener("load", label_reload);