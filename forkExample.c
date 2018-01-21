#include "stdio.h"
#include "stdlib.h"
#include "sys/types.h"
#include "unistd.h"
#include "signal.h"
void action(int dummy)
{
    printf("Switching\n");
}

int main(int argc, char const *argv[]) {
  pid_t pid = fork();
  int status;

  signal(SIGUSR1, action);
  signal(SIGUSR2, action);

  if(pid == 0){
    // printf("this is the child process\n");

    for (int i = 1; i <= 10; i+=2) {
      printf("In the child process %d\n",i );
      kill(getppid(), SIGUSR1);
      pause();
    }
  }
  else{
    // sleep(10);
    // printf("This is the parent process\n");
    pause();
    for (int i = 2; i <=10; i+=2) {
      printf("In the parent process %d\n",i );
      kill(pid, SIGUSR2);

      pause();
    }
  }
  return 0;
}
