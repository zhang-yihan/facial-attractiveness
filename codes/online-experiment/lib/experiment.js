/* define helper functions */
function saveData(sessionID, filedata){
   $.ajax({
      type:'post',
      cache: false,
      url: 'lib/save_data.php',
      data: {sessionID: sessionID, filedata: filedata}
   });
}

/* define experimental variables */
//var minimum_duration = 2; // defined in practice.js

/* define instructions block */
var instruction_page = {
  type: "text",
  text: "<p>Instructions of the experiment goes here...</p>" +
  "<p>Press any key to continue.</p>",
  timing_post_trial: 1000
};

/* practice and continue block */
var start_practice_page = {
  type: "text",
  cont_key: "p",
  text: "<br><p>Now, you will be presented with the <b>"+number_practice+"</b> practice problems.</p>" +
  "<p>Press &quot;<b>p</b>&quot; key to continue.</p>",
  timing_post_trial: 1000,
  data: { cont_key: "p" }
};

var skip_practice_page = {
  type: "text",
  cont_key: "i",
  text: "<br><p>Welcome back! Let's start the experiment right away.</p>" +
  "<p>Press &quot;<b>i</b>&quot; key to continue.</p>",
  timing_post_trial: 1000,
  data: { cont_key: "i" }
};

var start_main_task_page = {
  type: "text",
  cont_key: "o",
  text: "<br><p>Now, you will be presented with "+number_trial+" face images for ratings.</p>" +
  "<p>Press &quot;<b>o</b>&quot; key to continue.</p>",
  timing_post_trial: 1000,
  data: { cont_key: "o" }
};

var start_demo_survey_page = {
  type: "text",
  text: "<br><p>The problem solving is complete. On the next screen, " +
  "there are <b>"+number_survey+"</b> survey questions to complete before the experiment is finished.</p>" +
  "<p>Press any key to continue.</p>"
};

/* Set up experiment timeline */
var face_experiment = [];

// face_experiment.push(consent_block);
// face_experiment.push(instruction_page);

// face_experiment.push(start_practice_page);
// face_experiment.push(practice_block);

face_experiment.push(start_main_task_page);
face_experiment.push(treatment_block);

// face_experiment.push(start_demo_survey_page);
// face_experiment.push(survey_demo_block);
