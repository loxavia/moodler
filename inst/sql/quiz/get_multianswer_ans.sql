SELECT

  -- Attempt related
  quiza.id AS 'attempt.id',

  -- Question related
  que.id AS 'question.id',
  quea.maxmark AS 'question.maxpoints',
  quea.minfraction AS 'question.mingrade',
  
  -- Answer related
  queasd.name AS 'answer.data',
  queasd.VALUE AS 'answer.text',
  queas.fraction AS 'answer.percent',  
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
      (queasd.name LIKE 'sub%answer' OR queasd.name LIKE '_sub%order' OR queasd.name = '-comment') AND
      que.qtype = 'multianswer' AND
      quiza.id IN ([attempt.id])

ORDER BY quiza.quiz, quiza.userid, quiza.id, quea.questionid, queas.timecreated;