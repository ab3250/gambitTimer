#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <signal.h>
#include <unistd.h>

/*
 *  int timer_create(clockid_t clockid,
 *      struct sigevent *evp, timer_t *timerid);
 *  int timer_settime(timer_t timerid, int flags,
 *      const struct itimerspec *value, struct itimerspec *oldvalue);
 *  int timer_getoverrun(timer_t timerid);
 *  int timer_gettime(timer_t timerid, struct itimerspec *value);
 *  int timer_delete(timer_t timerid);
 *  typedef void (*__sighandler_t) (int);
 * 
 * 
 */
// extern void scm_timer_callback(int);
// extern void timer_init (void);
// extern void makeTimeval (void);
// static timer_t gTimerid;

//struct itimerspec makeTimeval (void);
struct itimerspec getTimeVal(void);

#define TIMER_SIG SIGRTMAX          /* Our timer notification signal */

static void handler(int sig, siginfo_t *si, void *uc)
{

    timer_t *tidptr;

    tidptr = si->si_value.sival_ptr;
   
    /* UNSAFE: This handler uses non-async-signal-safe functions
       (printf(); see Section 21.1.2) */

    printf(" Got signal %d\n", sig);

}

int main(void)
{
    //struct itimerspec ts;
    struct sigaction  sa;
    struct sigevent   sev;
    timer_t tmr;

    //
      //  struct itimerspec ts = getTimeVal();
        //ts.it_value.tv_sec = 10;    
        //ts.it_value.tv_nsec = 0;   
        //ts.it_interval.tv_sec = 4;
        //ts.it_interval.tv_nsec = 0;  
    //
    
  

   // tidlist = calloc(argc - 1, sizeof(timer_t));
    //if (tidlist == NULL)
     //  printf("malloc");

    /* Establish handler for notification signal */

    sa.sa_flags = SA_SIGINFO;
    sa.sa_sigaction = handler;
    sigemptyset(&sa.sa_mask);

    if (sigaction(TIMER_SIG, &sa, NULL) == -1)
        printf("sigaction");


    /* Create and start one timer for each command-line argument */

    sev.sigev_notify = SIGEV_SIGNAL;    /* Notify via signal */
    sev.sigev_signo = TIMER_SIG;        /* Notify using this signal */
    sev.sigev_value.sival_ptr = &tmr;                 /* Allows handler to get ID of this timer */

    if (timer_create(CLOCK_REALTIME, &sev, &tmr) == -1)
        printf("timer_create");
        printf("Timer ID: %ld\n", (long) tmr);

   if (timer_settime(tmr, 0, &ts, NULL) == -1)
        printf("timer_settime");
    
    //sleep(25);
    //timer_delete(tmr);

    for (;;);                            /* Wait for incoming timer signals */
      //  pause();
}

struct itimerspec getTimeVal(void){
        struct itimerspec ts; 
        ts.it_value.tv_sec = 5;    
        ts.it_value.tv_nsec = 0;   
        ts.it_interval.tv_sec = 1;
        ts.it_interval.tv_nsec = 0;  
        return(ts);
}







