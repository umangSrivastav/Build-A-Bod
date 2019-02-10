function scrollto(div)
{
 $('html,body').animate(
 {
  scrollTop: $("#"+div).offset().top
 },'slow');
}

let backgroundLogos = document.querySelectorAll('.logo');
let arrows = document.querySelectorAll('.fa');
let webLinks = document.querySelectorAll('.code');
console.log(webLinks);

backgroundLogos.forEach(logo => {
  function growLogo(scaleFactor, color) {
    anime({
      targets: logo,
      backgroundColor: color,
      // easing: 'easeInOutQuad',
      scale: 1.8,
      delay: function(logo, i, l) {
        return i * 100;
      }
    });
  }

  function enterButton() {
    anime({
      targets: logo,
      backgroundColor: '#2e3131',
      scale: 1.9
    });
  }
  function leaveButton() {
    anime({
      targets: logo,
      backgroundColor: '#ececec',
      scale: 1.8
    });
  }
  logo.addEventListener('mouseenter', enterButton, false);
  logo.addEventListener('mouseleave', leaveButton, false);
  // panel.addEventListener('click', clickButton, false);
  growLogo(2, '#ececec');

})

arrows.forEach(arrow => {
  var temp = true;

  anime({
    targets: arrow,
    scale: 1.5
  });
  function enterButton() {
      anime({
        targets: arrow,
        scale: 3
      });
  }
  function leaveButton() {
    anime({
      delay: 100,
      targets: arrow,
      scale: 1.5
    });
  }

  arrow.addEventListener('mouseenter', enterButton, false);
  arrow.addEventListener('mouseleave', leaveButton, false);
})
