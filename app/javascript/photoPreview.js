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
          var profilePhotoContainer = target.parentElement.parentElement
          if (profilePhotoContainer.querySelector('img')) {
            profilePhotoContainer.querySelector('img').remove();
          }
          if (profilePhotoContainer.querySelector('.fa-user')) {
            profilePhotoContainer.querySelector('.fa-user').classList.add('d-none');
          }
          profilePhotoContainer.insertAdjacentHTML('afterbegin', `<img src=${e.target.result} alt="Project Image" class="img-thumbnail"/>`);
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
