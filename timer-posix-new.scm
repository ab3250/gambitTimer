(c-declare
#<<c-declare-end
  //;c header files

  //;c extern functions
  extern int timer_create(clockid_t clockid,
    struct sigevent *evp, timer_t *timerid);
  extern int timer_settime(timer_t timerid, int flags,
    const struct itimerspec *value, struct itimerspec *oldvalue);
  extern int timer_getoverrun(timer_t timerid);
  extern int timer_gettime(timer_t timerid, struct itimerspec *value);
  extern int timer_delete(timer_t timerid);
  unsigned int alarm(unsigned int seconds);
  //;
c-declare-end
)


(c-define-type sigh "__sighandler_t")
(c-define-type timevalue "___SCMOBJ")
(c-define-type timespec (struct "itimerspec"))


(define timer_create (c-lambda (int) int "timer_create"))
(define timer_settime (c-lambda (int) int "timer_settime"))
(define timer_getoverrun (c-lambda (int) int "timer_getoverrun"))
(define timer_gettime (c-lambda (int) int "timer_gettime"))
(define timer_delete (c-lambda (int) int "timer_delete"))




;(define  ws_sendframe_txt (c-lambda (int char-string bool) int "ws_sendframe_txt"))

;(define ws_start (c-lambda () void "ws_start" ))

;(c-define (onmessage fd msg size type) (int char-string unsigned-int64 int) void  "onmessage" "extern"
;  (ws_sendframe_txt gblFd (makeJSONString (knuth-shuffle deck)) false)  
;  (displayln (list 'frame 'recieved 'client fd)))

(import (scheme base)(scheme write))
  (define (timer_callback)
    (display "debug")
    (newline)
)
(define (main)
  (timer_init)
  (timer_set (make-timeval))
  (thread-sleep! 40)
)
(main)