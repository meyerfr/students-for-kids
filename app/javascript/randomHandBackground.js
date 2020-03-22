const handBackground = document.querySelector('.random-hand-backgroud-wrapper');

function randomCss() {
  if (handBackground) {
    const allImages = handBackground.querySelectorAll('img')
    for (var i = allImages.length - 1; i >= 0; i--) {
      var img = allImages[i]
      var randomDeg = Math.floor(Math.random() * 360) + 1;
      var randomX = Math.floor(Math.random() * (handBackground.offsetWidth * 0.225));
      var randomY = Math.floor(Math.random() * handBackground.offsetHeight) - 80;
      img.style.transform = `rotate(${randomDeg}deg)`;
      if (i < allImages.length/2) {
        img.style.left = `${randomX}px`;
      }else{
        img.style.right = `${randomX}px`;
      }
      img.style.top = `${randomY}px`;
    }
  }
}

export { randomCss }
