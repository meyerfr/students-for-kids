const popupContainer = document.getElementById('popup-container');
const openPopupButton = document.getElementById('open-popup-button');

function closePopup() {
  if (popupContainer) {
    popupContainer.addEventListener('click', function(e) {
      if(e.target != document.getElementById('popup-table')) {
        popupContainer.classList.add('d-none')
      }
    });
  };
}

function openPopup() {
  if (openPopupButton) {
    openPopupButton.addEventListener('click', function(e){
      console.log(popupContainer);
      popupContainer.classList.remove('d-none');
    })
  }
}

export { openPopup }
export { closePopup }
