function label_post() {
  const submit = document.getElementById("submit");
  submit.addEventListener("click", (e) => {
    const formData = new FormData(document.getElementById("form"));
    const XHR = new XMLHttpRequest();
    XHR.open("POST", "/posts", true);
    XHR.responseType = "json";
    XHR.send(formData);
    XHR.onload = () => {
      const it = XHR.response.post;
      const list = document.getElementById("list");
      const formText = document.getElementById("body");

      const date = new Date(it.created_at)
      const timeFormat = date.toLocaleString();
      
      const HTML = `
      <div class="card-post">
        <div class="card border-primary mb-3" style="width: 15rem;" data-id=${it.id}>
          <div class="card-header">${timeFormat}</div>
          <div class="card-body text-dark">
            <h5 class="card-title">${it.body}</h5>
          </div>
        </div>
      </div>
      `;
      if (formText.value.match(/\S/g)){
      list.insertAdjacentHTML("afterend", HTML);
      formText.value = "";  
      }

      if (XHR.status != 200) {
        alert(`Error ${XHR.status}: ${XHR.statusText}`);
      } else {
        return null;
      }
    };

    XHR.onerror = function () {
      alert("Request failed");
    };

    e.preventDefault();
  })
}

window.addEventListener("load", label_post);
