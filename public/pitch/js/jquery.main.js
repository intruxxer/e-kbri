// jQuery.noConflict();
// page init
jQuery(function(){
	initNav();
	initPressedState();
	initScrollPage();
});

// navigation init
function initNav() {
	initAutoScalingNav({
		menuId: "nav",
		sideClasses: true,
		spacing: 46
	});
}

//pressed state init
function initPressedState(){
	jQuery('.btn-start').pressedState({
		pressedClass: 'btn-start-pressed'
	});
}

// smooth scrolling init
function initScrollPage(){
	var animSpeed = 700; //ms
	var page = jQuery('body, html');
	var win = jQuery(window);
	var activeClass = 'active';
	var wrapper = jQuery('#wrapper');
	var links = wrapper.find('#nav a');
	var sliderHolder = wrapper.find('div.slider-block');
	var slider = wrapper.find('div.slider');
	var wrapperHeight = wrapper.outerHeight();
	var coordinateArr = [];
	var linksArr = [];
	var startBtn = jQuery('.btn-start');
	var startTarget = jQuery(startBtn.attr('href'));
	var navHolder = jQuery('.nav-holder');
	var koef = 100;
	var clicked = false;
	
	links.each(function(){
		if (jQuery(this).attr('href') != '#' && jQuery(this).attr('href').length > 1 ){
			linksArr.push(jQuery(this))
		}
	});
	if(jQuery('#' + Hash.get()).length){
		page.each(function(){
			this.scrollTop = 0;
		});
		var target = jQuery('#' + Hash.get());
	}
	startBtn.bind('click', function(e){
		page.animate({scrollTop: startTarget.offset().top}, { queue: false, duration: animSpeed, complete: function(){
			win.trigger('resize');
		}})
		e.preventDefault();
	});
	
	for (var i=0;i<linksArr.length; i++){
		if (jQuery(linksArr[i].attr('href')).length){
			linksArr[i].bind('click', function(e){
				var link = jQuery(this);
				var anchor =link .attr('href');
				if (jQuery(anchor).length){
					clicked = true;
					slider.stop().animate({width:link.offset().left + link.width()/2 - sliderHolder.offset().left},{duration: animSpeed, queue: false,complete:function(){
						clicked = false;
					}})
					page.animate({scrollTop: jQuery(anchor).offset().top}, { queue: false, duration: animSpeed, complete: function(){
						win.trigger('resize');
					}})
				}
				e.preventDefault();
			});
			coordinateArr.push(jQuery(linksArr[i].attr('href')).offset().top)
		};
	};
	
	function moveActive(){
		if (!coordinateArr.length) return;
		var windowScrollTop = win.scrollTop();
		var windowHeight = win.height();
		if (windowScrollTop > 0) {
			navHolder.addClass('active');
		} else {
			navHolder.removeClass('active');
		}
		for (var i=0;i<coordinateArr.length; i++){
			if (windowScrollTop < coordinateArr[i] + koef && windowScrollTop > coordinateArr[i] - koef ){
				links.parent().removeClass(activeClass);
				linksArr[i].parent().addClass(activeClass);
				if (!clicked) slider.stop().animate({width:linksArr[i].offset().left + linksArr[i].width()/2 - sliderHolder.offset().left},{duration: animSpeed, queue: false})
			}
			if (windowScrollTop + windowHeight == wrapperHeight) {
				links.parent().removeClass(activeClass);
				linksArr[coordinateArr.length-1].parent().addClass(activeClass);
			}
		}
	};
	
	moveActive();
	
	jQuery(document).keydown(function(e) {
		if (!e) evt = window.event;
		if (e.keyCode == 39) {
			links.parent().filter('.'+activeClass).next().find('>a').trigger('click');
		}
		if (e.keyCode == 37) {
			links.parent().filter('.'+activeClass).prev().find('>a').trigger('click');
		}
	})
	win.bind('scroll', moveActive);
};

/*
 * jQuery Pressed State helper plugin
 */
;(function($){
	$.fn.pressedState = function(o) {
		var options = $.extend({
			pressedClass: 'pressed'
		},o);
		
		// add handlers
		return this.each(function(){
			var item = $(this);
			if(isTouchDevice) {
				item.bind('touchstart', function() {
					item.addClass(options.pressedClass);
					$(document).one('touchend', function() {
						item.removeClass(options.pressedClass);
					});
				})
			} else {
				item.bind('mousedown', function() {
					item.addClass(options.pressedClass);
					item.bind('mouseup.pstate mouseleave.pstate', function() {
						item.removeClass(options.pressedClass).unbind('.pstate');
					}).bind('mousemove.pstate', function(e) {
						e.preventDefault();
					});
				});
			}
		});
	}
	
	// detect device type
	var isTouchDevice = (function() {
		try {
			return ('ontouchstart' in window) || window.DocumentTouch && document instanceof DocumentTouch;
		} catch (e) {
			return false;
		}
	}());
	
}(jQuery));

