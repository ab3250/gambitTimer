(c-declare #<<c-declare-end
//;c header files
#include "gambit.h"
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <signal.h>
#include <sys/time.h>
#include <unistd.h>

//;c function definition
void timer_callback(int);
int timer_set();
int timer_init();
unsigned int alarm(unsigned int seconds);
void scm_timer_callback(void);

//;c global variables
static timer_t gTimerid;

void timer_callback(int signum){	
  scm_timer_callback();
}

c-declare-end
)

(c-define-type sigh "__sighandler_t")
(c-define-type timevalue "___SCMOBJ")
(c-define-type timespec (struct "itimerspec"))

(c-define (scm_timer_callback) () void "scm_timer_callback" "extern"
          (timer_callback))

(define timer_init (c-lambda () void
#<<c-lambda-end
  signal(SIGALRM, timer_callback);
  timer_create (CLOCK_REALTIME, NULL, &gTimerid);
c-lambda-end
))

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