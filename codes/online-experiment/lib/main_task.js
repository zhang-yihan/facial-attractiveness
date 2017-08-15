/* === main task === */

var number_trial = 6;
var scale_with_label = ["<p>1</p><p>Not Attractive</p>","2","3","4","5","6","7","8","<p>9</p><p>Very Attractive</p>"];
var scale_no_label = ["1","2","3","4","5","6","7","8","9"];

// define stimuli
var stimuli = [];
for (i = 0; i < number_trial; i++) {
  stimuli[i] = "images/wilma/wilma-" + (i+1) + "_oval.jpg"; // stimID=[1,...,n]
}
// randomize stimulus order
var reorder = [];
for (i = 0; i < number_trial; ++i) reorder[i] = i; // [0,1,2,...,n-1]
shuffle(reorder);
function shuffle(a) {
  var j, x, i;
  for (i = a.length; i; i--) {
    j = Math.floor(Math.random() * i);
    x = a[i - 1];
    a[i - 1] = a[j];
    a[j] = x;
  }
}

// define trials
var treatment_trials = [];
for (i = 0; i < number_trial; i++) {
  treatment_trials[2 * i] = {
    type: "multi-stim-multi-response",
    stimuli: ["<img class='face' src=" + stimuli[reorder[i]] + " alt='face image'/>",
    "<p class='fixation'>&#43;</p>"],
    is_html: [true, true],
    prompt: "Press S/L to indicate race category.",
    choices: [[83,76]], // S or L
    timing_stim: [3000,500],
    timing_response: 3500,
    timing_post_trial: 0,
    data: { status: "treatment", stage: "categorization", stimID: reorder[i]+1 }
  };
  treatment_trials[2 * i + 1] = {
    type: "single-stim",
    stimulus: "<p class='fixation'>&#43;</p>",
    is_html: true,
    prompt: "Press a number 1-9 to indicate how attractive the face is.",
    choices: [49,50,51,52,53,54,55,56,57], // 1-9
    // timing_stim: -1,
    // timing_post_trial: 1000,
    data: { status: "treatment", stage: "rating", stimID: reorder[i]+1 }
  };
}

var treatment_block = {
  timeline: treatment_trials,
};
