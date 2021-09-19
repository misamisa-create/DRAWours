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
//= require jquery
//= require turbolinks
//= require_tree .

// トップページアニメーション
$(function(){
  setTimeout(function(){
    $('.start p').fadeIn(1600);
  },500);
  setTimeout(function(){
    $('.start').fadeOut(500);
  },2500);
})

$(function(){
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

