$(document).on("turbolinks:load", function () {
  $("#edit-modal").on("ajax:success", function (e, data, status, xhr) {
    $(this).html(data);
  });
});
