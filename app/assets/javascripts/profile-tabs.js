$( document ).ready(function() {
  $(".tab").on("click", function(e){
    e.preventDefault();
    $('a').removeClass('active');
    $(this).addClass('active');
    $('.tab-content').addClass('hidden');
    $($(this).attr('data-target')).removeClass('hidden');
  });

});

