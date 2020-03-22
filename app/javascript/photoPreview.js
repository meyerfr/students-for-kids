const imagePreview = document.querySelector('.img-prev');

const insertPictures = (event) => {
  if (event.target.files && event.target.files[0]) {
    var files = event.target.files
    for (var i = 0; i < files.length; i++) {
      (function(file) {
        var reader = new FileReader();
        var target = event.target;
        reader.onload = function (e) {
          console.log(e)
          console.log(target)
          if (target.parentElement.parentElement.querySelector('img')) {
            target.parentElement.parentElement.querySelector('img').remove();
          }
          target.parentElement.parentElement.insertAdjacentHTML('afterbegin', `<img src=${e.target.result} alt="Project Image" class="img-thumbnail"/>`);
          // target.parentElement.previousElementSibling.classList.add('d-none');
          // target.parentElement.parentElement.parentElement.style('background', 'transparent url('+e.target.result +') left top no-repeat');
          // target.parentElement.parentElement.parentElement.style.backgroundImage = `url(${e.target.result})`;
          // target.parentElement.parentElement.parentElement.classList.add('d-none');
        };
        reader.readAsDataURL(file)
      })(files[i]);
    }
  }
};

function previewPhoto() {
  if (imagePreview) {
    document.querySelector('.picture-upload').addEventListener('change', insertPictures)
  }
};

export { previewPhoto };
export { insertPictures };
// <img id="img_prev" width=300 height=300 src="#" alt="your image" class="img-thumbnail d-none"/> <br/>
