// This is for material dropdowns
jQuery(document).on("turbolinks:load", function () {
    $('select').material_select();
});

// This is for clickable rows
jQuery(document).on("turbolinks:load", function () {
    $(".clickable-row").click(function() {
        window.location = $(this).data("href");
    });
});

// This is so material labels activate
jQuery(document).on("turbolinks:load", function () {
  $('input.input-material').each(function () {
    var val = $(this).val().trim();
    if (val != ''){
      $(this).siblings('.label-material').addClass('active');
    }
  });
});

