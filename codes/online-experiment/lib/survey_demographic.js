var number_survey = 2;
var demo_question = [];

demo_question[0] = {
  type: "survey-text",
  preamble: "<br><p style='font-size:1.5em;line-height:2em'><strong>Demographics Questionnaire (1/5)</strong></p>",
  questions: ["<br><br>What year were you born? (optional)"],
  data: { status: "survey_demo1" }
};

demo_question[1] = {
  type: "survey-multi-choice",
  preamble: "<br><p style='font-size:1.5em;line-height:2em'><strong>Demographics Questionnaire (2/5)</strong></p>",
  required: [true],
  questions: ["<br><br>What is your gender?"],
  options: [["Male", "Female", "Other", "Prefer Not to Answer"]],
  data: { status: "survey_demo2" }
};
//
// demo_question[2] = {
//   type: "survey-multi-choice",
//   required: [true],
//   preamble: "<br><p style='font-size:1.5em;line-height:2em'><strong>Demographics Questionnaire (3/5)</strong></p>",
//   questions: ["<br><br>What ethnicity do you primarily identify with?"],
//   options: [["African / Black American", "American Native", "Asian / Asian American",
//     "Caucasian / White American", "Chicano / Hispanic / Latino American",
//     "Multiethnic", "Other", "Prefer Not to Answer"]],
//     data: { status: "survey_demo3" }
// };
//
// demo_question[3] = {
//   type: "survey-multi-choice",
//   preamble: "<br><p style='font-size:1.5em;line-height:2em'><strong>Demographics Questionnaire (4/5)</strong></p>",
//   required: [true],
//   questions: ["<br><br>What is your highest level of education attained?"],
//   options: [["Less than high school", "High school diploma/GED", "Some college",
//     "Bachelor's degree", "Advanced degree", "Prefer Not to Answer"]],
//     data: { status: "survey_demo4" }
// };
//
// demo_question[4] = {
//   type: "survey-text",
//   preamble: "<br><p style='font-size:1.5em;line-height:2em'><strong>Demographics Questionnaire (5/5)</strong></p>",
//   questions: ["<br><br>What is your ZIP code? (optional)"],
//   data: { status: "survey_demo5" }
// };
//
// demo_question[5] = {
//   type: "survey-text",
//   preamble: "<br><p style='font-size:1.5em;line-height:2em'><strong>Suggestions and Feedback</strong></p>",
//   rows: [5],
//   questions: ["<br><br>We highly value your participation and feedback. Do you have suggestions regarding this study or how your experience in this study could have been improved? (optional)"],
//   data: { status: "survey_suggestion" }
// };

var survey_demo_block = {
  timeline: demo_question
};
