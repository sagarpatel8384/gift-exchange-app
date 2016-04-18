$(document).ready(function() {
  $('#match-names').on('click', function(event) {
    event.preventDefault();
    var inputs = $(':input').serializeArray();
    var results = [];
    $.each(inputs, function(index, item) {
      var name = item.value;
      if (name && name !== "✓") {
        results.push(name);
      }
    });

    $.ajax({
      method: 'GET',
      url: '/match',
      data: { users: results }
    }).then(function(data) {
      $('#full-width-head').hide();
      $('.modal-body').append(data.htmlString);
    })
  })
})