// autoscaling plugin
function initAutoScalingNav(o) {
	if (!o.menuId) o.menuId = "nav";
	if (!o.tag) o.tag = "a";
	if (!o.spacing) o.spacing = 0;
	if (!o.constant) o.constant = 0;
	if (!o.minPaddings) o.minPaddings = 0;
	if (!o.liHovering) o.liHovering = false;
	if (!o.sideClasses) o.sideClasses = false;
	if (!o.equalLinks) o.equalLinks = false;
	if (!o.flexible) o.flexible = false;
	var nav = document.getElementById(o.menuId);
	if(nav) {
		nav.className += " scaling-active";
		var lis = nav.getElementsByTagName("li");
		var asFl = [];
		var lisFl = [];
		var width = 0;
		for (var i=0, j=0; i<lis.length; i++) {
			if(lis[i].parentNode == nav) {
				var t = lis[i].getElementsByTagName(o.tag).item(0);
				asFl.push(t);
				asFl[j++].width = t.offsetWidth;
				lisFl.push(lis[i]);
				if(width < t.offsetWidth) width = t.offsetWidth;
			}
			if(o.liHovering) {
				lis[i].onmouseover = function() {
					this.className += " hover";
				}
				lis[i].onmouseout = function() {
					this.className = this.className.replace("hover", "");
				}
			}
		}
		var menuWidth = nav.clientWidth - asFl.length*o.spacing - o.constant;
		if(o.equalLinks && width * asFl.length < menuWidth) {
			for (var i=0; i<asFl.length; i++) {
				asFl[i].width = width;
			}
		}
		width = getItemsWidth(asFl);
		if(width < menuWidth) {
			var version = navigator.userAgent.toLowerCase();
			for (var i=0; getItemsWidth(asFl) < menuWidth; i++) {
				asFl[i].width++;
				if(!o.flexible) {
					asFl[i].style.width = asFl[i].width + "px";
				}
				if(i >= asFl.length-1) i=-1;
			}
			if(o.flexible) {
				for (var i=0; i<asFl.length; i++) {
					width = (asFl[i].width - o.spacing - o.constant/asFl.length)/menuWidth*100;
					if(i != asFl.length-1) {
						lisFl[i].style.width = width + "%";
					}
					else {
						if(navigator.appName.indexOf("Microsoft Internet Explorer") == -1 || version.indexOf("msie 8") != -1 || version.indexOf("msie 9") != -1)
							lisFl[i].style.width = width + "%";
					}
				}
			}
		}
		else if(o.minPaddings > 0) {
			for (var i=0; i<asFl.length; i++) {
				asFl[i].style.paddingLeft = o.minPaddings + "px";
				asFl[i].style.paddingRight = o.minPaddings + "px";
			}
		}
		if(o.sideClasses) {
			lisFl[0].className += " first-child";
			lisFl[0].getElementsByTagName(o.tag).item(0).className += " first-child-a";
			lisFl[lisFl.length-1].className += " last-child";
			lisFl[lisFl.length-1].getElementsByTagName(o.tag).item(0).className += " last-child-a";
		}
		nav.className += " scaling-ready";
	}
	function getItemsWidth(a) {
		var w = 0;
		for(var q=0; q<a.length; q++) {
			w += a[q].width;
		}
		return w;
	}
}

// Hash history utility module
Hash = {
	init: function() {
		this._handlers = [];
		this.initChangeHandler();
		return this;
	},
	hashChangeSupported: (function(){
		return 'onhashchange' in window && (document.documentMode === undefined || document.documentMode > 7);
	})(),
	initChangeHandler: function() {
		var needFrame = /(MSIE 6|MSIE 7)/.test(navigator.userAgent);
		var delay = 200, instance = this, oldHash, newHash, frameHash;
		frameHash = oldHash = newHash = location.hash;
		
		// create iframe if needed
		if(needFrame) {
			this.fixFrame = document.createElement('iframe');
			this.fixFrame.style.display = 'none';
			document.documentElement.insertBefore(this.fixFrame,document.documentElement.childNodes[0]);
			this.fixFrame.contentWindow.document.open();
			this.fixFrame.contentWindow.document.close();
			this.fixFrame.contentWindow.location.hash = oldHash;
		}
		
		// change listener
		if(this.hashChangeSupported) {
			function changeHandler() {
				newHash = location.hash;
				instance.makeCallbacks(newHash, oldHash);
				oldHash = newHash;
			}
			if(window.addEventListener) window.addEventListener('hashchange',changeHandler, false);
			else if(window.attachEvent) window.attachEvent('onhashchange',changeHandler);
		} else {
			setInterval(function(){
				newHash = location.hash;
				frameHash = needFrame ? instance.fixFrame.contentWindow.location.hash : null;
				// handle iframe history
				if(needFrame && newHash.length && newHash !== frameHash && frameHash.length) {
					location.hash = frameHash;
				}
				// common handler
				if(oldHash != newHash) {
					// handle callbacks
					instance.makeCallbacks(newHash, oldHash);
					oldHash = newHash;
				}
			},delay);
		}
	},
	makeCallbacks: function() {
		for(var i = 0; i < this._handlers.length; i++) {
			this._handlers[i].apply(this, arguments);
		}
	},
	get: function() {
		return location.hash.substr(1);
	},
	set: function(text) {
		if(this.get() != text) {
			location.hash = text;
			if(this.fixFrame) {
				this.fixFrame.contentWindow.document.open();
				this.fixFrame.contentWindow.document.close();
				this.fixFrame.contentWindow.document.location.hash = text;
			}
		}
	},
	clear: function() {
		this.set('');
	},
	onChange: function(handler) {
		this._handlers.push(handler);
	}
}.init();