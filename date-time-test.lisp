(eval-when (:compile-toplevel :load-toplevel :execute)
  (asdf:oos 'asdf:load-op :simple-date-time)
  (asdf:oos 'asdf:load-op :stefil)
  (use-package :simple-date-time)
  (use-package :stefil))

(defsuite simple-date-time-test)

(in-suite simple-date-time-test)

(deftest test-week-of ()
  (is (= 2 (week-of (make-instance 'date-time :year 2009 :month 3 :day 17))))
  (is (= 4 (week-of (make-instance 'date-time :year 1973 :month 4 :day 26))))
  (is (= 5 (week-of (make-instance 'date-time :year 9999 :month 12 :day 31)))))

(deftest test-+ ()
  (is (date-time=
       (make-instance 'date-time :year 1973 :month 4 :day 26)
       (year+ (make-instance 'date-time :year 1972 :month 4 :day 26) 1)))
  (is (date-time=
       (make-instance 'date-time :year 1973 :month 4 :day 26)
       (year+ (make-instance 'date-time :year 1974 :month 4 :day 26) -1)))
  (is (date-time=
       (make-instance 'date-time :year 2005 :month 2 :day 28)
       (year+ (make-instance 'date-time :year 2004 :month 2 :day 29) 1)))
  (is (date-time=
       (make-instance 'date-time :year 2009 :month 2 :day 28)
       (month+ (make-instance 'date-time :year 2009 :month 3 :day 31) -1))))

(deftest universal-time ()
  (let ((universal-time (get-universal-time)))
    (multiple-value-bind (se mi ho da mo ye)
        (decode-universal-time universal-time)
      (let ((now (now)))
        (is (= ye (year-of now)))
        (is (= mo (month-of now)))
        (is (= da (day-of now)))
        (is (= ho (hour-of now)))
        (is (= mi (minute-of now)))
        (is (= se (second-of now)))
        (is (= universal-time (to-universal-time now)))))))

(deftest test-month+ ()
  (is (date= (make-date 2011 11 1) (month+ (make-date 2011 10 1) 1)))
  (is (date= (make-date 2011 12 1) (month+ (make-date 2011 11 1) 1)))
  (is (date= (make-date 2012  1 1) (month+ (make-date 2011 12 1) 1)))
  (is (date= (make-date 2012  2 1) (month+ (make-date 2012  1 1) 1)))
  (is (date= (make-date 2011 10 1) (month+ (make-date 2011 11 1) -1)))
  (is (date= (make-date 2011 11 1) (month+ (make-date 2011 12 1) -1)))
  (is (date= (make-date 2011 12 1) (month+ (make-date 2012  1 1) -1)))
  (is (date= (make-date 2012  1 1) (month+ (make-date 2012  2 1) -1))))

(simple-date-time-test)
