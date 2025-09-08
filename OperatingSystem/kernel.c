// kernel.c for a simple Operating System
// Made for CEG4350 in 2025
// initializes and manages multiple user-level processes

#include "./io.h"
#include "./multitasking.h"
#include "./irq.h"
#include "./isr.h"

void prockernel();
void proc_a();
void proc_b();
void proc_c();
void proc_d();

void proca();
void procb();
void procc();
void procd();
void proce();


int main() 
{
	// Clear the screen
	clearscreen();

	// Initialize our keyboard
	initkeymap();

	// Initialize interrupts
	idt_install();
    isrs_install();
    irq_install();

	// Start executing the kernel process
	startkernel(prockernel);
	
	return 0;
}

void prockernel()
{

	
	printf("Kernel Process Starting...\n");

	// Create the user processes
	createproc(proca, (void *) 0x10000);
	createproc(procb, (void *) 0x12000);
	createproc(procc, (void *) 0x13000);
	createproc(procd, (void *) 0x14000);
	createproc(proce, (void *) 0x15000);


	// Count how many processes are ready to run
	int userprocs = ready_process_count();
	
	// As long as there is 1 user process that is ready, yield to it so it can run
	while(userprocs > 0)
	{
	
		// Yield to the user process
		yield();
		
		//printf("Kernel Process Resumed\n");

		// Count the remaining ready processes (if any)
		userprocs = ready_process_count();
	}

	printf("\nKernel Process Exiting...");

	exit(); 
}

// The user processes for Project 3
void proc_a()
{
	printf("User Process A Started\n");

	exit();
}

void proc_b(){

	printf("User Process B Started\n");

	yield();

	printf("User Process B Resumed\n");

	exit();

}

void proc_c(){

	printf("User Process C Started\n");

	yield();

	printf("User Process CResumed\n");

	yield();

	printf("User Process C Resumed\n");

	exit();

}

void proc_d(){

	printf("User Process D Started\n");

	yield();

	printf("User Process D Resumed \n");

	yield();

	printf("User Process D Resumed\n");

	yield();

	printf("User Process D Resumed\n");

	exit();

}

// The user processes for Project 4 
void proca(){

	printf("A");

	exit();
}

void procb(){

	printf("B");

	yield();

	printf("B");

	exit();

}

void procc(){

	printf("C");

	yield();

	printf("C");

	yield();

	printf("C");

	yield();

	printf("C");

	exit();

}

void procd() {

	printf("D");

	yield();

	printf("D");

	yield();

	printf("D");

	exit();
}

void proce(){

	printf("E");

	yield();

	printf("E");

	exit();

}

//Project 3 (previous project) prockernel function 

/*void prockernel()
{
	// Create the user processes
	createproc(proc_a, (void *) 0x10000);
	createproc(proc_b, (void *) 0x12000);
	createproc(proc_c, (void *) 0x13000);
	createproc(proc_d, (void *) 0x14000);


	// Count how many processes are ready to run
	int userprocs = ready_process_count();

	printf("Kernel Process Started\n");
	
	// As long as there is 1 user process that is ready, yield to it so it can run
	while(userprocs > 0)
	{
	
		// Yield to the user process
		yield();
		
		printf("Kernel Process Resumed\n");

		// Count the remaining ready processes (if any)
		userprocs = ready_process_count();
	}

	printf("Kernel Process Terminated\n");
}*/
