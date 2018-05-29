$(document).ready(function(){
  $(".hide-btn").click(function(newspaper){
    var target = $(newspaper.target);
    $(target).parents('.newspaper-wrapper').hide();
    var id = target.attr('id');
    var newspaperId = id.split('-')[1];
    var url = "/newspapers/" + newspaperId + "/hide";
    $.ajax({
      type: "GET",
      url: url
    })
  });
});
