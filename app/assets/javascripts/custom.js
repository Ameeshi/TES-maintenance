
jQuery(document).on("turbolinks:load", function () {
    $(".clickable-row").click(function() {
        window.location = $(this).data("href");
    });
});

jQuery(document).on("turbolinks:load", function () {
  $('input.input-material').each(function () {
    var val = $(this).val().trim();
    if (val != ''){
      $(this).siblings('.label-material').addClass('active');
    }
  });
});