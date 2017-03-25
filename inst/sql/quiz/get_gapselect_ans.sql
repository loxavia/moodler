SELECT

  -- Quiz/User/Attempt
  q.course AS 'course.id',
  cm.id AS 'quiz.id',
  quiza.userid AS 'user.id',
  quiza.id AS 'attempt.id',
  
  -- Question related  
  que.qtype AS 'question.type',  
  que.id AS 'question.id',
  quea.maxmark AS 'question.maxpoints.past',  # Je to třeba?
  
  -- Answer related
  queasd.name AS 'answer.data',
  queasd.VALUE AS 'users.answer',
  FROM_UNIXTIME(queas.timecreated) AS 'answer.time'

FROM [prefix]_quiz AS q
JOIN [prefix]_course_modules AS cm
  ON q.course = cm.course AND q.id = cm.instance
JOIN [prefix]_quiz_attempts AS quiza
  ON q.id = quiza.quiz
JOIN [prefix]_question_attempts AS quea
  ON quea.questionusageid = quiza.uniqueid
JOIN [prefix]_question AS que
  ON quea.questionid = que.id
JOIN [prefix]_question_attempt_steps AS queas
  ON queas.questionattemptid = quea.id
LEFT JOIN [prefix]_question_attempt_step_data AS queasd
  ON queasd.attemptstepid = queas.id

WHERE quiza.preview = 0 AND
      (queasd.name LIKE '_choiceorder%' OR queasd.name LIKE 'p%') AND
      que.qtype = 'gapselect' AND
      quiza.id IN ([attempt.id])

ORDER BY quiza.quiz, quiza.userid, quiza.id, quea.questionid;