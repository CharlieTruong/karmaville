// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require_tree .
$(document).ready(function(){

  if(getUrlVars()["page"] === "1"){
    $("#prev").addClass("disabled");
    $("#prev a").attr("href","#");
    $('#prev a').bind('click', disableLink)
  }

  if(getUrlVars()["page"] === String($("#next").data("last"))){
    $("#next").addClass("disabled");
    $('#next a').bind('click', disableLink)
  }


  $("#"+getUrlVars()["page"]).addClass("active");


});

function getUrlVars()
{
    var vars = [], hash;
    var hashes = window.location.href.slice(window.location.href.indexOf('?') + 1).split('&');
    for(var i = 0; i < hashes.length; i++)
    {
        hash = hashes[i].split('=');
        vars.push(hash[0]);
        vars[hash[0]] = hash[1];
    }
    return vars;
}

function disableLink(e) {
    e.preventDefault();
    return false;
}

