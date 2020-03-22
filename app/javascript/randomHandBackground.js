const handBackground = document.querySelector('.random-hand-backgroud-wrapper');

function randomCss() {
  if (handBackground) {
    handBackground.querySelectorAll('img').forEach((img) => {
      var randomDeg = Math.floor(Math.random() * 360) + 1;
      var randomX = Math.floor(Math.random() * (handBackground.offsetWidth * 0.225));
      var randomY = Math.floor(Math.random() * handBackground.offsetHeight) - 80;
      img.style.transform = `rotate(${randomDeg}deg)`;
      if (((Math.random() * 2)) < 1) {
        img.style.left = `${randomX}px`;
      }else{
        img.style.right = `${randomX}px`;
      }
      img.style.top = `${randomY}px`;
    })
  }
}

export { randomCss }
