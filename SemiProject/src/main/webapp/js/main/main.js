$(function(){
	var myCarousel = document.querySelector('#carouselExampleIndicators')
	var carousel = new bootstrap.Carousel(myCarousel, {
	  interval: 2000,
	  wrap: false,
	  autoplay:true,
	  loop:true
	})
})