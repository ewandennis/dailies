var slides = [];
var slideNode;
var slideIdx = 0;
var slidePeriod = 5000;
var transitionPeriod = 2000;

window.onload = function() {
  var canvas = document.getElementById('canvas');
  canvas.onclick = function() {
    if (canvas.requestFullscreen) {
      canvas.requestFullscreen();
    }
    if (canvas.webkitRequestFullscreen) {
      canvas.webkitRequestFullscreen();
    }
  };
  loadSlides();
};

function loadSlides() {
  var req = new XMLHttpRequest();
  req.addEventListener('load', function() {
    var resp = JSON.parse(this.responseText);
    slides = resp.data.map(function(slide) {
      return slide.url;
    });
    nextSlide();
  });
  req.open('GET', '/api/slides');
  req.send();
}

function nextSlide() {
  slideIdx = ++slideIdx % slides.length;
  enqueueSlide(slides[slideIdx]);
}

function enqueueSlide(url) {
  var canvas = document.getElementById('canvas');
  var onload = function(slide, duration) {
    if (slideNode) {
      fadeOut(slideNode, function() {
        slideNode.parentElement.removeChild(slideNode);
        slideNode = slide;
      });
    } else {
      slideNode = slide;
    }
    fadeIn(slide, function() {
      setTimeout(nextSlide, duration < slidePeriod? slidePeriod : duration - transitionPeriod);
    });
  };
  var newSlide = url.endsWith('.mp4') ? video(url, onload) : img(url, onload);
  canvas.appendChild(newSlide);
}

function fadeOut(obj, next) {
  obj.classList.remove('fadeIn');
  obj.classList.add('fadeOut');
  setTimeout(function() {
    obj.style.opacity = 0;
    setTimeout(next, transitionPeriod);
  }, 1);
}

function fadeIn(obj, next) {
  obj.classList.remove('fadeOut');
  obj.classList.add('fadeIn');
  setTimeout(function() {
    obj.style.opacity = 1;
    setTimeout(next, transitionPeriod);
  }, 1);
}

function video(url, onloadfn) {
  var vid = document.createElement('video');
  vid.autoplay = 'autoplay';
  var src = document.createElement('source');
  src.src = url; 
  vid.appendChild(src);
  vid.onloadedmetadata = function() {
    presentObject(vid, vid.videoWidth, vid.videoHeight);
    setTimeout(function() {
      onloadfn(vid, 2000); //vid.duration * 1000);
    }, 1);
  };
  return vid;
}

function img(url, onloadfn) {
  var pic = document.createElement('img');
  pic.src = url;
  pic.onload = function() {
    presentObject(pic, pic.width, pic.height);
    onloadfn(pic, 0);
  };
  return pic;
}

function presentObject(obj, w, h) {
  var centre;
  if (w > h) {
    obj.className = 'landscape';
    centre = function() {
      var rect = obj.getBoundingClientRect();
      var pageRect = document.getElementById('canvas').getBoundingClientRect();
      if (pageRect.height > rect.height) {
        obj.style.top = ((pageRect.height - rect.height) / 2) + 'px';
      }
    };
  } else {
    obj.className = 'portrait';
    centre = function() {
      var rect = obj.getBoundingClientRect();
      var pageRect = document.body.getBoundingClientRect();
      if (pageRect.width > rect.width) {
        obj.style.left = ((pageRect.width - rect.width) / 2) + 'px';
      }
    };
  }
  setTimeout(centre, 1);
  window.addEventListener('resize', centre);
}

