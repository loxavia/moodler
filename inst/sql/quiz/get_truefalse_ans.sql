SELECT

  -- Attempt related
  quiza.id AS 'attempt.id',

  -- Question related
  que.id AS 'question.id',
  quea.maxmark AS 'question.maxpoints',
  quea.minfraction AS 'question.mingrade',

  -- Answer related
  CASE queasd.VALUE WHEN 0 THEN 'False' ELSE 'True' END AS 'answer.text', # Tj. co uživatel zvybral jako odpověď.
  FROM_UNIXTIME(queas.timecreated) AS 'answer.time'

FROM [prefix]quiz_attempts AS quiza
JOIN [prefix]question_attempts AS quea
  ON quea.questionusageid = quiza.uniqueid
JOIN [prefix]question AS que
  ON quea.questionid = que.id
JOIN [prefix]question_attempt_steps AS queas
  ON queas.questionattemptid = quea.id
JOIN [prefix]question_attempt_step_data AS queasd
  ON queasd.attemptstepid = queas.id

WHERE quiza.preview = 0 AND
      queasd.name = 'answer' AND
      que.qtype = 'truefalse' AND
      quiza.id IN ([attempt.id])

ORDER BY quiza.quiz, quiza.userid, quiza.id, quea.questionid, queas.timecreated;
