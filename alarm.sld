;;;============================================================================
;;; File: "alarm.sld"
;;;============================================================================
;;; 

(define-library (alarm)
  (namespace "")
  (export
)
(begin


(define timer_set (c-lambda (timespec) int
#<<c-lambda-end
  timer_settime (gTimerid, 0, &___arg1, NULL);
  ___return (0);
c-lambda-end
))

(define make-timeval (c-lambda () timespec
#<<c-lambda-end
  struct itimerspec value; 
  value.it_value.tv_sec = 10;    
  value.it_value.tv_nsec = 0;   
  value.it_interval.tv_sec = 4;
  value.it_interval.tv_nsec = 0;
  
  ___return(value);
  //timer_settime (gTimerid, 0, &value, NULL);
c-lambda-end
))

))
