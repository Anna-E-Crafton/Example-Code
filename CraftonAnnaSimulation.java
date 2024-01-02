//Anna Crafton
//3/23/2022
//CraftonAnnaSimulation
//grocery store simulation to determine how many of 12 lanes should be express lanes.

package craftonannasimulation;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.PriorityQueue;
import java.util.Scanner; 

//Driver and methods to intilize ques 
public class CraftonAnnaSimulation {

    //make logFile
    static File newLogFile(String fileName){
 
    try {
        File file = new File(fileName);
        if(file.createNewFile()){
 
        System.out.println(fileName + " created");
         return file;
    } 
 
    }
    catch(IOException e){
         
         System.out.println("file not created or doesn't exist");
         e.printStackTrace();
    }
 
        File error = new File(fileName);
        return error;
 }
    
    
    //write a additinal string to the file
    static void writeToFile(File file, String text){
        
        text += "\n";
    
        try{
            FileWriter writer = new FileWriter(file,true);
            writer.write(text);
            writer.close();
            }
        
        catch(IOException e) {
        System.out.println("couldn't write to file");
        e.printStackTrace();
        }
    
    
    }
    
    
    //initilizes a ArrayList of shoppers from a file
    public static ArrayList <Shopper> readData(String filename) throws FileNotFoundException{
      
    ArrayList <Shopper> sendBack = new ArrayList <Shopper> ();
    String input; 
    Shopper shopper;
    ArrayList <String> strings = new ArrayList <String> ();
       
       Scanner scanner = new Scanner (new File(filename));
       scanner.useDelimiter("   |\\n");
       
       while(scanner.hasNext() == true) {
         
           input = scanner.next();
           strings.add(input);
           
       }
        
       //uses iterator to loop through string list and assign each to the correct values
       Iterator iter = strings.iterator();
       int index = 0;
       int i = 0;
       double timeArived;
       double numItems;
       double timePerItem;
       int id = 0;
       
       while(iter.hasNext()){
           
           if(index < strings.size()){
           
           if(iter.hasNext() == true){
               
            //spilit string into 3 doubles and assign to variables to make shopper
            String str = strings.get(index);
            String doubles[] = str.split("\t",0);
            
            timeArived = Double.valueOf(doubles[0]);
            numItems = Double.valueOf(doubles[1]);
            timePerItem = Double.valueOf(doubles[2]);
            
            shopper = new Shopper(timeArived, numItems, timePerItem, id);
     
            sendBack.add(shopper);
     
            id++;
            index++;
             i++;
           }
        }
        else{ return sendBack;
           
        }
        }
    
    return sendBack; 

    }
    
    
    //initilizes a ArrayList of Events for arrival times
    public static PriorityQueue <Event> getArrival(ArrayList <Shopper> shoppers){
    
    PriorityQueue <Event> sendBack = new PriorityQueue();
    
    ArrivalEvent event = new ArrivalEvent();
    
    for(Shopper i: shoppers){
    
    event = new ArrivalEvent();
    event.setTime(i.getTimeArrived());
    event.setShopper(i);
    sendBack.add(event);
    
    }
    
    return sendBack;
    
    }
    
    
    //makes an arraylist of lanes with numExpress express lanes 
    public static ArrayList <Lane> makeLanes(int numExpress, int totalLanes){
    
    ArrayList <Lane> sendBack = new ArrayList();
    
    if(numExpress > 0){
    
    for(int i = 0; i < numExpress; i++){
    
        sendBack.add(new ExpressLane());
   }
    }
    
    for(int j = numExpress; j < totalLanes; j++){
    
        sendBack.add(new Lane());
    }
    
    
    return sendBack;
    
    }
    
    
    //actual simulation of store with numExpress Express Lanes
    public static double runSimulation(int numExpress, int totalLanes) throws FileNotFoundException{
    
     
        //get shoppers from file, get list of ArivalEvents
        ArrayList shoppers = readData("arrival.txt");
        PriorityQueue <Event> events = getArrival(shoppers);
        Event currentEvent;
        Event newEvent;
        
        //makes lanes
        ArrayList <Lane> lanes = makeLanes(numExpress, totalLanes);
        int shortestLine = 30000;
        int bestLane = -1;
        double waitTime = 0; 
        double numShoppers = 0;
        double avgWait = 0;
        int numEvents = 0; 
        String write;
        int numExpressShoppers = 0;
        int numExpressForLoop = numExpress;
        
        //make new logfile
        String fileName = "LogFile.txt";
        File file = newLogFile(fileName);
        writeToFile(file, "\nShop With " + numExpress + " Express Lanes: ------------------------------------------------------------------------------------------------------------ \n");
   
        //actual simulation part, while events are still happening
        while(events.isEmpty() != true){
        
        //get next event
        currentEvent = events.poll();
        
        //if Arrival event, make a finnished shopping event
        if(currentEvent instanceof ArrivalEvent){
        
            newEvent = new DoneShoppingEvent(currentEvent.getShopper());
            events.add(newEvent);
            numShoppers++;
            numEvents++;
            write = ((ArrivalEvent) currentEvent).getText();
            writeToFile(file, write);
        }
        
        //if DoneShoppingEvent
        if(currentEvent instanceof DoneShoppingEvent){
            
            write = ((DoneShoppingEvent) currentEvent).getText();
            writeToFile(file, write);
            
            numEvents++;
            
            //reset so best lane changes
            shortestLine = 30000;
            
            //pick lane
            if(currentEvent.getShopper().getNumItems() < 13){
                //can use express Lanes, loop through all lanes for shortest line
                
                numExpressShoppers ++;
                
                //since express lanes are listed first, if a regular lane has fewer people in line, the shopper with stay with the express lane. //CHANGE TO 12 LATER!!!
                for(int i = 0; i < totalLanes; i++){
                    if(lanes.get(i).numShoppers < shortestLine){
                    shortestLine = lanes.get(i).numShoppers;
                    bestLane = i;
                    }
                }
                
               
                
                write = ("\t12 or fewer, chose lane " + bestLane + " (" + shortestLine + ")");
                writeToFile(file, write);
                 
            }
            
            else{
                //cannot use express lane, loop through only regular lanes for shortest line
                if(numExpress > 0){ numExpressForLoop = numExpress -1;}
                    for(int i = numExpressForLoop; i < totalLanes; i++){
                        if(lanes.get(i).numShoppers < shortestLine){
                            shortestLine = lanes.get(i).numShoppers;
                            bestLane = i;
                        }
                    }
                    write = "\tchose lane " + bestLane;
                    writeToFile(file, write);
            }
            
            //add shopper to best lane
            lanes.get(bestLane).addShopper(currentEvent.getShopper());
            
            
            //get time for doneCheckoutEvent and add it to events queue
            newEvent = new DoneCheckoutEvent(currentEvent.getShopper());
            newEvent.setTime(lanes.get(bestLane).time());
            newEvent.getShopper().setLane(bestLane);           
            
            events.add(newEvent);
            
        }
        
        
        
        //if DoneCheckoutEvent
        if(currentEvent instanceof DoneCheckoutEvent){
            
            write = ((DoneCheckoutEvent) currentEvent).getText(numExpress);
            writeToFile(file, write);
            
            numEvents++;
            
            //remove shopper from line
            lanes.get(currentEvent.getShopper().line).removeShopper();
            
         
            //updates wait time
            //time arrived, time in store
            double inStore =  (currentEvent.getShopper().getNumItems() * currentEvent.getShopper().getTimePerItem()) + currentEvent.getShopper().getTimeArrived();
            //time checking out
            inStore += ((DoneCheckoutEvent) currentEvent).shopper.getCheckoutTime(numExpress);
            double wait = currentEvent.getTime() - inStore;
            waitTime += wait;
            avgWait = (waitTime/numShoppers);
            
        }
        
        }

        write = ("\nTotal Events: " + numEvents + "\nAverage Wait Time: " + String.format("%.2f",avgWait) + "\nNumber of Express Lanes: " + numExpress + "\nTotal Shoppers: " + numShoppers + "\nNumber Express Shoppers: " + numExpressShoppers +
                " \nEnd Data ------------------------------------------------------------------------------------------------------------------------------ ");
        System.out.println("Number Express Lanes: " + numExpress + "\nWait Time: " + String.format("%.2f", avgWait));
        writeToFile(file, write);
      
        return avgWait;
        
    }
    
    
    //driver, runs simulation with different numbers of express lanes
    public static void main(String[] args) throws FileNotFoundException {
    
        
        int totalOpenLanes = 12;
        double avgWait = 0;
        double previousWait = 0;
        
        
        
        for(totalOpenLanes = 12; totalOpenLanes > 4; totalOpenLanes --){
         
            
            //adds express lanes until wait time goes up, then closes a lane and sets express lanes back to one
                for(int i = 0; i < totalOpenLanes - 1; i++){
                    if(i<3 || avgWait <= previousWait){
                        System.out.println("\nLanes Open:  " + totalOpenLanes);
                        previousWait = avgWait;
                        avgWait = runSimulation(i, totalOpenLanes);
            
                    }  
                    
            }
        }
     
    }
} 
