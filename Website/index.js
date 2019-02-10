function scrollto(div)
{
 $('html,body').animate(
 {
  scrollTop: $("#"+div).offset().top
 },'slow');
}

let backgroundCircles = document.querySelectorAll('.circle');
let arrows = document.querySelectorAll('.fa');

backgroundCircles.forEach(circle => {
  function growCircle(scaleFactor, color) {
    anime({
      targets: circle,
      backgroundColor: color,
      // easing: 'easeInOutQuad',
      scale: 1.8,
      delay: function(circle, i, l) {
        return i * 100;
      }
      });
  }

  function enterButton() {
    anime({
      targets: circle,
      backgroundColor: '#A3A9AA',
      scale: 2.1
    })
  }
  function leaveButton() {
    anime({
      targets: circle,
      backgroundColor: '#ececec',
      scale: 1.8
    })
  }
  circle.addEventListener('mouseenter', enterButton, false);
  circle.addEventListener('mouseleave', leaveButton, false);
  // panel.addEventListener('click', clickButton, false);
  growCircle(2, '#ececec');

})

arrows.forEach(arrow => {
  var temp = true;

  anime({
    targets: arrow,
    scale: 1.5
  })
  function enterButton() {
      anime({
        targets: arrow,
        scale: 2
      })
  }
  function leaveButton() {
    anime({
      delay: 100,
      targets: arrow,
      scale: 1.5
    })
  }

  arrow.addEventListener('mouseenter', enterButton, false);
  arrow.addEventListener('mouseleave', leaveButton, false);
})
