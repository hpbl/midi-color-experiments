class StopNoteThread extends Thread{
 
   int noteIndex;
 
   public StopNoteThread(int noteIndex){
      this.noteIndex = noteIndex;
   }
 
   public void run(){
      delay(150);
      myBus.sendNoteOff(0, noteIndex, 90); // Send a Midi nodeOff
      delay(75);
      loop();
   }
}
