$(document).ready(function() {
  if($('form#new_word').length !== 0) {
    $('form#new_word').on('input', 'input[type=text]#word_body', function(ev) {
      var search_term = $(this).val();
      if(search_term.length > 1) {
        console.log($(this).val());
      }

    });
  }
});
