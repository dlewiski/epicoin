$(document).ready(function() {
  $("form#stress_survey").submit(function(event) {
    event.preventDefault();

    var userFactorsResponses = [];
    var userSymptomsResponses = [];

    $("input:checkbox[name=stress-factor]:checked").each(function(){
      var surveyResults = $(this).val();
      userFactorsResponses.push(surveyResults);
    });

    $("input:checkbox[name=health-symptoms]:checked").each(function(){
      var surveyResults = $(this).val();
      userSymptomsResponses.push(surveyResults);
    });
    if (userFactorsResponses.length === 6 && userSymptomsResponses.length === 5) {
      $("#stress_level").text("You might be dying.");
    } else if (userFactorsResponses.length >= 5 || userSymptomsResponses.length >= 4) {
      $("#stress_level").text("High stress");
    } else if (userFactorsResponses.length <= 2 && userSymptomsResponses.length <= 1) {
      $("#stress_level").text("Low stress");
    } else if (userFactorsResponses.length <= 4 && userSymptomsResponses.length <= 3) {
      $("#stress_level").text("Moderate stress");
    } else if (userFactorsResponses.length <= 6 && userSymptomsResponses.length <= 5) {
      $("#stress_level").text("High stress");
    } else if (userSymptomsResponses.length >= 4 && userFactorsResponses.length >= 2) {
      $("#stress_level").text("High stress");
    } else if (userSymptomsResponses.length >= 3 && userFactorsResponses.length >= 1) {
      $("#stress_level").text("Moderate stress");
    } else {
      $("#stress_level").text("Sorry we couldn't help. You should visit a doctor!");
    };

    $("#output").show();
  });
});
