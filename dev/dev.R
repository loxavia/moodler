# Explore ----
# ============

source("dev/conn.R")
q = get_quiz(.con, 101)
qd = get_module_data(q)

sa = moodler:::get_question_ans(
  conn = .con,
  question.type = "shortanswer",
  attempt.id = qd$attempts$attempt.id,
  prefix = "mdl_")

qk = quiz_key(qd, complete = TRUE)
qi = quiz_items(qd)

DBI::dbGetQuery(.con, 'SHOW VARIABLES WHERE Variable_Name LIKE "%dir"')

# Module data fetching ----
# =========================

source("dev/conn.R")
q = get_quiz(.con, 73)
md = get_module_data(q, distractors = TRUE)
get_module_data(q, question.type = c("tre", "tri"))
get_module_data(q, question.type = "truefalse")

q = get_quiz(.con, 78)
mc1 = get_module_data(q, question.type = "multichoice_one")
mc1 = get_module_data(q, attempt = c(2536, 2531, 1))
mc1 = get_module_data(q, attempt = 0)

mc0 = get_module_data(q, question.type = "multichoice_multiple")

# Item-level data ----
# ====================

source("dev/conn.R")
q = get_quiz(.con, 74)
a = moodler:::get_question_ans(
  conn = .con,
  question.type = "allquestions",
  attempt.id = q$attempts$attempt.id
)

# TF, SA ----
# ===========

source("dev/conn.R")
q = get_quiz(.con, 40)
tf40 = moodler:::get_truefalse(
  conn = q$connection,
  attempt.id = q$attempts$attempt.id
)

source("dev/conn.R")
q = get_quiz(.con, 79)
sa = moodler:::get_shortanswer(
  conn = q$connection,
  quiz.id = q$settings$quiz.id,
  attempt.id = 2534:2535
)

# MC 1 ----
# =========

source("dev/conn.R")
q = get_quiz(.con, 80)
mc1 = moodler:::get_multichoice_one(
  conn = q$connection,
  attempt.id = q$attempts$attempt.id
)

# MC 0 ----
# =========

source("dev/conn.R")
q = get_quiz(.con, 80)
mc0 = moodler:::get_multichoice_multiple(
  conn = q$connection,
  quiz.id = q$settings$quiz.id,
  attempt.id = q$attempts$attempt.id
)

# Vikings ----
# ============

source("dev/conn.R")

vik = get_quiz(conn = .con, quiz.id = 79)
qst = c("multichoice_multiple", "multichoice_one", "shortanswer", "truefalse")
dat = get_module_data(vik, question.type = NULL)

mdl = extract_items(dat, marks = "moodle")
bin = extract_items(dat, marks = "binary")
cat = quiz_items(dat, question.type = "multichoice_one")
key = extract_key(dat)
