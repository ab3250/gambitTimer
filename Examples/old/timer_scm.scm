(import (scheme base)(scheme write))

(c-declare
#<<c-declare-end
void scm_timer_callback(int);
c-declare-end
)
(c-define (scm_timer_callback sig) (int) void  "scm_timer_callback" "extern"
  (display "debug")
  (newline)
)


  (timer_init)

  (thread-sleep! 40)
