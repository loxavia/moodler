SELECT 

  cm.course AS 'course.id',
  s.section AS 'module.section',
  s.name AS 'section.name',
  m.name AS 'module.type',
  cm.id AS 'module.id',              # = cmid - používá se pak v dotazech k jednotlivým modulů (nyní quiz) 
  cm.instance AS 'module.instance',  # = id - přes id se napojuje na názvy modulů 
                                     # (teoreticky by pak šlo všude pracovat jen s id, cmid ale může být praktický v tom, že ho pak vidím v URL)
  
  # celý následující SELECT zřejmě samzat a místo toho opakovaně volat upravený get_modules_names
  # a nasledně to ponapojovat na výstup tohoto dotazu přes id modulů --- nebo je lepší řešení?
  (SELECT module.name FROM mdl_quiz AS module
    WHERE cm.course = module.course AND 
    cm.instance = module.id AND 
    m.name = 'quiz') AS 'module.name',
    
    
  m.visible AS 'module.visibility'  # možná také není třeba


FROM mdl_course_modules AS cm
JOIN mdl_modules AS m ON cm.module = m.id
JOIN mdl_course_sections AS s ON s.id = cm.section   # řádek lze smazat, není-i třeba

WHERE cm.course IN (4124)  # misto konkrétního čísla lze vložit i seznam oddělený čárkou

ORDER BY cm.course, cm.section;

