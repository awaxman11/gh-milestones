$( document ).ready(function() {
  if ($('table.milestone')) {
    $progressBars = $('.indicating.progress')
    console.log(_.size($progressBars));
    rows = []
    _.each($progressBars, function(row){
      if ($(row).data('milestone')) {
        rows.push("#example"+$(row).data('milestone'))
        console.log(rows);
      }
    });
  }

  $(rows)
    .progress()
  ;
});

