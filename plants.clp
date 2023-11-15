(deffunction ask-question (?question)
   (printout t ?question)
   (bind ?answer (read))
   (if (lexemep ?answer) 
       then (bind ?answer (lowcase ?answer)))
   ?answer)


;;;*
;;;* QUERY RULES *
;;;*

(defrule determine-burn-surface ""
   (has-holes no)
   (has-wilting no)
   (has-curly-leaves no)
   (has-leaf-color-change no)
   (not (has-burn-surface ?))
    =>
    (assert (has-burn-surface (ask-question"does plant have burn-surface?? (yes/no) ")))
)

(defrule determine-holes ""
   (has-wilting no)
   (has-leaf-color-change no)
   (has-curly-leaves no)
   (not (has-holes ?))
    =>
    (assert (has-holes (ask-question"does plant have holes?? (yes/no) ")))
)

(defrule determine-curly-leaves ""
   (has-wilting no)
   (has-leaf-color-change no)
   (not (has-curly-leaves ?))
    =>
    (assert (has-curly-leaves (ask-question"does plant have curly-leaves?? (yes/no) ")))
)

(defrule determine-sunlight ""
   (has-wilting no)
   (has-leaf-color-change yes)
   (has-leaf-color yellowleaves)
   (not (has-sunlight ?))
    =>
    (assert (has-sunlight (ask-question"sunlight density?? (low/normal) ")))
)
(defrule determine-leaf-color""
   (has-wilting no)
   (has-leaf-color-change yes)
   (not (has-leaf-color ?))
    =>
    (assert (has-leaf-color (ask-question" what type change?? (yellowleaves/brownspots)")))
)

(defrule determine-leaf-color-change""
   (has-wilting no)
   (not (has-leaf-color-change ?))
    =>
    (assert (has-leaf-color-change (ask-question"does the leaf color changed?? (yes/no)")))
)

(defrule determine-soil-condition""
   (has-wilting yes)
   (has-sunlight-density normal)
   (not (has-soil-condition ?))
    =>
    (assert (has-soil-condition (ask-question"what is the soil-condition?? (dry/wet/normal) ")))
)

(defrule determine-sunlight-density ""
   (has-wilting yes)
   (not (has-sunlight-density ?))
    =>
    (assert (has-sunlight-density (ask-question"sunlight density?? (high/normal) ")))
)

(defrule determine-wilting ""
   (not (has-wilting ?))
    =>
    (assert (has-wilting (ask-question"deos the plant wilting?? (yes/no) ")))
)


;;;**
;;;* CONCLUSION RULES *
;;;**
(defrule assume-over-sunlight ""
   (has-wilting yes)
   (has-sunlight-density high)
   
   =>
   (printout t crlf crlf)
   (printout t "Based on your inputs the plant facing a over sunlight problem so protect the plants from high sunlight ." crlf)
   (halt))

(defrule assume-normal-sunlight ""
   (has-wilting yes)
   (has-sunlight-density normal)
   (has-soil-condition normal)
   =>
   (printout t crlf crlf)
   (printout t "Based on your inputs the plant facing a root damage to overcome this problem Mulching the plants ." crlf)
   (halt))

(defrule assume-low-watering ""
   (has-wilting yes)
   (has-sunlight-density normal)
   (has-soil-condition dry)
   =>
   (printout t crlf crlf)
   (printout t "Based on your inputs the plant facing low watering so water the plants." crlf)
   (halt))


(defrule assume-over-watering ""
   (has-wilting yes)
   (has-sunlight-density normal)
   (has-soil-condition wet)
   =>
   (printout t crlf crlf)
   (printout t "Based on your input the plant facing over watering so stop watering." crlf)
   (halt))

(defrule assume-insufficient-sunlight ""
   (has-wilting no)
   (has-leaf-color-change yes)
   (has-leaf-color yellowleaves)
   (has-sunlight low)
   =>
   (printout t crlf crlf)
   (printout t "Based on your inputs the plant facing insufficient sunlight so give sunlight ." crlf)
   (halt))

(defrule assume-nitrogen-deficiency ""
   (has-wilting no)
   (has-leaf-color-change yes)
   (has-leaf-color yellowleaves)
   (has-sunlight normal)
   =>
   (printout t crlf crlf)
   (printout t "Based on your inputs the plant facing nitrogen deficiency so fertilize the plant with nitrogen base fertilizers." crlf)
   (halt))

(defrule assume-fungal-infection ""
   (has-wilting no)
   (has-leaf-color-change yes)
   (has-leaf-color brownspots)
   =>
   (printout t crlf crlf)
   (printout t "Based on your inputs the plant facing fungal infection so Remove affected plant parts and fertilize ." crlf)
   (halt))

(defrule assume-over-fertilization ""
   (has-wilting no)
   (has-leaf-color-change no)
   (has-curly-leaves yes)
   =>
   (printout t crlf crlf)
   (printout t "Based on your inputs the plant facing over fertilization so limit the fertilizer ." crlf)
   (halt))

(defrule assume-insects-attack ""
   (has-wilting no)
   (has-leaf-color-change no)
   (has-curly-leaves no)
   (has-holes yes)
   =>
   (printout t crlf crlf)
   (printout t "Based on your inputs the plant facing insects attack so use proper pesticides  ." crlf)
   (halt))

(defrule assume-phosphorus-deficiency ""
   (has-wilting no)
   (has-leaf-color-change no)
   (has-curly-leaves no)
   (has-holes no)
   (has-burn-surface yes)
   =>
   (printout t crlf crlf)
   (printout t "Based on your inputs the plant facing phosphorus deficiency so fertilize the pkant with phosphorus base fertilizers  ." crlf)
   (halt))

(defrule assume-no-phosphorus-deficiency ""
   (has-wilting no)
   (has-leaf-color-change no)
   (has-curly-leaves no)
   (has-holes no)
   (has-burn-surface no)
   =>
   (printout t crlf crlf)
   (printout t "meet the agriculture specialist  ." crlf)
   (halt))


;;;**
;;;* STARTUP AND CONCLUSION RULES *
;;;**

(defrule system-banner ""
  (declare (salience 10))
  =>
  (printout t crlf crlf)
  (printout t "plants desease Expert System")
  (printout t crlf crlf)
)


