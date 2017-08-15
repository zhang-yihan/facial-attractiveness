/* === practice problems === */

var number_practice = 2;
var scale_with_label = ["<p>1</p><p>Not Attractive</p>","2","3","4","5","6","7","8","<p>9</p><p>Very Attractive</p>"];
var scale_no_label = ["1","2","3","4","5","6","7","8","9"];

// define practice stimuli
var practice_stimuli = [];
for (i = 0; i < number_practice; i++) {
    practice_stimuli[i] = "images/wilma/wilma-" + (i+1) + "_oval.jpg";
}

// define practice trials
var practice = [];
practice[0] = {
  type: "multi-stim-multi-response",
  stimuli: ["<img class='face' src=" + practice_stimuli[0] + " alt='face image'/>",
  "<p class='fixation'>&#43;</p>"],
  is_html: [true, true],
  prompt: "Press S/L to indicate race category.",
  choices: [[83,76]], // S or L
  timing_stim: [3000,500],
  timing_response: 3500,
  timing_post_trial: 0,
  data: { status: "practice", stage: "categorization", stimID: 999 }
};
practice[1] = {
  type: "single-stim",
  stimulus: "<p class='fixation'>&#43;</p>",
  is_html: true,
  prompt: "Press a number 1-9 to indicate how attractive the face is.",
  choices: [49,50,51,52,53,54,55,56,57], // 1-9
  // timing_stim: -1,
  // timing_post_trial: 1000,
  data: { status: "practice", stage: "rating", stimID: 999 }
};

var practice_block = {
  timeline: practice
};
