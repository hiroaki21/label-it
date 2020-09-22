function label_reload() {
  const reload = document.getElementById("reload");
  try{  
  reload.addEventListener("click", (e) => {
    window.location.reload();
  })
  }catch(error){}
}

window.addEventListener("load", label_reload);