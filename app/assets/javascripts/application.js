// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery3
//= require popper
//= require bootstrap-sprockets
//= require rails-ujs
//= require activestorage
//= require jquery.jscroll.min.js
//= require turbolinks
//= require_tree .

// 無限スクロール

// $(function() {
//   $('.jscroll').jscroll({
//     contentSelector: '.post',
//     nextSelector: 'span.next a'
//   });
// });

// $(document).on('turbolinks:load',function() {
//   $('.jscroll').jscroll;
//     contentSelector: '.post'
//     nextSelector: "span.next a"
// });

// $(function() {
//   $('.jscroll').jscroll;
//     contentSelector: '.post'
//     nextSelector: "span.next a"
// });

// トップページアニメーション
$(document).on('turbolinks:load',function(){
  setTimeout(function(){
    $('.start p').fadeIn(1600);
  },500);
  setTimeout(function(){
    $('.start').fadeOut(500);
  },2500);
});
// 画像切り替え
$(document).on('turbolinks:load',function(){
  // 初期画像の表示
  let index = 0;
  $('.img').eq(index).addClass('current-img');
  // 一定時間ごとに特定の処理を繰り返す
  setInterval(function(){
    // 非表示
    $('.img').eq(index).removeClass('current-img');
    // 画像の最後判定
    if(index == $('.img').length - 1){
      index = 0;
    }else{
      index++;
    }
    // 表示
    $('.img').eq(index).addClass('current-img');
    // 切り替わりの速さ
  }, 3000);
});


// スクロール時の文字
$(function(){
  $(window).scroll(function (){
    $("#scrollanime").each(function(){
      var imgPos = $(this).offset().top;
      var scroll = $(window).scrollTop();
      var windowHeight = $(window).height();
      if (scroll > imgPos - windowHeight + windowHeight/5){
        $(this).addClass("fade_on");
      } else {
        $(this).removeClass("fade_on");
      }
    });
    $("#scrollanime2").each(function(){
      var imgPos = $(this).offset().top;
      var scroll = $(window).scrollTop();
      var windowHeight = $(window).height();
      if (scroll > imgPos - windowHeight + windowHeight/5){
        $(this).addClass("fade_on");
      } else {
        $(this).removeClass("fade_on");
      }
    });
    $("#scrollanime3").each(function(){
      var imgPos = $(this).offset().top;
      var scroll = $(window).scrollTop();
      var windowHeight = $(window).height();
      if (scroll > imgPos - windowHeight + windowHeight/5){
        $(this).addClass("fade_on");
      } else {
        $(this).removeClass("fade_on");
      }
    });
    $("#scrollanime4").each(function(){
      var imgPos = $(this).offset().top;
      var scroll = $(window).scrollTop();
      var windowHeight = $(window).height();
      if (scroll > imgPos - windowHeight + windowHeight/5){
        $(this).addClass("fade_on");
      } else {
        $(this).removeClass("fade_on");
      }
    });
    $("#scrollanime5").each(function(){
      var imgPos = $(this).offset().top;
      var scroll = $(window).scrollTop();
      var windowHeight = $(window).height();
      if (scroll > imgPos - windowHeight + windowHeight/5){
        $(this).addClass("fade_on");
      } else {
        $(this).removeClass("fade_on");
      }
    });
  });
});

